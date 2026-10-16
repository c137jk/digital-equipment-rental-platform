package com.ruoyi.rental.mapper;

import java.util.List;
import com.ruoyi.rental.domain.RentalCategory;

//设备分类Mapper接口

public interface RentalCategoryMapper {
    /**
     * 查询设备分类
     * 
     * @param categoryId 设备分类主键
     * @return 设备分类
     */
    public RentalCategory selectRentalCategoryByCategoryId(Long categoryId);

    /**
     * 查询设备分类列表
     * 
     * @param rentalCategory 设备分类
     * @return 设备分类集合
     */
    public List<RentalCategory> selectRentalCategoryList(RentalCategory rentalCategory);

    /**
     * 新增设备分类
     * 
     * @param rentalCategory 设备分类
     * @return 结果
     */
    public int insertRentalCategory(RentalCategory rentalCategory);

    /**
     * 修改设备分类
     * 
     * @param rentalCategory 设备分类
     * @return 结果
     */
    public int updateRentalCategory(RentalCategory rentalCategory);

    /**
     * 删除设备分类
     * 
     * @param categoryId 设备分类主键
     * @return 结果
     */
    public int deleteRentalCategoryByCategoryId(Long categoryId);

    /**
     * 批量删除设备分类
     * 
     * @param categoryIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteRentalCategoryByCategoryIds(Long[] categoryIds);

    /**
     * 级联删除子分类
     * 
     * @param categoryIds 父分类主键集合
     * @return 结果
     */
    public int deleteChildrenByParentIds(Long[] categoryIds);
}
