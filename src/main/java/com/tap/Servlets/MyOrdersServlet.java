package com.tap.Servlets;

import java.io.IOException;
import com.tap.model.Review;
import com.tap.userDAOImpl.ReviewDAOImpl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.Restuarant;
import com.tap.model.User;
import com.tap.userDAOImpl.MenuDAOImpl;
import com.tap.userDAOImpl.OrderDAOImpl;
import com.tap.userDAOImpl.OrderItemDAOImpl;
import com.tap.userDAOImpl.RestuarantDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MyOrdersServlet")
public class MyOrdersServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("user") : null;

		if (user == null) {
			resp.sendRedirect("Login.html");
			return;
		}

		OrderDAOImpl orderDAOImpl = new OrderDAOImpl();
		List<Order> orders = orderDAOImpl.getOrdersByUser(user.getUserId());

		OrderItemDAOImpl orderItemDAOImpl = new OrderItemDAOImpl();
		RestuarantDAOImpl restuarantDAOImpl = new RestuarantDAOImpl();
		MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
		ReviewDAOImpl reviewDAOImpl = new ReviewDAOImpl();

		// orderId -> its list of items
		Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<>();

		// restuarantId -> restaurant details (so we can show the name)
		Map<Integer, Restuarant> restaurantMap = new HashMap<>();

		// menuId -> menu item details (so we can show item names, not just IDs)
		Map<Integer, Menu> menuMap = new HashMap<>();

		// orderId -> the review already left for it, if any
		Map<Integer, Review> reviewMap = new HashMap<>();

		for (Order order : orders) {

			List<OrderItem> items = orderItemDAOImpl.getOrderItemsByOrder(order.getOrderId());
			orderItemsMap.put(order.getOrderId(), items);

			int restuarantId = order.getRestuarantId();
			if (!restaurantMap.containsKey(restuarantId)) {
				restaurantMap.put(restuarantId, restuarantDAOImpl.getRestuarant(restuarantId));
			}

			for (OrderItem item : items) {
				int menuId = item.getMenuId();
				if (!menuMap.containsKey(menuId)) {
					menuMap.put(menuId, menuDAOImpl.getMenu(menuId));
				}
			}

			if ("delivered".equalsIgnoreCase(order.getStatus())) {
				Review review = reviewDAOImpl.getReviewByOrder(order.getOrderId());
				if (review != null) {
					reviewMap.put(order.getOrderId(), review);
				}
			}
		}

		req.setAttribute("orders", orders);
		req.setAttribute("orderItemsMap", orderItemsMap);
		req.setAttribute("restaurantMap", restaurantMap);
		req.setAttribute("menuMap", menuMap);
		req.setAttribute("reviewMap", reviewMap);

		RequestDispatcher rd = req.getRequestDispatcher("MyOrders.jsp");
		rd.forward(req, resp);
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("user") : null;

		if (user == null) {
			resp.sendRedirect("Login.html");
			return;
		}

		if ("cancel".equals(req.getParameter("action"))) {
			int orderId = Integer.parseInt(req.getParameter("orderId"));

			OrderDAOImpl orderDAOImpl = new OrderDAOImpl();
			Order order = orderDAOImpl.getOrder(orderId);

			// only let a user cancel their own order, and only while it hasn't
			// started being prepared yet
			boolean belongsToUser = (order != null && order.getUserId() == user.getUserId());
			boolean stillCancellable = (order != null && "Not delivered".equalsIgnoreCase(order.getStatus()));

			if (belongsToUser && stillCancellable) {
				order.setStatus("Cancelled");
				orderDAOImpl.updateOrder(order);
			}
		}

		resp.sendRedirect("MyOrdersServlet");
	}
	
	
	
	
}