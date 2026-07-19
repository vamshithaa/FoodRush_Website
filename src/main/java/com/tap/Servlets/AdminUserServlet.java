package com.tap.Servlets;

import java.io.IOException;
import java.util.List;

import com.tap.model.User;
import com.tap.userDAOImpl.UserDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

	private UserDAOImpl userDAOImpl = new UserDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		listAndForward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String action = req.getParameter("action");
		int userId = Integer.parseInt(req.getParameter("userId"));

		HttpSession session = req.getSession(false);
		User currentAdmin = (session != null) ? (User) session.getAttribute("user") : null;

		// safety net: an admin should never be able to delete or demote their own account
		// from this screen, since that could lock everyone out of the admin panel.
		boolean isSelf = (currentAdmin != null && currentAdmin.getUserId() == userId);

		if (!isSelf) {
			if ("delete".equals(action)) {
				userDAOImpl.deleteUser(userId);
			} else if ("promote".equals(action)) {
				setRole(userId, "admin");
			} else if ("demote".equals(action)) {
				setRole(userId, "customer");
			}
		}

		resp.sendRedirect(req.getContextPath() + "/admin/users");
	}

	private void setRole(int userId, String newRole) {
		User user = userDAOImpl.getUser(userId);
		if (user != null) {
			user.setRole(newRole);
			userDAOImpl.updateUser(user);
		}
	}

	private void listAndForward(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		List<User> allUsers = userDAOImpl.getAllUser();
		req.setAttribute("allUsers", allUsers);

		RequestDispatcher rd = req.getRequestDispatcher("/admin/AdminUsers.jsp");
		rd.forward(req, resp);
	}
}