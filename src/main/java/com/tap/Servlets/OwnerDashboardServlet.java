package com.tap.Servlets;

import java.io.IOException;

import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/owner/dashboard")
public class OwnerDashboardServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		User owner = (session != null) ? (User) session.getAttribute("user") : null;

		req.setAttribute("owner", owner);

		RequestDispatcher rd = req.getRequestDispatcher("/owner/OwnerDashboard.jsp");
		rd.forward(req, resp);
	}
}