package com.ruoyi.rental.mapper;

import java.util.List;
import com.ruoyi.rental.domain.RentalOrder;

//订单Mapper接口

public interface RentalOrderMapper {
    /**
     * 查询订单
     * 
     * @param orderId 订单主键
     * @return 订单
     */
    public RentalOrder selectRentalOrderByOrderId(Long orderId);

    /**
     * 根据订单号查询订单
     * 
     * @param orderNo 订单号
     * @return 订单
     */
    public RentalOrder selectRentalOrderByOrderNo(String orderNo);

    /**
     * 查询订单列表
     * 
     * @param rentalOrder 订单
     * @return 订单集合
     */
    public List<RentalOrder> selectRentalOrderList(RentalOrder rentalOrder);

    /**
     * 新增订单
     * 
     * @param rentalOrder 订单
     * @return 结果
     */
    public int insertRentalOrder(RentalOrder rentalOrder);

    /**
     * 修改订单
     * 
     * @param rentalOrder 订单
     * @return 结果
     */
    public int updateRentalOrder(RentalOrder rentalOrder);

    /**
     * 删除订单
     * 
     * @param orderId 订单主键
     * @return 结果
     */
    public int deleteRentalOrderByOrderId(Long orderId);

    /**
     * 批量删除订单
     * 
     * @param orderIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteRentalOrderByOrderIds(Long[] orderIds);
}
