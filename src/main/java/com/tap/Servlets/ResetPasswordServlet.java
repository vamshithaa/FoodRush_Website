package com.tap.Servlets;

import java.io.IOException;
import java.sql.Timestamp;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.model.User;
import com.tap.userDAOImpl.UserDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

	private UserDAOImpl userDAOImpl = new UserDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String token = req.getParameter("token");
		User user = (token != null) ? userDAOImpl.getUserByResetToken(token) : null;

		if (user == null || user.getResetTokenExpiry() == null
				|| user.getResetTokenExpiry().before(new Timestamp(System.currentTimeMillis()))) {
			req.setAttribute("invalid", true);
		} else {
			req.setAttribute("token", token);
		}

		RequestDispatcher rd = req.getRequestDispatcher("/ResetPassword.jsp");
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String token = req.getParameter("token");
		String newPassword = req.getParameter("newPassword");
		String confirmPassword = req.getParameter("confirmPassword");

		User user = (token != null) ? userDAOImpl.getUserByResetToken(token) : null;

		if (user == null || user.getResetTokenExpiry() == null
				|| user.getResetTokenExpiry().before(new Timestamp(System.currentTimeMillis()))) {
			req.setAttribute("invalid", true);
			RequestDispatcher rd = req.getRequestDispatcher("/ResetPassword.jsp");
			rd.forward(req, resp);
			return;
		}

		if (newPassword == null || newPassword.length() < 6 || !newPassword.equals(confirmPassword)) {
			req.setAttribute("token", token);
			req.setAttribute("error", "Passwords must match and be at least 6 characters long.");
			RequestDispatcher rd = req.getRequestDispatcher("/ResetPassword.jsp");
			rd.forward(req, resp);
			return;
		}

		String hashedPw = BCrypt.hashpw(newPassword, BCrypt.gensalt(8));
		userDAOImpl.resetPassword(user.getUserId(), hashedPw);

		resp.sendRedirect(req.getContextPath() + "/Login.html?reset=true");
	}
}
