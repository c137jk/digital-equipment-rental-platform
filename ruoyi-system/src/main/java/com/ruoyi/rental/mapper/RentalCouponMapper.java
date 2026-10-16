package com.ruoyi.rental.mapper;

import java.util.List;
import com.ruoyi.rental.domain.RentalCoupon;

public interface RentalCouponMapper {
    public List<RentalCoupon> selectRentalCouponList(RentalCoupon rentalCoupon);

    public RentalCoupon selectRentalCouponByCouponId(Long couponId);

    public RentalCoupon selectRentalCouponByCode(String couponCode);

    public int insertRentalCoupon(RentalCoupon rentalCoupon);

    public int updateRentalCoupon(RentalCoupon rentalCoupon);

    public int deleteRentalCouponByCouponIds(Long[] couponIds);

    public int incrementUseCount(Long couponId);
}
