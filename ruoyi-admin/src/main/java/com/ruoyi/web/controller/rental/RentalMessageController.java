package com.ruoyi.web.controller.rental;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.rental.domain.RentalMessage;
import com.ruoyi.rental.service.IRentalMessageService;

//消息通知Controller

@RestController
@RequestMapping("/rental/message")
public class RentalMessageController extends BaseController {
    @Autowired
    private IRentalMessageService rentalMessageService;

    /**
     * 获取我的消息列表
     */
    @GetMapping("/mylist")
    public AjaxResult myList() {
        Long userId = SecurityUtils.getUserId();
        RentalMessage query = new RentalMessage();
        query.setUserId(userId);
        List<RentalMessage> list = rentalMessageService.selectRentalMessageList(query);
        return success(list);
    }

    /**
     * 获取未读消息数量
     */
    @GetMapping("/unreadCount")
    public AjaxResult unreadCount() {
        Long userId = SecurityUtils.getUserId();
        int count = rentalMessageService.selectUnreadCount(userId);
        return success(count);
    }

    /**
     * 标记消息为已读
     */
    @PutMapping("/read/{messageId}")
    public AjaxResult read(@PathVariable Long messageId) {
        return toAjax(rentalMessageService.updateMessageRead(messageId));
    }

    /**
     * 全部标记为已读
     */
    @PutMapping("/readAll")
    public AjaxResult readAll() {
        Long userId = SecurityUtils.getUserId();
        return toAjax(rentalMessageService.updateAllRead(userId));
    }
}
