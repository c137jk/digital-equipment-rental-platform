package com.ruoyi.rental.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.rental.domain.RentalMessage;

public interface RentalMessageMapper {
    public List<RentalMessage> selectRentalMessageList(RentalMessage rentalMessage);

    public int insertRentalMessage(RentalMessage rentalMessage);

    public int updateMessageRead(@Param("messageId") Long messageId);

    public int updateAllRead(@Param("userId") Long userId);

    public int selectUnreadCount(@Param("userId") Long userId);
}
