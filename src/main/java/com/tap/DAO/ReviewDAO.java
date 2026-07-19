package com.tap.DAO;

import java.util.List;

import com.tap.model.Review;

public interface ReviewDAO {
	void addReview(Review review);
	Review getReviewByOrder(int orderId);
	List<Review> getReviewsByRestaurant(int restuarantId);
	double getAverageRating(int restuarantId);
	int getReviewCount(int restuarantId);
}