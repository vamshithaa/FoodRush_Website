package com.tap.Servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.model.Order;
import com.tap.model.Restuarant;
import com.tap.model.User;
import com.tap.userDAOImpl.OrderDAOImpl;
import com.tap.userDAOImpl.RestuarantDAOImpl;
import com.tap.userDAOImpl.UserDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

	private OrderDAOImpl orderDAOImpl = new OrderDAOImpl();
	private UserDAOImpl userDAOImpl = new UserDAOImpl();
	private RestuarantDAOImpl restuarantDAOImpl = new RestuarantDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		listAndForward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String action = req.getParameter("action");

		if ("updateStatus".equals(action)) {
			int orderId = Integer.parseInt(req.getParameter("orderId"));
			String newStatus = req.getParameter("status");

			// UPDATE_QUERY overwrites every column, so fetch the existing order first
			// and only change the status on it, to avoid wiping out the other fields.
			Order order = orderDAOImpl.getOrder(orderId);
			if (order != null) {
				order.setStatus(newStatus);
				orderDAOImpl.updateOrder(order);
			}
		}

		resp.sendRedirect(req.getContextPath() + "/admin/orders");
	}

	private void listAndForward(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		List<Order> allOrders = orderDAOImpl.getAllOrderItem();

		// build lookup maps so the JSP can show customer & restaurant names
		// instead of raw IDs, without hitting the DB in a loop from the JSP itself.
		Map<Integer, User> userMap = new HashMap<>();
		for (User u : userDAOImpl.getAllUser()) {
			userMap.put(u.getUserId(), u);
		}

		Map<Integer, Restuarant> restaurantMap = new HashMap<>();
		for (Restuarant r : restuarantDAOImpl.getAllRestuarant()) {
			restaurantMap.put(r.getRestuarantId(), r);
		}

		req.setAttribute("allOrders", allOrders);
		req.setAttribute("userMap", userMap);
		req.setAttribute("restaurantMap", restaurantMap);

		RequestDispatcher rd = req.getRequestDispatcher("/admin/AdminOrders.jsp");
		rd.forward(req, resp);
	}
}