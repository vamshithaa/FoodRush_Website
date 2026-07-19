package com.tap.model;

import java.sql.Timestamp;

public class Favorite {
	private int favoriteId;
	private int userId;
	private int restaurantId;
	private Timestamp createdDate;

	public Favorite() {
		super();
	}

	public Favorite(int favoriteId, int userId, int restaurantId, Timestamp createdDate) {
		super();
		this.favoriteId = favoriteId;
		this.userId = userId;
		this.restaurantId = restaurantId;
		this.createdDate = createdDate;
	}

	// convenience constructor for adding a new favorite (no id/date yet)
	public Favorite(int userId, int restaurantId) {
		super();
		this.userId = userId;
		this.restaurantId = restaurantId;
	}

	public int getFavoriteId() { return favoriteId; }
	public void setFavoriteId(int favoriteId) { this.favoriteId = favoriteId; }

	public int getUserId() { return userId; }
	public void setUserId(int userId) { this.userId = userId; }

	public int getRestaurantId() { return restaurantId; }
	public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

	public Timestamp getCreatedDate() { return createdDate; }
	public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }

	@Override
	public String toString() {
		return "Favorite [favoriteId=" + favoriteId + ", userId=" + userId + ", restaurantId=" + restaurantId
				+ ", createdDate=" + createdDate + "]";
	}
}