package com.tap.Servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.tap.model.User;
import com.tap.userDAOImpl.FavoriteDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/FavoriteServlet")
public class FavoriteServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("application/json");
		PrintWriter out = resp.getWriter();

		HttpSession session = req.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("user") : null;

		if (user == null) {
			resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			out.write("{\"status\":\"error\",\"message\":\"login_required\"}");
			return;
		}

		int restaurantId;
		try {
			restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		} catch (NumberFormatException e) {
			resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			out.write("{\"status\":\"error\",\"message\":\"invalid_restaurant_id\"}");
			return;
		}

		int userId = user.getUserId();
		FavoriteDAOImpl favoriteDAOImpl = new FavoriteDAOImpl();

		if (favoriteDAOImpl.isFavorite(userId, restaurantId)) {
			favoriteDAOImpl.removeFavorite(userId, restaurantId);
			out.write("{\"status\":\"removed\"}");
		} else {
			favoriteDAOImpl.addFavorite(userId, restaurantId);
			out.write("{\"status\":\"added\"}");
		}
	}
}