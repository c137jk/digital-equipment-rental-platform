package com.ruoyi.rental.mapper;

import java.util.List;
import com.ruoyi.rental.domain.RentalReview;

public interface RentalReviewMapper {
    public List<RentalReview> selectRentalReviewList(RentalReview rentalReview);

    public int insertRentalReview(RentalReview rentalReview);

    public RentalReview selectRentalReviewByOrderId(Long orderId);
}
