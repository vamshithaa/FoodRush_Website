package com.tap.Servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.model.Restuarant;
import com.tap.model.User;
import com.tap.userDAOImpl.FavoriteDAOImpl;
import com.tap.userDAOImpl.RestuarantDAOImpl;
import com.tap.userDAOImpl.ReviewDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callRestuarantServlet")
public class RestuarantServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("HI FROM SERVLET");
		RestuarantDAOImpl restuarantDAOImpl=new RestuarantDAOImpl();
		List<Restuarant> allrestuarants=restuarantDAOImpl.getAllRestuarant();
		
		System.out.println("List = " + allrestuarants);
		
		req.setAttribute("allrestuarants", allrestuarants);

		// average rating & review count per restaurant, computed from actual reviews
		ReviewDAOImpl reviewDAOImpl = new ReviewDAOImpl();
		Map<Integer, Double> avgRatingMap = new HashMap<>();
		Map<Integer, Integer> reviewCountMap = new HashMap<>();
		for (Restuarant r : allrestuarants) {
			int reviewCount = reviewDAOImpl.getReviewCount(r.getRestuarantId());
			reviewCountMap.put(r.getRestuarantId(), reviewCount);
			avgRatingMap.put(r.getRestuarantId(),
					reviewCount > 0 ? reviewDAOImpl.getAverageRating(r.getRestuarantId()) : r.getRating());
		}
		req.setAttribute("avgRatingMap", avgRatingMap);
		req.setAttribute("reviewCountMap", reviewCountMap);

		// fetch the logged-in user's favorite restaurant IDs (if logged in)
		HttpSession session = req.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("user") : null;

		List<Integer> favoriteIds = new ArrayList<>();
		if (user != null) {
			FavoriteDAOImpl favoriteDAOImpl = new FavoriteDAOImpl();
			favoriteIds = favoriteDAOImpl.getFavoriteRestaurantIdsByUser(user.getUserId());
		}
		req.setAttribute("favoriteIds", favoriteIds);

		System.out.println("Forwarding to JSP");
		
		RequestDispatcher rd=req.getRequestDispatcher("Restuarant.jsp");
		rd.forward(req, resp);
		
		System.out.println("After forward");
	}
}