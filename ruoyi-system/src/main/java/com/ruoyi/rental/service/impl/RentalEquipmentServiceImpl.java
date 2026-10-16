package com.ruoyi.rental.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.rental.mapper.RentalEquipmentMapper;
import com.ruoyi.rental.domain.RentalEquipment;
import com.ruoyi.rental.service.IRentalEquipmentService;

// 设备Service业务层处理
@Service
public class RentalEquipmentServiceImpl implements IRentalEquipmentService {
    @Autowired
    private RentalEquipmentMapper rentalEquipmentMapper;

    /**
     * 查询设备
     * 
     * @param equipmentId 设备主键
     * @return 设备
     */
    @Override
    public RentalEquipment selectRentalEquipmentByEquipmentId(Long equipmentId) {
        return rentalEquipmentMapper.selectRentalEquipmentByEquipmentId(equipmentId);
    }

    /**
     * 查询设备列表
     * 
     * @param rentalEquipment 设备
     * @return 设备
     */
    @Override
    public List<RentalEquipment> selectRentalEquipmentList(RentalEquipment rentalEquipment) {
        return rentalEquipmentMapper.selectRentalEquipmentList(rentalEquipment);
    }

    /**
     * 新增设备
     * 
     * @param rentalEquipment 设备
     * @return 结果
     */
    @Override
    public int insertRentalEquipment(RentalEquipment rentalEquipment) {
        rentalEquipment.setCreateTime(DateUtils.getNowDate());
        return rentalEquipmentMapper.insertRentalEquipment(rentalEquipment);
    }

    /**
     * 修改设备
     * 
     * @param rentalEquipment 设备
     * @return 结果
     */
    @Override
    public int updateRentalEquipment(RentalEquipment rentalEquipment) {
        rentalEquipment.setUpdateTime(DateUtils.getNowDate());
        return rentalEquipmentMapper.updateRentalEquipment(rentalEquipment);
    }

    /**
     * 批量删除设备
     * 
     * @param equipmentIds 需要删除的设备主键
     * @return 结果
     */
    @Override
    public int deleteRentalEquipmentByEquipmentIds(Long[] equipmentIds) {
        return rentalEquipmentMapper.deleteRentalEquipmentByEquipmentIds(equipmentIds);
    }

    /**
     * 删除设备信息
     * 
     * @param equipmentId 设备主键
     * @return 结果
     */
    @Override
    public int deleteRentalEquipmentByEquipmentId(Long equipmentId) {
        return rentalEquipmentMapper.deleteRentalEquipmentByEquipmentId(equipmentId);
    }

    /**
     * 更新设备库存
     * 
     * @param equipmentId 设备ID
     * @param quantity    数量(正数增加,负数减少)
     * @return 结果
     */
    @Override
    public int updateStock(Long equipmentId, Integer quantity) {
        return rentalEquipmentMapper.updateStock(equipmentId, quantity);
    }
}
