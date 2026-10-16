package com.ruoyi.rental.service;

import java.util.List;
import com.ruoyi.rental.domain.RentalCategory;

//分类Service接口

public interface IRentalCategoryService {
    /**
     * 查询分类列表
     * 
     * @param rentalCategory 分类
     * @return 分类集合
     */
    public List<RentalCategory> selectRentalCategoryList(RentalCategory rentalCategory);

    /**
     * 查询分类
     * 
     * @param categoryId 分类主键
     * @return 分类
     */
    public RentalCategory selectRentalCategoryByCategoryId(Long categoryId);

    /**
     * 新增分类
     * 
     * @param rentalCategory 分类
     * @return 结果
     */
    public int insertRentalCategory(RentalCategory rentalCategory);

    /**
     * 修改分类
     * 
     * @param rentalCategory 分类
     * @return 结果
     */
    public int updateRentalCategory(RentalCategory rentalCategory);

    /**
     * 批量删除分类
     * 
     * @param categoryIds 需要删除的分类主键集合
     * @return 结果
     */
    public int deleteRentalCategoryByCategoryIds(Long[] categoryIds);

    /**
     * 删除分类信息
     * 
     * @param categoryId 分类主键
     * @return 结果
     */
    public int deleteRentalCategoryByCategoryId(Long categoryId);
}
