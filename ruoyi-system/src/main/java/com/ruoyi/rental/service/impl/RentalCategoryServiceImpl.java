package com.ruoyi.rental.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.rental.mapper.RentalCategoryMapper;
import com.ruoyi.rental.domain.RentalCategory;
import com.ruoyi.rental.service.IRentalCategoryService;

//分类Service业务层处理

@Service
public class RentalCategoryServiceImpl implements IRentalCategoryService {
    @Autowired
    private RentalCategoryMapper rentalCategoryMapper;

    /**
     * 查询分类列表
     * 
     * @param rentalCategory 分类
     * @return 分类
     */
    @Override
    public List<RentalCategory> selectRentalCategoryList(RentalCategory rentalCategory) {
        return rentalCategoryMapper.selectRentalCategoryList(rentalCategory);
    }

    /**
     * 查询分类
     * 
     * @param categoryId 分类主键
     * @return 分类
     */
    @Override
    public RentalCategory selectRentalCategoryByCategoryId(Long categoryId) {
        return rentalCategoryMapper.selectRentalCategoryByCategoryId(categoryId);
    }

    /**
     * 新增分类
     * 
     * @param rentalCategory 分类
     * @return 结果
     */
    @Override
    public int insertRentalCategory(RentalCategory rentalCategory) {
        rentalCategory.setCreateTime(DateUtils.getNowDate());
        return rentalCategoryMapper.insertRentalCategory(rentalCategory);
    }

    /**
     * 修改分类
     * 
     * @param rentalCategory 分类
     * @return 结果
     */
    @Override
    public int updateRentalCategory(RentalCategory rentalCategory) {
        rentalCategory.setUpdateTime(DateUtils.getNowDate());
        return rentalCategoryMapper.updateRentalCategory(rentalCategory);
    }

    /**
     * 批量删除分类
     * 
     * @param categoryIds 需要删除的分类主键
     * @return 结果
     */
    @Override
    public int deleteRentalCategoryByCategoryIds(Long[] categoryIds) {
        // 级联删除子分类
        rentalCategoryMapper.deleteChildrenByParentIds(categoryIds);
        return rentalCategoryMapper.deleteRentalCategoryByCategoryIds(categoryIds);
    }

    /**
     * 删除分类信息
     * 
     * @param categoryId 分类主键
     * @return 结果
     */
    @Override
    public int deleteRentalCategoryByCategoryId(Long categoryId) {
        // 级联删除子分类
        rentalCategoryMapper.deleteChildrenByParentIds(new Long[] { categoryId });
        return rentalCategoryMapper.deleteRentalCategoryByCategoryId(categoryId);
    }
}
