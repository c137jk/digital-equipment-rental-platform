package com.ruoyi.web.controller.rental;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.rental.domain.RentalReview;
import com.ruoyi.rental.service.IRentalReviewService;

//设备评价Controller

@RestController
@RequestMapping("/rental/review")
public class RentalReviewController extends BaseController {
    @Autowired
    private IRentalReviewService rentalReviewService;

    /**
     * 查询设备评价列表 (公开接口)
     */
    @GetMapping("/list/{equipmentId}")
    public AjaxResult list(@PathVariable Long equipmentId) {
        RentalReview query = new RentalReview();
        query.setEquipmentId(equipmentId);
        List<RentalReview> list = rentalReviewService.selectRentalReviewList(query);
        return success(list);
    }

    /**
     * 提交评价
     */
    @PostMapping
    public AjaxResult add(@RequestBody RentalReview rentalReview) {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        rentalReview.setUserId(loginUser.getUserId());
        rentalReview.setNickName(loginUser.getUser().getNickName());
        // 检查是否已评价
        RentalReview existing = rentalReviewService.selectRentalReviewByOrderId(rentalReview.getOrderId());
        if (existing != null) {
            return error("该订单已评价");
        }
        return toAjax(rentalReviewService.insertRentalReview(rentalReview));
    }

    /**
     * 检查订单是否已评价
     */
    @GetMapping("/check/{orderId}")
    public AjaxResult check(@PathVariable Long orderId) {
        RentalReview review = rentalReviewService.selectRentalReviewByOrderId(orderId);
        return success(review != null);
    }
}
