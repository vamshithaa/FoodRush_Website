package com.tap.userDAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderDAO;
import com.tap.Utility.DBConnection;
import com.tap.model.Order;

public class OrderDAOImpl implements OrderDAO {
	public static final String INSERT_QUERY="INSERT INTO `order`(userId,restuarantId,orderDate,totalAmount,status,paymentMethod) values(?,?,?,?,?,?)";
	public static final String SELECT_QUERY="SELECT * FROM `order` WHERE OrderId=?";
	public static final String DELETE_QUERY="DELETE FROM `order` WHERE OrderId=?";
	public static final String UPDATE_QUERY="UPDATE `order` SET userId=?,restuarantId=?,orderDate=?,totalAmount=?,status=?,paymentMethod=? WHERE OrderId=?";
	public static final String SELECT_ALL_QUERY="SELECT * FROM `order`";
	public static final String SELECT_BY_USER_QUERY ="SELECT * FROM `order` WHERE userId=? ORDER BY orderDate DESC";
	public static final String SELECT_BY_RESTAURANT_QUERY ="SELECT * FROM `order` WHERE restuarantId=? ORDER BY orderDate DESC";
	
	@Override
	public int addOrder(Order order) {

	    int orderId = 0;

	    Connection con = DBConnection.getConnection();

	    try {

	        PreparedStatement pst = con.prepareStatement(
	                INSERT_QUERY,
	                Statement.RETURN_GENERATED_KEYS);

	        pst.setInt(1, order.getUserId());
	        pst.setInt(2, order.getRestuarantId());
	        pst.setTimestamp(3, new Timestamp(order.getOrderDate().getTime()));
	        pst.setDouble(4, order.getTotalAmount());
	        pst.setString(5, order.getStatus());
	        pst.setString(6, order.getPaymentMethod());

	        int i = pst.executeUpdate();

	        if(i > 0) {

	            ResultSet rs = pst.getGeneratedKeys();

	            if(rs.next()) {
	                orderId = rs.getInt(1);
	            }
	        }

	        System.out.println("Inserted Rows : " + i);

	    }
	    catch(SQLException e) {
	        e.printStackTrace();
	    }

	    return orderId;
	}
	@Override
	public Order getOrder(int OrderId) {
		Order order=null;
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(SELECT_QUERY);
			pst.setInt(1,OrderId);
			ResultSet res=pst.executeQuery();

			while(res.next()) {
				int orderId=res.getInt("OrderId");
				int userId=res.getInt("userId");
				int restuarantId=res.getInt("restuarantId");
				Timestamp orderDate=res.getTimestamp("orderDate");
				float totalAmount=res.getFloat("totalAmount");
				String status=res.getString("status");
				String paymentMethod=res.getString("paymentMethod");

				order=new Order(orderId,userId,restuarantId,orderDate,totalAmount,status,paymentMethod);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return order;
	}

	@Override
	public void deleteOrder(int OrderId) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(DELETE_QUERY);
			pst.setInt(1, OrderId);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void updateOrder(Order order) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(UPDATE_QUERY);
			pst.setInt(1, order.getUserId());
			pst.setInt(2, order.getRestuarantId());
			pst.setTimestamp(3, order.getOrderDate());
			pst.setDouble(4, order.getTotalAmount());
			pst.setString(5, order.getStatus());
			pst.setString(6, order.getPaymentMethod());
			pst.setInt(7, order.getOrderId());

			int i=pst.executeUpdate();
			System.out.println(i+" Row Affected");

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Order> getAllOrderItem() {

		List<Order> list=new ArrayList<>();
		Connection con=DBConnection.getConnection();

		try {
			PreparedStatement st=con.prepareStatement(SELECT_ALL_QUERY);
			ResultSet res=st.executeQuery();

			while(res.next()) {
				Order order=new Order();
				order.setOrderId(res.getInt("OrderId"));
				order.setUserId(res.getInt("userId"));
				order.setRestuarantId(res.getInt("restuarantId"));
				order.setOrderDate(res.getTimestamp("orderDate"));
				order.setTotalAmount(res.getFloat("totalAmount"));
				order.setStatus(res.getString("status"));
				order.setPaymentMethod(res.getString("paymentMethod"));

				list.add(order);
			}


		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	
	@Override
	public List<Order> getOrdersByUser(int userId) {

		List<Order> list = new ArrayList<>();
		Connection con = DBConnection.getConnection();

		try {
			PreparedStatement pst = con.prepareStatement(SELECT_BY_USER_QUERY);
			pst.setInt(1, userId);
			ResultSet res = pst.executeQuery();

			while (res.next()) {
				Order order = new Order();
				order.setOrderId(res.getInt("OrderId"));
				order.setUserId(res.getInt("userId"));
				order.setRestuarantId(res.getInt("restuarantId"));
				order.setOrderDate(res.getTimestamp("orderDate"));
				order.setTotalAmount(res.getFloat("totalAmount"));
				order.setStatus(res.getString("status"));
				order.setPaymentMethod(res.getString("paymentMethod"));

				list.add(order);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	@Override
	public List<Order> getOrdersByRestaurant(int restuarantId) {

		List<Order> list = new ArrayList<>();
		Connection con = DBConnection.getConnection();

		try {
			PreparedStatement pst = con.prepareStatement(SELECT_BY_RESTAURANT_QUERY);
			pst.setInt(1, restuarantId);
			ResultSet res = pst.executeQuery();

			while (res.next()) {
				Order order = new Order();
				order.setOrderId(res.getInt("OrderId"));
				order.setUserId(res.getInt("userId"));
				order.setRestuarantId(res.getInt("restuarantId"));
				order.setOrderDate(res.getTimestamp("orderDate"));
				order.setTotalAmount(res.getFloat("totalAmount"));
				order.setStatus(res.getString("status"));
				order.setPaymentMethod(res.getString("paymentMethod"));

				list.add(order);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

}