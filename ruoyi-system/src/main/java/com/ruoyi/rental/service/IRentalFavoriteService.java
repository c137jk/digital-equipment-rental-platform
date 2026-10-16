package com.ruoyi.rental.service;

import java.util.List;
import com.ruoyi.rental.domain.RentalFavorite;

//收藏Service接口

public interface IRentalFavoriteService {
    /**
     * 查询用户收藏列表
     * 
     * @param userId 用户ID
     * @return 收藏集合
     */
    public List<RentalFavorite> selectRentalFavoriteListByUserId(Long userId);

    /**
     * 查询收藏
     * 
     * @param favoriteId 收藏主键
     * @return 收藏
     */
    public RentalFavorite selectRentalFavoriteByFavoriteId(Long favoriteId);

    /**
     * 检查是否已收藏
     * 
     * @param userId      用户ID
     * @param equipmentId 设备ID
     * @return 结果
     */
    public boolean checkFavorite(Long userId, Long equipmentId);

    /**
     * 新增收藏
     * 
     * @param rentalFavorite 收藏
     * @return 结果
     */
    public int insertRentalFavorite(RentalFavorite rentalFavorite);

    /**
     * 取消收藏
     * 
     * @param userId      用户ID
     * @param equipmentId 设备ID
     * @return 结果
     */
    public int deleteFavoriteByUserAndEquipment(Long userId, Long equipmentId);

    /**
     * 批量删除收藏
     * 
     * @param favoriteIds 需要删除的收藏主键集合
     * @return 结果
     */
    public int deleteRentalFavoriteByFavoriteIds(Long[] favoriteIds);
}
