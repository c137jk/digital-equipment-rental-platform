package com.ruoyi.rental.service;

import java.math.BigDecimal;
import java.util.List;
import com.ruoyi.rental.domain.RentalCoupon;

public interface IRentalCouponService {
    public List<RentalCoupon> selectRentalCouponList(RentalCoupon rentalCoupon);

    public RentalCoupon selectRentalCouponByCouponId(Long couponId);

    public int insertRentalCoupon(RentalCoupon rentalCoupon);

    public int updateRentalCoupon(RentalCoupon rentalCoupon);

    public int deleteRentalCouponByCouponIds(Long[] couponIds);

    /** 验证优惠码并返回优惠券信息，无效返回null */
    public RentalCoupon validateCoupon(String couponCode, BigDecimal orderAmount);

    /** 使用优惠券（增加使用次数） */
    public void useCoupon(String couponCode);
}
