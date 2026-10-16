package com.ruoyi.rental.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

//购物车对象 rental_cart

public class RentalCart extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 购物车ID */
    private Long cartId;

    /** 用户ID */
    private Long userId;

    /** 设备ID */
    private Long equipmentId;

    /** 设备信息(关联查询) */
    private RentalEquipment equipment;

    /** 数量 */
    private Integer quantity;

    /** 租赁类型（1日租 2周租 3月租） */
    private String rentalType;

    /** 租赁天数 */
    private Integer rentalDays;

    /** 添加时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    public void setCartId(Long cartId) {
        this.cartId = cartId;
    }

    public Long getCartId() {
        return cartId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setEquipmentId(Long equipmentId) {
        this.equipmentId = equipmentId;
    }

    public Long getEquipmentId() {
        return equipmentId;
    }

    public void setEquipment(RentalEquipment equipment) {
        this.equipment = equipment;
    }

    public RentalEquipment getEquipment() {
        return equipment;
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

    @Override
    public Date getCreateTime() {
        return createTime;
    }

    @Override
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public Date getUpdateTime() {
        return updateTime;
    }

    @Override
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("cartId", getCartId())
                .append("userId", getUserId())
                .append("equipmentId", getEquipmentId())
                .append("quantity", getQuantity())
                .append("rentalType", getRentalType())
                .append("rentalDays", getRentalDays())
                .append("createTime", getCreateTime())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
