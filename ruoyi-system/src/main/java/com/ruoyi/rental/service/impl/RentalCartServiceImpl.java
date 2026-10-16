package com.ruoyi.rental.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.rental.mapper.RentalCartMapper;
import com.ruoyi.rental.domain.RentalCart;
import com.ruoyi.rental.service.IRentalCartService;

//购物车Service业务层处理

@Service
public class RentalCartServiceImpl implements IRentalCartService {
    @Autowired
    private RentalCartMapper rentalCartMapper;

    /**
     * 查询用户购物车列表
     * 
     * @param userId 用户ID
     * @return 购物车
     */
    @Override
    public List<RentalCart> selectRentalCartListByUserId(Long userId) {
        return rentalCartMapper.selectRentalCartListByUserId(userId);
    }

    /**
     * 新增购物车
     * 
     * @param rentalCart 购物车
     * @return 结果
     */
    @Override
    public int insertRentalCart(RentalCart rentalCart) {
        rentalCart.setCreateTime(DateUtils.getNowDate());
        return rentalCartMapper.insertRentalCart(rentalCart);
    }

    /**
     * 修改购物车
     * 
     * @param rentalCart 购物车
     * @return 结果
     */
    @Override
    public int updateRentalCart(RentalCart rentalCart) {
        rentalCart.setUpdateTime(DateUtils.getNowDate());
        return rentalCartMapper.updateRentalCart(rentalCart);
    }

    /**
     * 批量删除购物车
     * 
     * @param cartIds 需要删除的购物车主键
     * @return 结果
     */
    @Override
    public int deleteRentalCartByCartIds(Long[] cartIds) {
        return rentalCartMapper.deleteRentalCartByCartIds(cartIds);
    }

    /**
     * 清空用户购物车
     * 
     * @param userId 用户ID
     * @return 结果
     */
    @Override
    public int clearCart(Long userId) {
        return rentalCartMapper.deleteRentalCartByUserId(userId);
    }
}
