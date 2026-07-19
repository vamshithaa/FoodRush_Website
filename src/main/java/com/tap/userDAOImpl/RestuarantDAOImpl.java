package com.tap.userDAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.RestuarantDAO;
import com.tap.Utility.DBConnection;
import com.tap.model.Restuarant;


public class RestuarantDAOImpl implements RestuarantDAO {
	public static final String INSERT_QUERY="INSERT INTO restaurant(resName,cuisineType,deliveryTime,Address,imagePath,rating,isActive,ownerId,offerActive,offerPercent) values(?,?,?,?,?,?,?,?,?,?)";
	public static final String SELECT_QUERY="SELECT * FROM restaurant WHERE restaurantId=?";
	public static final String DELETE_QUERY="DELETE FROM restaurant WHERE restaurantId=?";
	public static final String UPDATE_QUERY="UPDATE restaurant SET resName=?,cuisineType=?,deliveryTime=?,Address=?,imagePath=?,rating=?,isActive=?,ownerId=?,offerActive=?,offerPercent=? WHERE restaurantId=?";
	public static final String SELECT_ALL_QUERY="SELECT * FROM restaurant";
	public static final String SELECT_BY_OWNER_QUERY="SELECT * FROM restaurant WHERE ownerId=?";
	public static final String UPDATE_OFFER_QUERY="UPDATE restaurant SET offerActive=?,offerPercent=? WHERE restaurantId=?";
	
	@Override
	public void addRestuarant(Restuarant restuarant) {

		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(INSERT_QUERY);
			pst.setString(1,restuarant.getResName());
			pst.setString(2, restuarant.getCuisineType());
			pst.setTimestamp(3, restuarant.getDeliveryTime());
			pst.setString(4, restuarant.getAddress());
			pst.setString(5, restuarant.getImagePath());
			pst.setFloat(6, restuarant.getRating());
			pst.setBoolean(7, restuarant.isActive());
			if (restuarant.getOwnerId() != null) {
				pst.setInt(8, restuarant.getOwnerId());
			} else {
				pst.setNull(8, java.sql.Types.INTEGER);
			}
			pst.setBoolean(9, restuarant.isOfferActive());
			pst.setInt(10, restuarant.getOfferPercent());

			int i=pst.executeUpdate();
			System.out.println(i+" Row Updated");

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public Restuarant getRestuarant(int restuarantId) {
		Restuarant restuarant=null;
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(SELECT_QUERY);
			pst.setInt(1,restuarantId);
			ResultSet res=pst.executeQuery();

			while(res.next()) {
				restuarant = mapRow(res);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return restuarant;
	}

	@Override
	public void deleteRestuarant(int restaurantId) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(DELETE_QUERY);
			pst.setInt(1, restaurantId);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void updateRestuarant(Restuarant restuarant) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(UPDATE_QUERY);
			pst.setString(1,restuarant.getResName());
			pst.setString(2, restuarant.getCuisineType());
			pst.setTimestamp(3, restuarant.getDeliveryTime());
			pst.setString(4, restuarant.getAddress());
			pst.setString(5, restuarant.getImagePath());
			pst.setFloat(6, restuarant.getRating());
			pst.setBoolean(7, restuarant.isActive());
			if (restuarant.getOwnerId() != null) {
				pst.setInt(8, restuarant.getOwnerId());
			} else {
				pst.setNull(8, java.sql.Types.INTEGER);
			}
			pst.setBoolean(9, restuarant.isOfferActive());
			pst.setInt(10, restuarant.getOfferPercent());
			pst.setInt(11, restuarant.getRestuarantId());

			int i=pst.executeUpdate();
			System.out.println(i+" Row Affected");

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void updateOffer(int restuarantId, boolean offerActive, int offerPercent) {
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pst = con.prepareStatement(UPDATE_OFFER_QUERY);
			pst.setBoolean(1, offerActive);
			pst.setInt(2, offerPercent);
			pst.setInt(3, restuarantId);

			int i = pst.executeUpdate();
			System.out.println(i + " Row Affected (offer update)");

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Restuarant> getAllRestuarant() {

		List<Restuarant> list=new ArrayList<>();
		Connection con=DBConnection.getConnection();

		try {
			PreparedStatement st=con.prepareStatement(SELECT_ALL_QUERY);
			ResultSet res=st.executeQuery();

			while(res.next()) {
				list.add(mapRow(res));
			}


		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	
	@Override
	public Restuarant getRestuarantByOwnerId(int ownerId) {
		Restuarant restuarant = null;
		Connection con = DBConnection.getConnection();
		try {
			PreparedStatement pst = con.prepareStatement(SELECT_BY_OWNER_QUERY);
			pst.setInt(1, ownerId);
			ResultSet res = pst.executeQuery();

			if (res.next()) {
				restuarant = mapRow(res);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return restuarant;
	}

	private Restuarant mapRow(ResultSet res) throws SQLException {
		Restuarant restuarant = new Restuarant();
		restuarant.setRestuarantId(res.getInt("restaurantId"));
		restuarant.setResName(res.getString("resName"));
		restuarant.setCuisineType(res.getString("cuisineType"));
		restuarant.setDeliveryTime(res.getTimestamp("deliveryTime"));
		restuarant.setAddress(res.getString("Address"));
		restuarant.setImagePath(res.getString("imagePath"));
		restuarant.setRating(res.getFloat("rating"));
		restuarant.setActive(res.getBoolean("isActive"));
		restuarant.setOfferActive(res.getBoolean("offerActive"));
		restuarant.setOfferPercent(res.getInt("offerPercent"));

		int ownerId = res.getInt("ownerId");
		restuarant.setOwnerId(res.wasNull() ? null : ownerId);

		return restuarant;
	}
}
