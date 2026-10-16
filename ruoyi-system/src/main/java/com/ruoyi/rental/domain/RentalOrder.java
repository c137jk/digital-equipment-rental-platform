package com.ruoyi.rental.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

//订单对象 rental_order

public class RentalOrder extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 订单ID */
    private Long orderId;

    /** 订单号 */
    @Excel(name = "订单号")
    private String orderNo;

    /** 用户ID */
    private Long userId;

    /** 用户名称 */
    @Excel(name = "用户名称")
    private String userName;

    /** 设备ID */
    private Long equipmentId;

    /** 设备名称 */
    @Excel(name = "设备名称")
    private String equipmentName;

    /** 租赁数量 */
    @Excel(name = "租赁数量")
    private Integer quantity;

    /** 租赁类型（1日租 2周租 3月租） */
    @Excel(name = "租赁类型", readConverterExp = "1=日租,2=周租,3=月租")
    private String rentalType;

    /** 租赁天数 */
    @Excel(name = "租赁天数")
    private Integer rentalDays;

    /** 租赁开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "租赁开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    /** 租赁结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "租赁结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    /** 租赁单价 */
    @Excel(name = "租赁单价")
    private BigDecimal unitPrice;

    /** 租赁金额 */
    @Excel(name = "租赁金额")
    private BigDecimal rentalAmount;

    /** 押金金额 */
    @Excel(name = "押金金额")
    private BigDecimal depositAmount;

    /** 订单总金额 */
    @Excel(name = "订单总金额")
    private BigDecimal totalAmount;

    /** 订单状态（0待支付 1已支付 2租赁中 3已归还 4已取消 5已退款） */
    @Excel(name = "订单状态", readConverterExp = "0=待支付,1=已支付,2=租赁中,3=已归还,4=已取消,5=已退款")
    private String status;

    /** 支付时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date payTime;

    /** 归还时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date returnTime;

    /** 实际归还时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date actualReturnTime;

    /** 是否逾期（0否 1是） */
    private String isOverdue;

    /** 逾期天数 */
    private Integer overdueDays;

    /** 逾期费用 */
    private BigDecimal overdueFee;

    /** 退还押金 */
    private BigDecimal refundDeposit;

    /** 扣除金额 */
    private BigDecimal deductAmount;

    /** 扣除原因 */
    private String deductReason;

    /** 用户备注 */
    private String userRemark;

    /** 管理员备注 */
    private String adminRemark;

    /** 收货人姓名 */
    @Excel(name = "收货人")
    private String receiverName;

    /** 收货人电话 */
    @Excel(name = "收货电话")
    private String receiverPhone;

    /** 收货地址 */
    @Excel(name = "收货地址")
    private String receiverAddress;

    /** 归还快递单号 */
    private String returnExpressNo;

    /** 归还快递公司 */
    private String returnExpressCompany;

    /** 申请归还时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date returnApplyTime;

    /** 使用的优惠码 */
    private String couponCode;

    /** 优惠金额 */
    private BigDecimal discountAmount;

    /** 延期天数 */
    private Integer extendDays;

    /** 延期状态(0待审批 1已批准 2已拒绝) */
    private String extendStatus;

    /** 延期费用 */
    private BigDecimal extendFee;

    /** 是否损坏(0正常 1损坏) */
    private String isDamaged;

    /** 删除标志（0存在 2删除） */
    private String delFlag;

    // Getters and Setters
    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserName() {
        return userName;
    }

    public void setEquipmentId(Long equipmentId) {
        this.equipmentId = equipmentId;
    }

    public Long getEquipmentId() {
        return equipmentId;
    }

    public void setEquipmentName(String equipmentName) {
        this.equipmentName = equipmentName;
    }

    public String getEquipmentName() {
        return equipmentName;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setRentalType(String rentalType) {
        this.rentalType = rentalType;
    }

    public String getRentalType() {
        return rentalType;
    }

    public void setRentalDays(Integer rentalDays) {
        this.rentalDays = rentalDays;
    }

    public Integer getRentalDays() {
        return rentalDays;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setRentalAmount(BigDecimal rentalAmount) {
        this.rentalAmount = rentalAmount;
    }

    public BigDecimal getRentalAmount() {
        return rentalAmount;
    }

    public void setDepositAmount(BigDecimal depositAmount) {
        this.depositAmount = depositAmount;
    }

    public BigDecimal getDepositAmount() {
        return depositAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setReturnTime(Date returnTime) {
        this.returnTime = returnTime;
    }

    public Date getReturnTime() {
        return returnTime;
    }

    public void setActualReturnTime(Date actualReturnTime) {
        this.actualReturnTime = actualReturnTime;
    }

    public Date getActualReturnTime() {
        return actualReturnTime;
    }

    public void setIsOverdue(String isOverdue) {
        this.isOverdue = isOverdue;
    }

    public String getIsOverdue() {
        return isOverdue;
    }

    public void setOverdueDays(Integer overdueDays) {
        this.overdueDays = overdueDays;
    }

    public Integer getOverdueDays() {
        return overdueDays;
    }

    public void setOverdueFee(BigDecimal overdueFee) {
        this.overdueFee = overdueFee;
    }

    public BigDecimal getOverdueFee() {
        return overdueFee;
    }

    public void setRefundDeposit(BigDecimal refundDeposit) {
        this.refundDeposit = refundDeposit;
    }

    public BigDecimal getRefundDeposit() {
        return refundDeposit;
    }

    public void setDeductAmount(BigDecimal deductAmount) {
        this.deductAmount = deductAmount;
    }

    public BigDecimal getDeductAmount() {
        return deductAmount;
    }

    public void setDeductReason(String deductReason) {
        this.deductReason = deductReason;
    }

    public String getDeductReason() {
        return deductReason;
    }

    public void setUserRemark(String userRemark) {
        this.userRemark = userRemark;
    }

    public String getUserRemark() {
        return userRemark;
    }

    public void setAdminRemark(String adminRemark) {
        this.adminRemark = adminRemark;
    }

    public String getAdminRemark() {
        return adminRemark;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReturnExpressNo(String returnExpressNo) {
        this.returnExpressNo = returnExpressNo;
    }

    public String getReturnExpressNo() {
        return returnExpressNo;
    }

    public void setReturnExpressCompany(String returnExpressCompany) {
        this.returnExpressCompany = returnExpressCompany;
    }

    public String getReturnExpressCompany() {
        return returnExpressCompany;
    }

    public void setReturnApplyTime(Date returnApplyTime) {
        this.returnApplyTime = returnApplyTime;
    }

    public Date getReturnApplyTime() {
        return returnApplyTime;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setExtendDays(Integer extendDays) {
        this.extendDays = extendDays;
    }

    public Integer getExtendDays() {
        return extendDays;
    }

    public void setExtendStatus(String extendStatus) {
        this.extendStatus = extendStatus;
    }

    public String getExtendStatus() {
        return extendStatus;
    }

    public void setExtendFee(BigDecimal extendFee) {
        this.extendFee = extendFee;
    }

    public BigDecimal getExtendFee() {
        return extendFee;
    }

    public void setIsDamaged(String isDamaged) {
        this.isDamaged = isDamaged;
    }

    public String getIsDamaged() {
        return isDamaged;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("orderId", getOrderId())
                .append("orderNo", getOrderNo())
                .append("userId", getUserId())
                .append("equipmentId", getEquipmentId())
                .append("equipmentName", getEquipmentName())
                .append("quantity", getQuantity())
                .append("rentalType", getRentalType())
                .append("rentalDays", getRentalDays())
                .append("startTime", getStartTime())
                .append("endTime", getEndTime())
                .append("unitPrice", getUnitPrice())
                .append("rentalAmount", getRentalAmount())
                .append("depositAmount", getDepositAmount())
                .append("totalAmount", getTotalAmount())
                .append("status", getStatus())
                .append("payTime", getPayTime())
                .append("returnTime", getReturnTime())
                .append("actualReturnTime", getActualReturnTime())
                .append("isOverdue", getIsOverdue())
                .append("overdueDays", getOverdueDays())
                .append("overdueFee", getOverdueFee())
                .append("refundDeposit", getRefundDeposit())
                .append("deductAmount", getDeductAmount())
                .append("deductReason", getDeductReason())
                .append("userRemark", getUserRemark())
                .append("adminRemark", getAdminRemark())
                .append("receiverName", getReceiverName())
                .append("receiverPhone", getReceiverPhone())
                .append("receiverAddress", getReceiverAddress())
                .append("returnExpressNo", getReturnExpressNo())
                .append("returnExpressCompany", getReturnExpressCompany())
                .append("returnApplyTime", getReturnApplyTime())
                .append("couponCode", getCouponCode())
                .append("discountAmount", getDiscountAmount())
                .append("extendDays", getExtendDays())
                .append("extendStatus", getExtendStatus())
                .append("extendFee", getExtendFee())
                .append("isDamaged", getIsDamaged())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
