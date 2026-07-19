package com.tap.userDAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.ReviewDAO;
import com.tap.Utility.DBConnection;
import com.tap.model.Review;

public class ReviewDAOImpl implements ReviewDAO {

	public static final String INSERT_QUERY = "INSERT INTO review(orderId,userId,restaurantId,rating,comment,createdDate) values(?,?,?,?,?,?)";
	public static final String SELECT_BY_ORDER_QUERY = "SELECT * FROM review WHERE orderId=?";
	public static final String SELECT_BY_RESTAURANT_QUERY = "SELECT * FROM review WHERE restaurantId=? ORDER BY createdDate DESC";
	public static final String AVG_RATING_QUERY = "SELECT AVG(rating) as avgRating, COUNT(*) as reviewCount FROM review WHERE restaurantId=?";

	@Override
	public void addReview(Review review) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pst = con.prepareStatement(INSERT_QUERY);
			pst.setInt(1, review.getOrderId());
			pst.setInt(2, review.getUserId());
			pst.setInt(3, review.getRestuarantId());
			pst.setInt(4, review.getRating());
			pst.setString(5, review.getComment());
			pst.setTimestamp(6, new Timestamp(System.currentTimeMillis()));

			int i = pst.executeUpdate();
			System.out.println(i + " Row Affected");

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Review getReviewByOrder(int orderId) {
		Connection con = DBConnection.getConnection();
		Review review = null;
		try {
			PreparedStatement pst = con.prepareStatement(SELECT_BY_ORDER_QUERY);
			pst.setInt(1, orderId);
			ResultSet res = pst.executeQuery();

			if (res.next()) {
				review = mapRow(res);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return review;
	}

	@Override
	public List<Review> getReviewsByRestaurant(int restuarantId) {
		Connection con = DBConnection.getConnection();
		List<Review> reviews = new ArrayList<>();
		try {
			PreparedStatement pst = con.prepareStatement(SELECT_BY_RESTAURANT_QUERY);
			pst.setInt(1, restuarantId);
			ResultSet res = pst.executeQuery();

			while (res.next()) {
				reviews.add(mapRow(res));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reviews;
	}

	@Override
	public double getAverageRating(int restuarantId) {
		Connection con = DBConnection.getConnection();
		double avg = 0;
		try {
			PreparedStatement pst = con.prepareStatement(AVG_RATING_QUERY);
			pst.setInt(1, restuarantId);
			ResultSet res = pst.executeQuery();

			if (res.next()) {
				avg = res.getDouble("avgRating");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return avg;
	}

	@Override
	public int getReviewCount(int restuarantId) {
		Connection con = DBConnection.getConnection();
		int count = 0;
		try {
			PreparedStatement pst = con.prepareStatement(AVG_RATING_QUERY);
			pst.setInt(1, restuarantId);
			ResultSet res = pst.executeQuery();

			if (res.next()) {
				count = res.getInt("reviewCount");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	private Review mapRow(ResultSet res) throws SQLException {
		Review review = new Review();
		review.setReviewId(res.getInt("reviewId"));
		review.setOrderId(res.getInt("orderId"));
		review.setUserId(res.getInt("userId"));
		review.setRestuarantId(res.getInt("restaurantId"));
		review.setRating(res.getInt("rating"));
		review.setComment(res.getString("comment"));
		review.setCreatedDate(res.getTimestamp("createdDate"));
		return review;
	}
}