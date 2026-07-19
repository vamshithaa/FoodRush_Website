package com.tap.Servlets;

import java.io.IOException;
import java.sql.Timestamp;

import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;
import com.tap.userDAOImpl.OrderDAOImpl;
import com.tap.userDAOImpl.OrderItemDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/checkout")
public class checkOutServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		User user=(User)session.getAttribute("user");
		Cart cart=(Cart)session.getAttribute("cart");
		Integer restuarantId=(Integer)session.getAttribute("restuarantId");
		Double finalAmount=(Double)session.getAttribute("finalAmount");

		String paymentMode=req.getParameter("paymentMode");

		if(user==null) {
			RequestDispatcher rd=req.getRequestDispatcher("Login.html");
			rd.forward(req, resp);
			return; // was missing: without this, execution fell through to the code below
		}

		if(cart!=null && !cart.getItems().isEmpty() && restuarantId!=null && finalAmount!=null) {

			try {
				Order order =new Order();
				order.setUserId(user.getUserId());
				order.setRestuarantId(restuarantId);
				order.setOrderDate(new Timestamp(System.currentTimeMillis()));
				order.setPaymentMethod(paymentMode);
				order.setStatus("Not delivered");
				order.setTotalAmount(finalAmount);

				OrderDAOImpl orderDAOImpl=new OrderDAOImpl();
				int orderId=orderDAOImpl.addOrder(order);

				// If the order insert failed, addOrder() returns 0 - stop here instead
				// of trying to insert order items against a non-existent orderId.
				if(orderId<=0) {
					throw new RuntimeException("Order could not be created; aborting order item insert.");
				}

				OrderItemDAOImpl orderItemDAOImpl=new OrderItemDAOImpl();

				for(CartItem item:cart.getItems().values()) {

					OrderItem orderItem=new OrderItem();

					orderItem.setOrderId(orderId);
					orderItem.setMenuId(item.getMenuId());
					orderItem.setQuantity(item.getQuantity());
					orderItem.setItemTotal(item.getTotalPrice());

					orderItemDAOImpl.addOrderItem(orderItem);
				}

				session.removeAttribute("cart");
				session.removeAttribute("restuarantId");
				session.removeAttribute("finalAmount");

				resp.sendRedirect("OrderConfirmation.jsp");

			} catch (Exception e) {
				// Surface the failure instead of redirecting to a confirmation page
				// as if the order succeeded.
				e.printStackTrace();
				req.setAttribute("errorMessage", "We couldn't place your order. Please try again.");
				RequestDispatcher rd=req.getRequestDispatcher("Cart.jsp");
				rd.forward(req, resp);
			}

		}
		else {
			resp.sendRedirect("Cart.jsp");
		}
	}
}