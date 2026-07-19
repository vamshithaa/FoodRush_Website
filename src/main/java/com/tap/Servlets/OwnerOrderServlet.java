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
import jakarta.servlet.http.HttpSession;

@WebServlet("/owner/orders")
public class OwnerOrderServlet extends HttpServlet {

	private OrderDAOImpl orderDAOImpl = new OrderDAOImpl();
	private UserDAOImpl userDAOImpl = new UserDAOImpl();
	private RestuarantDAOImpl restuarantDAOImpl = new RestuarantDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Restuarant myRestuarant = getMyRestuarantOrRedirect(req, resp);
		if (myRestuarant == null) return; // already redirected

		listAndForward(req, resp, myRestuarant);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Restuarant myRestuarant = getMyRestuarantOrRedirect(req, resp);
		if (myRestuarant == null) return; // already redirected

		String action = req.getParameter("action");

		if ("updateStatus".equals(action)) {
			int orderId = Integer.parseInt(req.getParameter("orderId"));
			String newStatus = req.getParameter("status");

			Order order = orderDAOImpl.getOrder(orderId);

			// ownership check: only allow updating orders that belong to THIS owner's restaurant
			if (order != null && order.getRestuarantId() == myRestuarant.getRestuarantId()) {
				order.setStatus(newStatus);
				orderDAOImpl.updateOrder(order);
			}
		}

		resp.sendRedirect(req.getContextPath() + "/owner/orders");
	}

	private Restuarant getMyRestuarantOrRedirect(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession(false);
		User owner = (User) session.getAttribute("user");

		Restuarant myRestuarant = restuarantDAOImpl.getRestuarantByOwnerId(owner.getUserId());

		if (myRestuarant == null) {
			resp.sendRedirect(req.getContextPath() + "/owner/restaurant");
			return null;
		}

		return myRestuarant;
	}

	private void listAndForward(HttpServletRequest req, HttpServletResponse resp, Restuarant myRestuarant)
			throws ServletException, IOException {

		List<Order> myOrders = orderDAOImpl.getOrdersByRestaurant(myRestuarant.getRestuarantId());

		// lookup map so the JSP can show customer name/email instead of raw userId
		Map<Integer, User> userMap = new HashMap<>();
		for (User u : userDAOImpl.getAllUser()) {
			userMap.put(u.getUserId(), u);
		}

		req.setAttribute("myOrders", myOrders);
		req.setAttribute("userMap", userMap);
		req.setAttribute("restuarant", myRestuarant);

		RequestDispatcher rd = req.getRequestDispatcher("/owner/OwnerOrders.jsp");
		rd.forward(req, resp);
	}
}