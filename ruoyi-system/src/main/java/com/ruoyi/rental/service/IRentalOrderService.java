package com.ruoyi.rental.service;

import java.util.List;
import com.ruoyi.rental.domain.RentalOrder;

//订单Service接口

public interface IRentalOrderService {
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
     * 批量删除订单
     * 
     * @param orderIds 需要删除的订单主键集合
     * @return 结果
     */
    public int deleteRentalOrderByOrderIds(Long[] orderIds);

    /**
     * 删除订单信息
     * 
     * @param orderId 订单主键
     * @return 结果
     */
    public int deleteRentalOrderByOrderId(Long orderId);

    /**
     * 支付订单
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    public int payOrder(Long orderId);

    /**
     * 取消订单
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    public int cancelOrder(Long orderId);

    /**
     * 归还设备
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    public int returnEquipment(Long orderId);

    /**
     * 申请归还(用户上传快递单号)
     * 
     * @param rentalOrder 订单信息(包含快递单号)
     * @return 结果
     */
    public int applyReturn(RentalOrder rentalOrder);

    /**
     * 确认发货(管理员:已支付→租赁中)
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    public int shipOrder(Long orderId);

    /**
     * 确认收货(管理员:归还中→已归还)
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    public int confirmReturn(Long orderId);

    /**
     * 确认归还(标记损坏并扣除押金)
     */
    public int confirmReturnWithDamage(Long orderId, java.math.BigDecimal deductAmount, String deductReason);

    /**
     * 用户申请延期
     */
    public int applyExtend(Long orderId, Integer extendDays);

    /**
     * 管理员审批延期
     */
    public int approveExtend(Long orderId, boolean approved);
}
