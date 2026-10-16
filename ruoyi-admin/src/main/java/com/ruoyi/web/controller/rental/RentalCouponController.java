package com.ruoyi.web.controller.rental;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.rental.domain.RentalCoupon;
import com.ruoyi.rental.service.IRentalCouponService;

/**
 * 优惠券Controller
 */
@RestController
@RequestMapping("/rental/coupon")
public class RentalCouponController extends BaseController {
    @Autowired
    private IRentalCouponService rentalCouponService;

    /**
     * 查询优惠券列表 (管理员)
     */
    @PreAuthorize("@ss.hasPermi('rental:coupon:list')")
    @GetMapping("/list")
    public TableDataInfo list(RentalCoupon rentalCoupon) {
        startPage();
        List<RentalCoupon> list = rentalCouponService.selectRentalCouponList(rentalCoupon);
        return getDataTable(list);
    }

    /**
     * 新增优惠券 (管理员)
     */
    @PreAuthorize("@ss.hasPermi('rental:coupon:add')")
    @PostMapping
    public AjaxResult add(@RequestBody RentalCoupon rentalCoupon) {
        return toAjax(rentalCouponService.insertRentalCoupon(rentalCoupon));
    }

    /**
     * 修改优惠券 (管理员)
     */
    @PreAuthorize("@ss.hasPermi('rental:coupon:edit')")
    @PutMapping
    public AjaxResult edit(@RequestBody RentalCoupon rentalCoupon) {
        return toAjax(rentalCouponService.updateRentalCoupon(rentalCoupon));
    }

    /**
     * 删除优惠券 (管理员)
     */
    @PreAuthorize("@ss.hasPermi('rental:coupon:remove')")
    @DeleteMapping("/{couponIds}")
    public AjaxResult remove(@PathVariable Long[] couponIds) {
        return toAjax(rentalCouponService.deleteRentalCouponByCouponIds(couponIds));
    }


//验证优惠码 (用户端)
    @GetMapping("/validate")
    public AjaxResult validate(@RequestParam String couponCode, @RequestParam BigDecimal orderAmount) {
        RentalCoupon coupon = rentalCouponService.validateCoupon(couponCode, orderAmount);
        if (coupon == null) {
            return error("优惠码无效或不满足使用条件");
        }
        Map<String, Object> result = new HashMap<>();
        result.put("couponName", coupon.getCouponName());
        result.put("discountType", coupon.getDiscountType());
        result.put("discountValue", coupon.getDiscountValue());
        // 计算优惠金额
        BigDecimal discount;
        if ("1".equals(coupon.getDiscountType())) {
            // 百分比折扣
            discount = orderAmount.multiply(BigDecimal.ONE.subtract(coupon.getDiscountValue()));
        } else {
            // 固定金额
            discount = coupon.getDiscountValue();
        }
        result.put("discountAmount", discount);
        result.put("finalAmount", orderAmount.subtract(discount));
        return success(result);
    }
}
