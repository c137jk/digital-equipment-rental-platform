package com.ruoyi.web.controller.rental;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.rental.domain.RentalFavorite;
import com.ruoyi.rental.service.IRentalFavoriteService;

//收藏Controller

@RestController
@RequestMapping("/rental/favorite")
public class RentalFavoriteController extends BaseController {
    @Autowired
    private IRentalFavoriteService rentalFavoriteService;

    /**
     * 查询我的收藏列表
     */
    @GetMapping("/list")
    public AjaxResult list() {
        Long userId = SecurityUtils.getUserId();
        List<RentalFavorite> list = rentalFavoriteService.selectRentalFavoriteListByUserId(userId);
        return success(list);
    }

    /**
     * 检查是否已收藏
     */
    @GetMapping("/check/{equipmentId}")
    public AjaxResult check(@PathVariable("equipmentId") Long equipmentId) {
        Long userId = SecurityUtils.getUserId();
        boolean isFavorite = rentalFavoriteService.checkFavorite(userId, equipmentId);
        return success(isFavorite);
    }

    /**
     * 添加收藏
     */
    @Log(title = "收藏", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody RentalFavorite rentalFavorite) {
        Long userId = SecurityUtils.getUserId();
        rentalFavorite.setUserId(userId);

        // 检查是否已收藏
        if (rentalFavoriteService.checkFavorite(userId, rentalFavorite.getEquipmentId())) {
            return error("已经收藏过该设备");
        }

        return toAjax(rentalFavoriteService.insertRentalFavorite(rentalFavorite));
    }

    /**
     * 取消收藏
     */
    @Log(title = "收藏", businessType = BusinessType.DELETE)
    @DeleteMapping("/{equipmentId}")
    public AjaxResult remove(@PathVariable Long equipmentId) {
        Long userId = SecurityUtils.getUserId();
        return toAjax(rentalFavoriteService.deleteFavoriteByUserAndEquipment(userId, equipmentId));
    }

    /**
     * 批量删除收藏
     */
    @Log(title = "收藏", businessType = BusinessType.DELETE)
    @DeleteMapping("/batch/{favoriteIds}")
    public AjaxResult removeBatch(@PathVariable Long[] favoriteIds) {
        return toAjax(rentalFavoriteService.deleteRentalFavoriteByFavoriteIds(favoriteIds));
    }
}
