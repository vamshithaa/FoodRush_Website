package com.tap.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class Order {
	private int OrderId;
	private int userId;
	private int restuarantId;
	private Timestamp orderDate;
	private double totalAmount;
	private String status;
	private String paymentMethod;
	
	
	public Order() {
		super();
	}


	public Order(int orderId, int userId, int restuarantId, Timestamp orderDate, float totalAmount, String status,
			String paymentMethod) {
		super();
		OrderId = orderId;
		this.userId = userId;
		this.restuarantId = restuarantId;
		this.orderDate = orderDate;
		this.totalAmount = totalAmount;
		this.status = status;
		this.paymentMethod = paymentMethod;
	}


	public int getOrderId() {
		return OrderId;
	}


	public void setOrderId(int orderId) {
		OrderId = orderId;
	}


	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
	}


	public int getRestuarantId() {
		return restuarantId;
	}


	public void setRestuarantId(int restuarantId) {
		this.restuarantId = restuarantId;
	}


	public Timestamp getOrderDate() {
		return orderDate;
	}


	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}


	public double getTotalAmount() {
		return totalAmount;
	}


	public void setTotalAmount(double finalAmount) {
		this.totalAmount = finalAmount;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getPaymentMethod() {
		return paymentMethod;
	}


	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}


	@Override
	public String toString() {
		return "Order [OrderId=" + OrderId + ", userId=" + userId + ", restuarantId=" + restuarantId + ", orderDate="
				+ orderDate + ", totalAmount=" + totalAmount + ", status=" + status + ", paymentMethod=" + paymentMethod
				+ "]";
	}
	
	
}
