package com.ruoyi.rental.mapper;

import java.util.List;
import com.ruoyi.rental.domain.RentalCart;

//购物车Mapper接口

public interface RentalCartMapper {
    /**
     * 查询购物车
     * 
     * @param cartId 购物车主键
     * @return 购物车
     */
    public RentalCart selectRentalCartByCartId(Long cartId);

    /**
     * 查询用户购物车列表
     * 
     * @param userId 用户ID
     * @return 购物车集合
     */
    public List<RentalCart> selectRentalCartListByUserId(Long userId);

    /**
     * 查询购物车列表
     * 
     * @param rentalCart 购物车
     * @return 购物车集合
     */
    public List<RentalCart> selectRentalCartList(RentalCart rentalCart);

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
     * 删除购物车
     * 
     * @param cartId 购物车主键
     * @return 结果
     */
    public int deleteRentalCartByCartId(Long cartId);

    /**
     * 批量删除购物车
     * 
     * @param cartIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteRentalCartByCartIds(Long[] cartIds);

    /**
     * 清空用户购物车
     * 
     * @param userId 用户ID
     * @return 结果
     */
    public int deleteRentalCartByUserId(Long userId);
}
