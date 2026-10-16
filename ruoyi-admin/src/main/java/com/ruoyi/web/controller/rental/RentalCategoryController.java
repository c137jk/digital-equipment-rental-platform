package com.ruoyi.web.controller.rental;

import java.util.List;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.rental.domain.RentalCategory;
import com.ruoyi.rental.service.IRentalCategoryService;


//分类Controller
@RestController
@RequestMapping("/rental/category")
public class RentalCategoryController extends BaseController {
    @Autowired
    private IRentalCategoryService rentalCategoryService;

    /**
     * 查询分类列表 (公开接口,无需权限)
     */
    @GetMapping("/list")
    public AjaxResult list(RentalCategory rentalCategory) {
        List<RentalCategory> list = rentalCategoryService.selectRentalCategoryList(rentalCategory);
        return success(list);
    }

    /**
     * 获取分类详细信息
     */
    @PreAuthorize("@ss.hasPermi('rental:category:query')")
    @GetMapping(value = "/{categoryId}")
    public AjaxResult getInfo(@PathVariable("categoryId") Long categoryId) {
        return success(rentalCategoryService.selectRentalCategoryByCategoryId(categoryId));
    }

    /**
     * 新增分类
     */
    @PreAuthorize("@ss.hasPermi('rental:category:add')")
    @Log(title = "分类", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody RentalCategory rentalCategory) {
        return toAjax(rentalCategoryService.insertRentalCategory(rentalCategory));
    }

    /**
     * 修改分类
     */
    @PreAuthorize("@ss.hasPermi('rental:category:edit')")
    @Log(title = "分类", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody RentalCategory rentalCategory) {
        return toAjax(rentalCategoryService.updateRentalCategory(rentalCategory));
    }

    /**
     * 删除分类
     */
    @PreAuthorize("@ss.hasPermi('rental:category:remove')")
    @Log(title = "分类", businessType = BusinessType.DELETE)
    @DeleteMapping("/{categoryIds}")
    public AjaxResult remove(@PathVariable Long[] categoryIds) {
        return toAjax(rentalCategoryService.deleteRentalCategoryByCategoryIds(categoryIds));
    }
}
