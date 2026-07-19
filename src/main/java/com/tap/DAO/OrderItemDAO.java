package com.tap.DAO;

import java.util.List;

import com.tap.model.OrderItem;

public interface OrderItemDAO {
	void addOrderItem(OrderItem orderItem);
	OrderItem getOrderItem(int orderItemId);
	void deleteOrderItem(int orderItemId);
	void updateOrderItem(OrderItem orderItem);
	List<OrderItem>getAllOrderItem();
	List<OrderItem> getOrderItemsByOrder(int orderId);
}
