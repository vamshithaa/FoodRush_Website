package com.tap.Servlets;

import java.io.IOException;

import com.tap.model.Restuarant;
import com.tap.model.User;
import com.tap.userDAOImpl.RestuarantDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/owner/offers")
public class OwnerOfferServlet extends HttpServlet {

	private RestuarantDAOImpl restuarantDAOImpl = new RestuarantDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Restuarant myRestuarant = getMyRestuarantOrRedirect(req, resp);
		if (myRestuarant == null) return; // already redirected

		req.setAttribute("restuarant", myRestuarant);

		RequestDispatcher rd = req.getRequestDispatcher("/owner/OwnerOffers.jsp");
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Restuarant myRestuarant = getMyRestuarantOrRedirect(req, resp);
		if (myRestuarant == null) return; // already redirected

		boolean offerActive = "on".equals(req.getParameter("offerActive"));
		int offerPercent = parseIntSafe(req.getParameter("offerPercent"), 0);

		// keep the percentage sane regardless of what's submitted
		if (offerPercent < 0) offerPercent = 0;
		if (offerPercent > 90) offerPercent = 90;

		// if they didn't actually set a percentage, treat the offer as off
		if (offerPercent == 0) offerActive = false;

		restuarantDAOImpl.updateOffer(myRestuarant.getRestuarantId(), offerActive, offerPercent);

		resp.sendRedirect(req.getContextPath() + "/owner/offers?saved=true");
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

	private int parseIntSafe(String value, int fallback) {
		try {
			return Integer.parseInt(value);
		} catch (Exception e) {
			return fallback;
		}
	}
}