package com.ruoyi.rental.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.rental.domain.RentalMessage;
import com.ruoyi.rental.mapper.RentalMessageMapper;
import com.ruoyi.rental.service.IRentalMessageService;

@Service
public class RentalMessageServiceImpl implements IRentalMessageService {
    @Autowired
    private RentalMessageMapper rentalMessageMapper;

    @Override
    public List<RentalMessage> selectRentalMessageList(RentalMessage rentalMessage) {
        return rentalMessageMapper.selectRentalMessageList(rentalMessage);
    }

    @Override
    public int insertRentalMessage(RentalMessage rentalMessage) {
        return rentalMessageMapper.insertRentalMessage(rentalMessage);
    }

    @Override
    public int updateMessageRead(Long messageId) {
        return rentalMessageMapper.updateMessageRead(messageId);
    }

    @Override
    public int updateAllRead(Long userId) {
        return rentalMessageMapper.updateAllRead(userId);
    }

    @Override
    public int selectUnreadCount(Long userId) {
        return rentalMessageMapper.selectUnreadCount(userId);
    }

    @Override
    public void sendMessage(Long userId, String title, String content, String type) {
        RentalMessage message = new RentalMessage();
        message.setUserId(userId);
        message.setTitle(title);
        message.setContent(content);
        message.setType(type);
        rentalMessageMapper.insertRentalMessage(message);
    }
}
