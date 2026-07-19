package com.tap.DAO;

import java.util.List;

import com.tap.model.Order;

public interface OrderDAO {
	int addOrder(Order order);
	Order getOrder(int OrderId);
	void deleteOrder(int OrderId);
	void updateOrder(Order orderItem);
	List<Order>getAllOrderItem();
	List<Order> getOrdersByUser(int userId);
	List<Order> getOrdersByRestaurant(int restuarantId);
}