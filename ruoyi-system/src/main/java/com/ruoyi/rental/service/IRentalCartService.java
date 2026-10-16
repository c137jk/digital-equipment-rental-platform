package com.ruoyi.rental.service;

import java.util.List;
import com.ruoyi.rental.domain.RentalCart;

//购物车Service接口

public interface IRentalCartService {
    /**
     * 查询用户购物车列表
     * 
     * @param userId 用户ID
     * @return 购物车集合
     */
    public List<RentalCart> selectRentalCartListByUserId(Long userId);

    /**
     * 新增购物车
     * 
     * @param rentalCart 购物车
     * @return 结果
     */
    public int insertRentalCart(RentalCart rentalCart);

    /**
     * 修改购物车
     * 
     * @param rentalCart 购物车
     * @return 结果
     */
    public int updateRentalCart(RentalCart rentalCart);

    /**
     * 批量删除购物车
     * 
     * @param cartIds 需要删除的购物车主键集合
     * @return 结果
     */
    public int deleteRentalCartByCartIds(Long[] cartIds);

    /**
     * 清空用户购物车
     * 
     * @param userId 用户ID
     * @return 结果
     */
    public int clearCart(Long userId);
}
