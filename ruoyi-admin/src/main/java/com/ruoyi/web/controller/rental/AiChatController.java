package com.ruoyi.web.controller.rental;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.rental.domain.RentalEquipment;
import com.ruoyi.rental.service.IRentalEquipmentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;


//AI 客服 Controller
@RestController
@RequestMapping("/rental/ai")
public class AiChatController extends BaseController {

    private static final Logger log = LoggerFactory.getLogger(AiChatController.class);

    // DeepSeek API Key（请在配置文件中配置，不要硬编码）
    private static final String DEEPSEEK_API_KEY = "your-deepseek-api-key-here";
    private static final String DEEPSEEK_URL = "https://api.deepseek.com/chat/completions";

    @Autowired
    private IRentalEquipmentService rentalEquipmentService;

    @PostMapping("/chat")
    public AjaxResult chat(@RequestBody Map<String, String> requestData) {
        String userMessage = requestData.get("message");
        if (userMessage == null || userMessage.trim().isEmpty()) {
            return AjaxResult.error("消息不能为空");
        }

        try {
            // 1. 获取业务数据（查前 50 条上架的设备）
            RentalEquipment queryParams = new RentalEquipment();
            queryParams.setStatus("0"); // 0: 正常
            List<RentalEquipment> equipmentList = rentalEquipmentService.selectRentalEquipmentList(queryParams);

            // 限制给 AI 的设备数量，防止 token 过长
            int limit = Math.min(equipmentList.size(), 30);
            StringBuilder equipmentContext = new StringBuilder("当前平台可租设备列表如下：\n");
            for (int i = 0; i < limit; i++) {
                RentalEquipment eq = equipmentList.get(i);
                equipmentContext.append(String.format("- %s (品牌:%s, 价格:¥%s/天, 库存:%s)\n",
                        eq.getEquipmentName(),
                        eq.getBrand() != null ? eq.getBrand() : "无",
                        eq.getDailyPrice(),
                        eq.getStock()));
            }

            // 2. 组装发给 DeepSeek 的请求
            JSONObject requestBody = new JSONObject();
            requestBody.put("model", "deepseek-chat");

            JSONArray messages = new JSONArray();

            // System prompt
            JSONObject systemMessage = new JSONObject();
            systemMessage.put("role", "system");
            systemMessage.put("content",
                    "你是智能数码设备租赁平台的 AI 专属导购客服。你的任务是根据平台现有的设备库存解答用户疑问并推荐设备。不要推荐平台没有的设备。回答要简明扼要，语气亲切热情。\n\n"
                            + equipmentContext.toString());
            messages.add(systemMessage);

            // User message
            JSONObject userMsgObj = new JSONObject();
            userMsgObj.put("role", "user");
            userMsgObj.put("content", userMessage);
            messages.add(userMsgObj);

            requestBody.put("messages", messages);
            requestBody.put("temperature", 0.7);

            // 3. 发送 HTTP POST 请求到 DeepSeek
            URL url = new URL(DEEPSEEK_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=utf-8");
            conn.setRequestProperty("Accept", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + DEEPSEEK_API_KEY);
            conn.setDoOutput(true);

            String jsonInputString = requestBody.toJSONString();

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // 4. 读取响应
            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader br = new BufferedReader(
                        new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
                StringBuilder response = new StringBuilder();
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }

                JSONObject responseJson = JSON.parseObject(response.toString());
                JSONArray choices = responseJson.getJSONArray("choices");
                if (choices != null && choices.size() > 0) {
                    JSONObject choice = choices.getJSONObject(0);
                    JSONObject message = choice.getJSONObject("message");
                    return AjaxResult.success("操作成功", message.getString("content"));
                }
            } else {
                BufferedReader errorBr = new BufferedReader(
                        new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
                StringBuilder errorResponse = new StringBuilder();
                String line;
                while ((line = errorBr.readLine()) != null) {
                    errorResponse.append(line.trim());
                }
                log.error("DeepSeek API 错误: {}", errorResponse.toString());
                return AjaxResult.error("AI 暂时无法响应，请稍后再试");
            }

        } catch (Exception e) {
            log.error("调用 AI 接口异常", e);
            return AjaxResult.error("系统繁忙");
        }

        return AjaxResult.error("AI 响应异常");
    }
}
