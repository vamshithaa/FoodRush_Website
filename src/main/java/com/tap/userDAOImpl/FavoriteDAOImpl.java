package com.tap.userDAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.FavoriteDAO;
import com.tap.Utility.DBConnection;
import com.tap.model.Favorite;

public class FavoriteDAOImpl implements FavoriteDAO {

	public static final String INSERT_QUERY =
			"INSERT INTO favorites(userId, restaurantId) VALUES(?, ?)";

	public static final String DELETE_QUERY =
			"DELETE FROM favorites WHERE userId=? AND restaurantId=?";

	public static final String CHECK_QUERY =
			"SELECT favoriteId FROM favorites WHERE userId=? AND restaurantId=?";

	public static final String SELECT_IDS_BY_USER_QUERY =
			"SELECT restaurantId FROM favorites WHERE userId=?";

	public static final String SELECT_BY_USER_QUERY =
			"SELECT * FROM favorites WHERE userId=?";

	@Override
	public void addFavorite(int userId, int restaurantId) {
		if (isFavorite(userId, restaurantId)) {
			return; // already favorited, nothing to do
		}
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pst = con.prepareStatement(INSERT_QUERY);
			pst.setInt(1, userId);
			pst.setInt(2, restaurantId);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void removeFavorite(int userId, int restaurantId) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pst = con.prepareStatement(DELETE_QUERY);
			pst.setInt(1, userId);
			pst.setInt(2, restaurantId);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean isFavorite(int userId, int restaurantId) {
		boolean exists = false;
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pst = con.prepareStatement(CHECK_QUERY);
			pst.setInt(1, userId);
			pst.setInt(2, restaurantId);
			ResultSet res = pst.executeQuery();
			exists = res.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return exists;
	}

	@Override
	public List<Integer> getFavoriteRestaurantIdsByUser(int userId) {
		List<Integer> ids = new ArrayList<>();
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pst = con.prepareStatement(SELECT_IDS_BY_USER_QUERY);
			pst.setInt(1, userId);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				ids.add(res.getInt("restaurantId"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ids;
	}

	@Override
	public List<Favorite> getFavoritesByUser(int userId) {
		List<Favorite> list = new ArrayList<>();
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pst = con.prepareStatement(SELECT_BY_USER_QUERY);
			pst.setInt(1, userId);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Favorite favorite = new Favorite();
				favorite.setFavoriteId(res.getInt("favoriteId"));
				favorite.setUserId(res.getInt("userId"));
				favorite.setRestaurantId(res.getInt("restaurantId"));
				favorite.setCreatedDate(res.getTimestamp("createdDate"));
				list.add(favorite);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}