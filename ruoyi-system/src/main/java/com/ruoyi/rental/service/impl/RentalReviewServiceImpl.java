package com.ruoyi.rental.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.rental.domain.RentalReview;
import com.ruoyi.rental.mapper.RentalReviewMapper;
import com.ruoyi.rental.service.IRentalReviewService;

@Service
public class RentalReviewServiceImpl implements IRentalReviewService {
    @Autowired
    private RentalReviewMapper rentalReviewMapper;

    @Override
    public List<RentalReview> selectRentalReviewList(RentalReview rentalReview) {
        return rentalReviewMapper.selectRentalReviewList(rentalReview);
    }

    @Override
    public int insertRentalReview(RentalReview rentalReview) {
        return rentalReviewMapper.insertRentalReview(rentalReview);
    }

    @Override
    public RentalReview selectRentalReviewByOrderId(Long orderId) {
        return rentalReviewMapper.selectRentalReviewByOrderId(orderId);
    }
}
