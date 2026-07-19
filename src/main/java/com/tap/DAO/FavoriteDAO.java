package com.tap.DAO;

import java.util.List;

import com.tap.model.Favorite;

public interface FavoriteDAO {
	void addFavorite(int userId, int restaurantId);
	void removeFavorite(int userId, int restaurantId);
	boolean isFavorite(int userId, int restaurantId);
	List<Integer> getFavoriteRestaurantIdsByUser(int userId);
	List<Favorite> getFavoritesByUser(int userId);
}