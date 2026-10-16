package com.ruoyi.rental.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.rental.domain.RentalCoupon;
import com.ruoyi.rental.mapper.RentalCouponMapper;
import com.ruoyi.rental.service.IRentalCouponService;

@Service
public class RentalCouponServiceImpl implements IRentalCouponService {
    @Autowired
    private RentalCouponMapper rentalCouponMapper;

    @Override
    public List<RentalCoupon> selectRentalCouponList(RentalCoupon rentalCoupon) {
        return rentalCouponMapper.selectRentalCouponList(rentalCoupon);
    }

    @Override
    public RentalCoupon selectRentalCouponByCouponId(Long couponId) {
        return rentalCouponMapper.selectRentalCouponByCouponId(couponId);
    }

    @Override
    public int insertRentalCoupon(RentalCoupon rentalCoupon) {
        return rentalCouponMapper.insertRentalCoupon(rentalCoupon);
    }

    @Override
    public int updateRentalCoupon(RentalCoupon rentalCoupon) {
        return rentalCouponMapper.updateRentalCoupon(rentalCoupon);
    }

    @Override
    public int deleteRentalCouponByCouponIds(Long[] couponIds) {
        return rentalCouponMapper.deleteRentalCouponByCouponIds(couponIds);
    }

    @Override
    public RentalCoupon validateCoupon(String couponCode, BigDecimal orderAmount) {
        RentalCoupon coupon = rentalCouponMapper.selectRentalCouponByCode(couponCode);
        if (coupon == null) {
            return null;
        }
        // 检查状态
        if (!"0".equals(coupon.getStatus())) {
            return null;
        }
        // 检查使用次数
        if (coupon.getMaxUse() != null && coupon.getMaxUse() > 0 && coupon.getUseCount() >= coupon.getMaxUse()) {
            return null;
        }
        // 检查生效时间
        Date now = new Date();
        if (coupon.getStartTime() != null && now.before(coupon.getStartTime())) {
            return null;
        }
        if (coupon.getEndTime() != null && now.after(coupon.getEndTime())) {
            return null;
        }
        // 检查最低消费
        if (coupon.getMinAmount() != null && orderAmount.compareTo(coupon.getMinAmount()) < 0) {
            return null;
        }
        return coupon;
    }

    @Override
    public void useCoupon(String couponCode) {
        RentalCoupon coupon = rentalCouponMapper.selectRentalCouponByCode(couponCode);
        if (coupon != null) {
            rentalCouponMapper.incrementUseCount(coupon.getCouponId());
        }
    }
}
