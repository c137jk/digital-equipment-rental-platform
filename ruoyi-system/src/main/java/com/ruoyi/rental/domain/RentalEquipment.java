package com.ruoyi.rental.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

//设备对象 rental_equipment

public class RentalEquipment extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 设备ID */
    private Long equipmentId;

    /** 设备名称 */
    @Excel(name = "设备名称")
    private String equipmentName;

    /** 分类ID */
    @Excel(name = "分类ID")
    private Long categoryId;

    /** 分类名称 */
    @Excel(name = "分类名称")
    private String categoryName;

    /** 品牌 */
    @Excel(name = "品牌")
    private String brand;

    /** 型号 */
    @Excel(name = "型号")
    private String model;

    /** 配置参数(JSON格式) */
    private String specifications;

    /** 主图片 */
    private String mainImage;

    /** 图片列表(JSON数组) */
    private String images;

    /** 日租价格 */
    @Excel(name = "日租价格")
    private BigDecimal dailyPrice;

    /** 周租价格 */
    @Excel(name = "周租价格")
    private BigDecimal weeklyPrice;

    /** 月租价格 */
    @Excel(name = "月租价格")
    private BigDecimal monthlyPrice;

    /** 押金金额 */
    @Excel(name = "押金金额")
    private BigDecimal deposit;

    /** 库存数量 */
    @Excel(name = "库存数量")
    private Integer stock;

    /** 已租数量 */
    @Excel(name = "已租数量")
    private Integer rentedCount;

    /** 累计租赁次数 */
    @Excel(name = "累计租赁次数")
    private Integer totalRented;

    /** 设备描述 */
    private String description;

    /** 租赁说明 */
    private String rentalNotes;

    /** 状态（0正常 1下架 2维修中） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=下架,2=维修中")
    private String status;

    /** 删除标志（0存在 2删除） */
    private String delFlag;

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

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getBrand() {
        return brand;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getModel() {
        return model;
    }

    public void setSpecifications(String specifications) {
        this.specifications = specifications;
    }

    public String getSpecifications() {
        return specifications;
    }

    public void setMainImage(String mainImage) {
        this.mainImage = mainImage;
    }

    public String getMainImage() {
        return mainImage;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public String getImages() {
        return images;
    }

    public void setDailyPrice(BigDecimal dailyPrice) {
        this.dailyPrice = dailyPrice;
    }

    public BigDecimal getDailyPrice() {
        return dailyPrice;
    }

    public void setWeeklyPrice(BigDecimal weeklyPrice) {
        this.weeklyPrice = weeklyPrice;
    }

    public BigDecimal getWeeklyPrice() {
        return weeklyPrice;
    }

    public void setMonthlyPrice(BigDecimal monthlyPrice) {
        this.monthlyPrice = monthlyPrice;
    }

    public BigDecimal getMonthlyPrice() {
        return monthlyPrice;
    }

    public void setDeposit(BigDecimal deposit) {
        this.deposit = deposit;
    }

    public BigDecimal getDeposit() {
        return deposit;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public Integer getStock() {
        return stock;
    }

    public void setRentedCount(Integer rentedCount) {
        this.rentedCount = rentedCount;
    }

    public Integer getRentedCount() {
        return rentedCount;
    }

    public void setTotalRented(Integer totalRented) {
        this.totalRented = totalRented;
    }

    public Integer getTotalRented() {
        return totalRented;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setRentalNotes(String rentalNotes) {
        this.rentalNotes = rentalNotes;
    }

    public String getRentalNotes() {
        return rentalNotes;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public String getDelFlag() {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("equipmentId", getEquipmentId())
                .append("equipmentName", getEquipmentName())
                .append("categoryId", getCategoryId())
                .append("brand", getBrand())
                .append("model", getModel())
                .append("specifications", getSpecifications())
                .append("mainImage", getMainImage())
                .append("images", getImages())
                .append("dailyPrice", getDailyPrice())
                .append("weeklyPrice", getWeeklyPrice())
                .append("monthlyPrice", getMonthlyPrice())
                .append("deposit", getDeposit())
                .append("stock", getStock())
                .append("rentedCount", getRentedCount())
                .append("totalRented", getTotalRented())
                .append("description", getDescription())
                .append("rentalNotes", getRentalNotes())
                .append("status", getStatus())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .append("remark", getRemark())
                .toString();
    }
}
