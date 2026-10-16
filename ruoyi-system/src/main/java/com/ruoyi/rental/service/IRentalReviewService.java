package com.ruoyi.rental.service;

import java.util.List;
import com.ruoyi.rental.domain.RentalReview;

public interface IRentalReviewService {
    public List<RentalReview> selectRentalReviewList(RentalReview rentalReview);

    public int insertRentalReview(RentalReview rentalReview);

    public RentalReview selectRentalReviewByOrderId(Long orderId);
}
