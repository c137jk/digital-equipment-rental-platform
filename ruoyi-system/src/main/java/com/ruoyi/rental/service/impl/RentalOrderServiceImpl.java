package com.ruoyi.rental.service.impl;

import java.util.Date;
import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.rental.mapper.RentalOrderMapper;
import com.ruoyi.rental.domain.RentalOrder;
import com.ruoyi.rental.service.IRentalOrderService;
import com.ruoyi.rental.service.IRentalEquipmentService;
import com.ruoyi.rental.service.IRentalMessageService;
import com.ruoyi.rental.service.IRentalCouponService;

//订单Service业务层处理

@Service
public class RentalOrderServiceImpl implements IRentalOrderService {
    @Autowired
    private RentalOrderMapper rentalOrderMapper;

    @Autowired
    private IRentalEquipmentService equipmentService;

    @Autowired
    private IRentalMessageService messageService;

    @Autowired
    private IRentalCouponService couponService;

    /**
     * 查询订单
     * 
     * @param orderId 订单主键
     * @return 订单
     */
    @Override
    public RentalOrder selectRentalOrderByOrderId(Long orderId) {
        return rentalOrderMapper.selectRentalOrderByOrderId(orderId);
    }

    /**
     * 根据订单号查询订单
     * 
     * @param orderNo 订单号
     * @return 订单
     */
    @Override
    public RentalOrder selectRentalOrderByOrderNo(String orderNo) {
        return rentalOrderMapper.selectRentalOrderByOrderNo(orderNo);
    }

    /**
     * 查询订单列表
     * 
     * @param rentalOrder 订单
     * @return 订单
     */
    @Override
    public List<RentalOrder> selectRentalOrderList(RentalOrder rentalOrder) {
        return rentalOrderMapper.selectRentalOrderList(rentalOrder);
    }

    /**
     * 新增订单
     * 
     * @param rentalOrder 订单
     * @return 结果
     */
    @Override
    @Transactional
    public int insertRentalOrder(RentalOrder rentalOrder) {
        // 生成订单号
        rentalOrder.setOrderNo("RO" + IdUtils.fastSimpleUUID());
        rentalOrder.setCreateTime(DateUtils.getNowDate());
        rentalOrder.setStatus("0"); // 待支付

        // 减少库存
        equipmentService.updateStock(rentalOrder.getEquipmentId(), -rentalOrder.getQuantity());

        // 优惠券使用次数+1
        if (rentalOrder.getCouponCode() != null && !rentalOrder.getCouponCode().isEmpty()) {
            couponService.useCoupon(rentalOrder.getCouponCode());
        }

        return rentalOrderMapper.insertRentalOrder(rentalOrder);
    }

    /**
     * 修改订单
     * 
     * @param rentalOrder 订单
     * @return 结果
     */
    @Override
    public int updateRentalOrder(RentalOrder rentalOrder) {
        rentalOrder.setUpdateTime(DateUtils.getNowDate());
        return rentalOrderMapper.updateRentalOrder(rentalOrder);
    }

    /**
     * 批量删除订单
     * 
     * @param orderIds 需要删除的订单主键
     * @return 结果
     */
    @Override
    public int deleteRentalOrderByOrderIds(Long[] orderIds) {
        return rentalOrderMapper.deleteRentalOrderByOrderIds(orderIds);
    }

    /**
     * 删除订单信息
     * 
     * @param orderId 订单主键
     * @return 结果
     */
    @Override
    public int deleteRentalOrderByOrderId(Long orderId) {
        return rentalOrderMapper.deleteRentalOrderByOrderId(orderId);
    }

