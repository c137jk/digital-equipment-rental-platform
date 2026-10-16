package com.ruoyi.rental.service;

import java.util.List;
import com.ruoyi.rental.domain.RentalMessage;

public interface IRentalMessageService {
    public List<RentalMessage> selectRentalMessageList(RentalMessage rentalMessage);

    public int insertRentalMessage(RentalMessage rentalMessage);

    public int updateMessageRead(Long messageId);

    public int updateAllRead(Long userId);

    public int selectUnreadCount(Long userId);

    /** 便捷方法：发送通知 */
    public void sendMessage(Long userId, String title, String content, String type);
}
