package com.ruoyi.rental.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.rental.mapper.RentalFavoriteMapper;
import com.ruoyi.rental.domain.RentalFavorite;
import com.ruoyi.rental.service.IRentalFavoriteService;

//收藏Service业务层处理

@Service
public class RentalFavoriteServiceImpl implements IRentalFavoriteService {
    @Autowired
    private RentalFavoriteMapper rentalFavoriteMapper;

    /**
     * 查询用户收藏列表
     * 
     * @param userId 用户ID
     * @return 收藏
     */
    @Override
    public List<RentalFavorite> selectRentalFavoriteListByUserId(Long userId) {
        return rentalFavoriteMapper.selectRentalFavoriteListByUserId(userId);
    }

    /**
     * 查询收藏
     * 
     * @param favoriteId 收藏主键
     * @return 收藏
     */
    @Override
    public RentalFavorite selectRentalFavoriteByFavoriteId(Long favoriteId) {
        return rentalFavoriteMapper.selectRentalFavoriteByFavoriteId(favoriteId);
    }

    /**
     * 检查是否已收藏
     * 
     * @param userId      用户ID
     * @param equipmentId 设备ID
     * @return 结果
     */
    @Override
    public boolean checkFavorite(Long userId, Long equipmentId) {
        return rentalFavoriteMapper.checkFavorite(userId, equipmentId) > 0;
    }

    /**
     * 新增收藏
     * 
     * @param rentalFavorite 收藏
     * @return 结果
     */
    @Override
    public int insertRentalFavorite(RentalFavorite rentalFavorite) {
        rentalFavorite.setCreateTime(DateUtils.getNowDate());
        return rentalFavoriteMapper.insertRentalFavorite(rentalFavorite);
    }

    /**
     * 取消收藏
     * 
     * @param userId      用户ID
     * @param equipmentId 设备ID
     * @return 结果
     */
    @Override
    public int deleteFavoriteByUserAndEquipment(Long userId, Long equipmentId) {
        return rentalFavoriteMapper.deleteFavoriteByUserAndEquipment(userId, equipmentId);
    }

    /**
     * 批量删除收藏
     * 
     * @param favoriteIds 需要删除的收藏主键
     * @return 结果
     */
    @Override
    public int deleteRentalFavoriteByFavoriteIds(Long[] favoriteIds) {
        return rentalFavoriteMapper.deleteRentalFavoriteByFavoriteIds(favoriteIds);
    }
}