    /**
     * 支付订单
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    @Override
    public int payOrder(Long orderId) {
        RentalOrder order = new RentalOrder();
        order.setOrderId(orderId);
        order.setStatus("1"); // 已支付
        order.setPayTime(new Date());
        int result = updateRentalOrder(order);
        // 发送支付成功通知
        RentalOrder fullOrder = selectRentalOrderByOrderId(orderId);
        if (fullOrder != null) {
            messageService.sendMessage(fullOrder.getUserId(), "支付成功",
                    "您的订单 " + fullOrder.getOrderNo() + " 已支付成功，请等待发货。", "order");
        }
        return result;
    }

    /**
     * 取消订单
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    @Override
    @Transactional
    public int cancelOrder(Long orderId) {
        RentalOrder order = selectRentalOrderByOrderId(orderId);
        if (order != null && "0".equals(order.getStatus())) {
            // 恢复库存
            equipmentService.updateStock(order.getEquipmentId(), order.getQuantity());

            // 更新订单状态
            RentalOrder updateOrder = new RentalOrder();
            updateOrder.setOrderId(orderId);
            updateOrder.setStatus("5"); // 已取消
            return updateRentalOrder(updateOrder);
        }
        return 0;
    }

    /**
     * 归还设备
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    @Override
    @Transactional
    public int returnEquipment(Long orderId) {
        RentalOrder order = selectRentalOrderByOrderId(orderId);
        if (order != null && "2".equals(order.getStatus())) {
            // 恢复库存
            equipmentService.updateStock(order.getEquipmentId(), order.getQuantity());

            // 更新订单状态
            RentalOrder updateOrder = new RentalOrder();
            updateOrder.setOrderId(orderId);
            updateOrder.setStatus("4"); // 已归还
            updateOrder.setActualReturnTime(new Date());
            updateOrder.setRefundDeposit(order.getDepositAmount()); // 退还押金
            int result = updateRentalOrder(updateOrder);
            // 发送归还成功通知
            messageService.sendMessage(order.getUserId(), "归还成功",
                    "您的订单 " + order.getOrderNo() + " 已确认归还，押金¥" + order.getDepositAmount() + "已退还。", "order");
            return result;
        }
        return 0;
    }

    /**
     * 申请归还(用户上传快递单号)
     * 
     * @param rentalOrder 订单信息(包含快递单号)
     * @return 结果
     */
    @Override
    public int applyReturn(RentalOrder rentalOrder) {
        RentalOrder updateOrder = new RentalOrder();
        updateOrder.setOrderId(rentalOrder.getOrderId());
        updateOrder.setStatus("3"); // 归还中
        updateOrder.setReturnExpressNo(rentalOrder.getReturnExpressNo());
        updateOrder.setReturnExpressCompany(rentalOrder.getReturnExpressCompany());
        updateOrder.setReturnApplyTime(new Date());
        return updateRentalOrder(updateOrder);
    }

    /**
     * 确认发货(管理员:已支付→租赁中)
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    @Override
    public int shipOrder(Long orderId) {
        RentalOrder existOrder = selectRentalOrderByOrderId(orderId);
        if (existOrder == null) {
            return 0;
        }

        RentalOrder order = new RentalOrder();
        order.setOrderId(orderId);
        order.setStatus("2"); // 租赁中

        // 设置开始时间为当前时间
        Date startTime = new Date();
        order.setStartTime(startTime);

        // 根据租赁类型和天数计算结束时间
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(startTime);

        String rentalType = existOrder.getRentalType();
        Integer rentalDays = existOrder.getRentalDays();

        if ("1".equals(rentalType)) {
            // 日租：按天数计算
            calendar.add(java.util.Calendar.DAY_OF_MONTH, rentalDays != null ? rentalDays : 1);
        } else if ("2".equals(rentalType)) {
            // 周租：7天
            calendar.add(java.util.Calendar.DAY_OF_MONTH, 7);
        } else if ("3".equals(rentalType)) {
            // 月租：30天
            calendar.add(java.util.Calendar.DAY_OF_MONTH, 30);
        }

        order.setEndTime(calendar.getTime());

        int result = updateRentalOrder(order);
        // 发送发货通知
        messageService.sendMessage(existOrder.getUserId(), "发货通知",
                "您的订单 " + existOrder.getOrderNo() + " 已发货，设备已进入租赁中状态。", "order");
        return result;
    }

    /**
     * 确认收货(管理员:归还中→已归还)
     * 
     * @param orderId 订单ID
     * @return 结果
     */
    @Override
    @Transactional
    public int confirmReturn(Long orderId) {
        RentalOrder order = selectRentalOrderByOrderId(orderId);
        if (order != null && "3".equals(order.getStatus())) {
            // 恢复库存
            equipmentService.updateStock(order.getEquipmentId(), order.getQuantity());

            // 更新订单状态
            RentalOrder updateOrder = new RentalOrder();
            updateOrder.setOrderId(orderId);
            updateOrder.setStatus("4"); // 已归还
            updateOrder.setActualReturnTime(new Date());
            updateOrder.setRefundDeposit(order.getDepositAmount()); // 退还押金
            int result = updateRentalOrder(updateOrder);
            messageService.sendMessage(order.getUserId(), "归还确认",
                    "您的订单 " + order.getOrderNo() + " 已确认归还，押金¥" + order.getDepositAmount() + "已退还。", "order");
            return result;
        }
        return 0;
    }

