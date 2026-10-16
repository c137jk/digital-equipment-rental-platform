package com.ruoyi.rental.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.rental.domain.RentalEquipment;

//设备Mapper接口

public interface RentalEquipmentMapper {
    /**
     * 查询设备
     * 
     * @param equipmentId 设备主键
     * @return 设备
     */
    public RentalEquipment selectRentalEquipmentByEquipmentId(Long equipmentId);

    /**
     * 查询设备列表
     * 
     * @param rentalEquipment 设备
     * @return 设备集合
     */
    public List<RentalEquipment> selectRentalEquipmentList(RentalEquipment rentalEquipment);

    /**
     * 新增设备
     * 
     * @param rentalEquipment 设备
     * @return 结果
     */
    public int insertRentalEquipment(RentalEquipment rentalEquipment);

    /**
     * 修改设备
     * 
     * @param rentalEquipment 设备
     * @return 结果
     */
    public int updateRentalEquipment(RentalEquipment rentalEquipment);

    /**
     * 删除设备
     * 
     * @param equipmentId 设备主键
     * @return 结果
     */
    public int deleteRentalEquipmentByEquipmentId(Long equipmentId);

    /**
     * 批量删除设备
     * 
     * @param equipmentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteRentalEquipmentByEquipmentIds(Long[] equipmentIds);

    /**
     * 更新设备库存
     * 
     * @param equipmentId 设备ID
     * @param quantity    数量(正数增加,负数减少)
     * @return 结果
     */
    public int updateStock(@Param("equipmentId") Long equipmentId, @Param("quantity") Integer quantity);
}
