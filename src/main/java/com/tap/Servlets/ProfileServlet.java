package com.tap.Servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.model.User;
import com.tap.userDAOImpl.UserDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		User sessionUser = (User) session.getAttribute("user");

		if (sessionUser == null) {
			resp.sendRedirect("Login.html");
			return;
		}

		// Refresh with the latest data from the DB before showing the page
		UserDAOImpl userDAOImpl = new UserDAOImpl();
		User freshUser = userDAOImpl.getUser(sessionUser.getUserId());

		if (freshUser != null) {
			session.setAttribute("user", freshUser);
		}

		req.getRequestDispatcher("Profile.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		User sessionUser = (User) session.getAttribute("user");

		if (sessionUser == null) {
			resp.sendRedirect("Login.html");
			return;
		}

		String userName = req.getParameter("userName");
		String userEmail = req.getParameter("userEmail");
		String userAddress = req.getParameter("userAddress");
		String newPassword = req.getParameter("newPassword");
		String confirmPassword = req.getParameter("confirmPassword");

		// If changing password, make sure both fields match
		if (newPassword != null && !newPassword.trim().isEmpty()) {
			if (!newPassword.equals(confirmPassword)) {
				resp.sendRedirect("ProfileServlet?error=true");
				return;
			}
		}

		String finalPassword;
		if (newPassword != null && !newPassword.trim().isEmpty()) {
			finalPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt(8));
		} else {
			finalPassword = sessionUser.getUserPassword();
		}

		User updatedUser = new User();
		updatedUser.setUserId(sessionUser.getUserId());
		updatedUser.setUserName(userName);
		updatedUser.setUserPassword(finalPassword);
		updatedUser.setUserEmail(userEmail);
		updatedUser.setUserAddress(userAddress);
		updatedUser.setRole(sessionUser.getRole());

		UserDAOImpl userDAOImpl = new UserDAOImpl();
		userDAOImpl.updateUser(updatedUser);

		// Keep the session in sync with what's now in the DB
		session.setAttribute("user", updatedUser);

		resp.sendRedirect("ProfileServlet?success=true");
	}

}