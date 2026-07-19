package com.tap.Servlets;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.UUID;

import com.tap.model.User;
import com.tap.userDAOImpl.UserDAOImpl;
import com.tap.Utility.MailUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

	private UserDAOImpl userDAOImpl = new UserDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher("/ForgotPassword.jsp");
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");

		User user = userDAOImpl.getUserByUserEmail(email);

		if (user != null) {
			String token = UUID.randomUUID().toString();
			Timestamp expiry = new Timestamp(System.currentTimeMillis() + (30 * 60 * 1000)); // 30 minutes

			userDAOImpl.setResetToken(email, token, expiry);

			String resetLink = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort()
					+ req.getContextPath() + "/ResetPasswordServlet?token=" + token;

			try {
				MailUtil.sendPasswordResetEmail(email, resetLink);
			} catch (Exception e) {
				// don't let a mail failure crash the request; log and continue
				e.printStackTrace();
			}
		}

		// same response whether or not the email exists, so we don't leak which emails are registered
		resp.sendRedirect(req.getContextPath() + "/ForgotPassword.jsp?sent=true");
	}
}