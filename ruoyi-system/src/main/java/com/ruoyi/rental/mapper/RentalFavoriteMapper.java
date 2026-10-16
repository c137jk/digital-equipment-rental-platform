package com.ruoyi.rental.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.rental.domain.RentalFavorite;

//收藏Mapper接口

public interface RentalFavoriteMapper {
    /**
     * 查询收藏
     * 
     * @param favoriteId 收藏主键
     * @return 收藏
     */
    public RentalFavorite selectRentalFavoriteByFavoriteId(Long favoriteId);

    /**
     * 查询用户收藏列表
     * 
     * @param userId 用户ID
     * @return 收藏集合
     */
    public List<RentalFavorite> selectRentalFavoriteListByUserId(Long userId);

    /**
     * 查询收藏列表
     * 
     * @param rentalFavorite 收藏
     * @return 收藏集合
     */
    public List<RentalFavorite> selectRentalFavoriteList(RentalFavorite rentalFavorite);

    /**
     * 检查是否已收藏
     * 
     * @param userId      用户ID
     * @param equipmentId 设备ID
     * @return 数量
     */
    public int checkFavorite(@Param("userId") Long userId, @Param("equipmentId") Long equipmentId);

    /**
     * 新增收藏
     * 
     * @param rentalFavorite 收藏
     * @return 结果
     */
    public int insertRentalFavorite(RentalFavorite rentalFavorite);

    /**
     * 删除收藏
     * 
     * @param favoriteId 收藏主键
     * @return 结果
     */
    public int deleteRentalFavoriteByFavoriteId(Long favoriteId);

    /**
     * 批量删除收藏
     * 
     * @param favoriteIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteRentalFavoriteByFavoriteIds(Long[] favoriteIds);

    /**
     * 取消收藏(根据用户和设备)
     * 
     * @param userId      用户ID
     * @param equipmentId 设备ID
     * @return 结果
     */
    public int deleteFavoriteByUserAndEquipment(@Param("userId") Long userId, @Param("equipmentId") Long equipmentId);
}
