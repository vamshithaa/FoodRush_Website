package com.tap.model;

import java.sql.Timestamp;

public class Review {

	private int reviewId;
	private int orderId;
	private int userId;
	private int restuarantId;
	private int rating;
	private String comment;
	private Timestamp createdDate;

	public Review() {
	}

	public Review(int reviewId, int orderId, int userId, int restuarantId, int rating, String comment,
			Timestamp createdDate) {
		this.reviewId = reviewId;
		this.orderId = orderId;
		this.userId = userId;
		this.restuarantId = restuarantId;
		this.rating = rating;
		this.comment = comment;
		this.createdDate = createdDate;
	}

	public int getReviewId() { return reviewId; }
	public void setReviewId(int reviewId) { this.reviewId = reviewId; }
	public int getOrderId() { return orderId; }
	public void setOrderId(int orderId) { this.orderId = orderId; }
	public int getUserId() { return userId; }
	public void setUserId(int userId) { this.userId = userId; }
	public int getRestuarantId() { return restuarantId; }
	public void setRestuarantId(int restuarantId) { this.restuarantId = restuarantId; }
	public int getRating() { return rating; }
	public void setRating(int rating) { this.rating = rating; }
	public String getComment() { return comment; }
	public void setComment(String comment) { this.comment = comment; }
	public Timestamp getCreatedDate() { return createdDate; }
	public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
}