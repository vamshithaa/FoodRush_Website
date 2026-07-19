package com.tap.Servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.tap.model.Restuarant;
import com.tap.model.User;
import com.tap.userDAOImpl.FavoriteDAOImpl;
import com.tap.userDAOImpl.RestuarantDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MyFavoritesServlet")
public class MyFavoritesServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("user") : null;

		if (user == null) {
			resp.sendRedirect("Login.html");
			return;
		}

		FavoriteDAOImpl favoriteDAOImpl = new FavoriteDAOImpl();
		List<Integer> favoriteIds = favoriteDAOImpl.getFavoriteRestaurantIdsByUser(user.getUserId());

		RestuarantDAOImpl restuarantDAOImpl = new RestuarantDAOImpl();
		List<Restuarant> allRestuarants = restuarantDAOImpl.getAllRestuarant();

		List<Restuarant> favoriteRestuarants = new ArrayList<>();
		for (Restuarant r : allRestuarants) {
			if (favoriteIds.contains(r.getRestuarantId())) {
				favoriteRestuarants.add(r);
			}
		}

		req.setAttribute("allrestuarants", favoriteRestuarants);
		req.setAttribute("favoriteIds", favoriteIds);

		RequestDispatcher rd = req.getRequestDispatcher("MyFavorites.jsp");
		rd.forward(req, resp);
	}
}