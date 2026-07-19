package com.tap.Servlets;

import java.io.IOException;

import com.tap.model.Order;
import com.tap.model.Review;
import com.tap.model.User;
import com.tap.userDAOImpl.OrderDAOImpl;
import com.tap.userDAOImpl.ReviewDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/review")
public class ReviewServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("user") : null;

		if (user == null) {
			resp.sendRedirect("Login.html");
			return;
		}

		int orderId = Integer.parseInt(req.getParameter("orderId"));
		int rating = parseIntSafe(req.getParameter("rating"), 0);
		String comment = req.getParameter("comment");

		OrderDAOImpl orderDAOImpl = new OrderDAOImpl();
		ReviewDAOImpl reviewDAOImpl = new ReviewDAOImpl();

		Order order = orderDAOImpl.getOrder(orderId);

		// only allow reviewing your own order, once it's actually delivered,
		// and only once per order
		boolean belongsToUser = (order != null && order.getUserId() == user.getUserId());
		boolean isDelivered = (order != null && "delivered".equalsIgnoreCase(order.getStatus()));
		boolean alreadyReviewed = (order != null && reviewDAOImpl.getReviewByOrder(orderId) != null);
		boolean ratingValid = rating >= 1 && rating <= 5;

		if (belongsToUser && isDelivered && !alreadyReviewed && ratingValid) {
			Review review = new Review();
			review.setOrderId(orderId);
			review.setUserId(user.getUserId());
			review.setRestuarantId(order.getRestuarantId());
			review.setRating(rating);
			review.setComment(comment);

			reviewDAOImpl.addReview(review);
		}

		resp.sendRedirect("MyOrdersServlet");
	}

	private int parseIntSafe(String value, int fallback) {
		try {
			return Integer.parseInt(value);
		} catch (Exception e) {
			return fallback;
		}
	}
}