    /**
     * 确认归还(标记损坏并扣除押金)
     */
    @Override
    @Transactional
    public int confirmReturnWithDamage(Long orderId, java.math.BigDecimal deductAmount, String deductReason) {
        RentalOrder order = selectRentalOrderByOrderId(orderId);
        if (order != null && "3".equals(order.getStatus())) {
            // 恢复库存
            equipmentService.updateStock(order.getEquipmentId(), order.getQuantity());

            // 计算退还押金 = 押金 - 扣除金额
            java.math.BigDecimal refund = order.getDepositAmount().subtract(deductAmount);
            if (refund.compareTo(java.math.BigDecimal.ZERO) < 0) {
                refund = java.math.BigDecimal.ZERO;
            }

            RentalOrder updateOrder = new RentalOrder();
            updateOrder.setOrderId(orderId);
            updateOrder.setStatus("4"); // 已归还
            updateOrder.setActualReturnTime(new Date());
            updateOrder.setIsDamaged("1");
            updateOrder.setDeductAmount(deductAmount);
            updateOrder.setDeductReason(deductReason);
            updateOrder.setRefundDeposit(refund);
            int result = updateRentalOrder(updateOrder);

            messageService.sendMessage(order.getUserId(), "归还确认(设备损坏)",
                    "您的订单 " + order.getOrderNo() + " 已确认归还。因设备损坏(" + deductReason
                            + ")，扣除押金¥" + deductAmount + "，退还¥" + refund + "。",
                    "order");
            return result;
        }
        return 0;
    }

    /**
     * 用户申请延期
     */
    @Override
    public int applyExtend(Long orderId, Integer extendDays) {
        RentalOrder order = selectRentalOrderByOrderId(orderId);
        if (order != null && "2".equals(order.getStatus())) {
            // 计算延期费用 = 日单价 * 延期天数
            java.math.BigDecimal fee = order.getUnitPrice().multiply(new java.math.BigDecimal(extendDays));

            RentalOrder updateOrder = new RentalOrder();
            updateOrder.setOrderId(orderId);
            updateOrder.setExtendDays(extendDays);
            updateOrder.setExtendStatus("0"); // 待审批
            updateOrder.setExtendFee(fee);
            int result = updateRentalOrder(updateOrder);

            messageService.sendMessage(order.getUserId(), "延期申请已提交",
                    "您的订单 " + order.getOrderNo() + " 延期 " + extendDays + " 天的申请已提交，延期费用¥" + fee + "，请等待审批。", "order");
            return result;
        }
        return 0;
    }

    /**
     * 管理员审批延期
     */
    @Override
    @Transactional
    public int approveExtend(Long orderId, boolean approved) {
        RentalOrder order = selectRentalOrderByOrderId(orderId);
        if (order != null && "0".equals(order.getExtendStatus())) {
            RentalOrder updateOrder = new RentalOrder();
            updateOrder.setOrderId(orderId);

            if (approved) {
                updateOrder.setExtendStatus("1"); // 已批准
                // 更新结束时间
                java.util.Calendar cal = java.util.Calendar.getInstance();
                cal.setTime(order.getEndTime());
                cal.add(java.util.Calendar.DAY_OF_MONTH, order.getExtendDays());
                updateOrder.setEndTime(cal.getTime());
                // 更新租赁天数和金额
                updateOrder.setRentalDays(order.getRentalDays() + order.getExtendDays());
                java.math.BigDecimal newRentalAmount = order.getRentalAmount().add(order.getExtendFee());
                updateOrder.setRentalAmount(newRentalAmount);
                updateOrder.setTotalAmount(newRentalAmount.add(order.getDepositAmount()));

                messageService.sendMessage(order.getUserId(), "延期申请已批准",
                        "您的订单 " + order.getOrderNo() + " 延期 " + order.getExtendDays()
                                + " 天的申请已批准，新结束日期为 " + cal.getTime() + "。",
                        "order");
            } else {
                updateOrder.setExtendStatus("2"); // 已拒绝
                messageService.sendMessage(order.getUserId(), "延期申请被拒绝",
                        "您的订单 " + order.getOrderNo() + " 延期申请被拒绝，请按原定日期归还设备。", "order");
            }
            return updateRentalOrder(updateOrder);
        }
        return 0;
    }
}
