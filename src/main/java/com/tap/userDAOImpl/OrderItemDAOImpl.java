package com.tap.userDAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.OrderItemDAO;
import com.tap.Utility.DBConnection;
import com.tap.model.OrderItem;

public class OrderItemDAOImpl implements OrderItemDAO {
	public static final String INSERT_QUERY="INSERT INTO orderitem(orderId,menuId,quantity,itemTotal) values(?,?,?,?)";
	public static final String SELECT_QUERY="SELECT * FROM orderitem WHERE orderItemId=?";
	public static final String DELETE_QUERY="DELETE FROM orderitem WHERE orderItemId=?";
	public static final String UPDATE_QUERY="UPDATE orderitem SET orderId=?,menuId=?,quantity=?,itemTotal=? WHERE orderItemId=?";
	public static final String SELECT_ALL_QUERY="SELECT * FROM orderitem";
	public static final String SELECT_BY_ORDER_QUERY ="SELECT * FROM orderitem WHERE orderId=?";
	
	@Override
	public void addOrderItem(OrderItem orderItem) {

		// try-with-resources: Connection + PreparedStatement always get closed,
		// even if executeUpdate() throws.
		try (Connection con = DBConnection.getConnection();
			 PreparedStatement pst = con.prepareStatement(INSERT_QUERY)) {

			pst.setInt(1, orderItem.getOrderId());
			pst.setInt(2, orderItem.getMenuId());
			pst.setInt(3, orderItem.getQuantity());
			pst.setFloat(4, orderItem.getItemTotal());

			int i = pst.executeUpdate();
			System.out.println(i + " Row Inserted into orderitem");

			if (i == 0) {
				System.out.println("WARNING: orderitem insert affected 0 rows for " + orderItem);
			}

		} catch (SQLException e) {
			// IMPORTANT: don't swallow this. Print full details AND rethrow as an
			// unchecked exception so the servlet/caller knows the insert failed
			// instead of silently proceeding to the confirmation page.
			System.err.println("Failed to insert OrderItem: " + orderItem);
			e.printStackTrace();
			throw new RuntimeException("Failed to insert order item (menuId=" + orderItem.getMenuId() + ")", e);
		}
	}

	@Override
	public OrderItem getOrderItem(int orderItemId) {
		OrderItem orderItem = null;

		try (Connection con = DBConnection.getConnection();
			 PreparedStatement pst = con.prepareStatement(SELECT_QUERY)) {

			pst.setInt(1, orderItemId);

			try (ResultSet res = pst.executeQuery()) {
				while (res.next()) {
					int id = res.getInt("orderItemId");
					int orderId = res.getInt("orderId");
					int menuId = res.getInt("menuId");
					int quantity = res.getInt("quantity");
					float itemTotal = res.getFloat("itemTotal");

					orderItem = new OrderItem(id, orderId, menuId, quantity, itemTotal);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orderItem;
	}

	@Override
	public void deleteOrderItem(int orderItemId) {
		try (Connection con = DBConnection.getConnection();
			 PreparedStatement pst = con.prepareStatement(DELETE_QUERY)) {

			pst.setInt(1, orderItemId);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateOrderItem(OrderItem orderItem) {
		try (Connection con = DBConnection.getConnection();
			 PreparedStatement pst = con.prepareStatement(UPDATE_QUERY)) {

			pst.setInt(1, orderItem.getOrderId());
			pst.setInt(2, orderItem.getMenuId());
			pst.setInt(3, orderItem.getQuantity());
			pst.setFloat(4, orderItem.getItemTotal());
			pst.setInt(5, orderItem.getOrderItemId());

			int i = pst.executeUpdate();
			System.out.println(i + " Row Affected");

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<OrderItem> getAllOrderItem() {

		List<OrderItem> list = new ArrayList<>();

		try (Connection con = DBConnection.getConnection();
			 PreparedStatement st = con.prepareStatement(SELECT_ALL_QUERY);
			 ResultSet res = st.executeQuery()) {

			while (res.next()) {
				OrderItem orderItem = new OrderItem();
				orderItem.setOrderItemId(res.getInt("orderItemId"));
				orderItem.setOrderId(res.getInt("orderId"));
				orderItem.setMenuId(res.getInt("menuId"));
				orderItem.setQuantity(res.getInt("quantity"));
				orderItem.setItemTotal(res.getFloat("itemTotal"));

				list.add(orderItem);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	@Override
	public List<OrderItem> getOrderItemsByOrder(int orderId) {

		List<OrderItem> list = new ArrayList<>();

		try (Connection con = DBConnection.getConnection();
			 PreparedStatement pst = con.prepareStatement(SELECT_BY_ORDER_QUERY)) {

			pst.setInt(1, orderId);

			try (ResultSet res = pst.executeQuery()) {
				while (res.next()) {
					OrderItem orderItem = new OrderItem();
					orderItem.setOrderItemId(res.getInt("orderItemId"));
					orderItem.setOrderId(res.getInt("orderId"));
					orderItem.setMenuId(res.getInt("menuId"));
					orderItem.setQuantity(res.getInt("quantity"));
					orderItem.setItemTotal(res.getFloat("itemTotal"));

					list.add(orderItem);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

}