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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email=req.getParameter("email");
		String Password=req.getParameter("Password");
		HttpSession session=req.getSession();
		
		UserDAOImpl userDAOImpl=new UserDAOImpl();
		User user=userDAOImpl.getUserByUserEmail(email);
		
		if(user==null) {
			resp.sendRedirect("Register.html?notRegistered=true");
			return;
		}
		
		String dbPassword=user.getUserPassword();
		
		if(BCrypt.checkpw(Password, dbPassword)) {
		    session.setAttribute("user", user);

		    if("admin".equalsIgnoreCase(user.getRole())) {
		        resp.sendRedirect("admin/dashboard");
		    } else if("restuarantOwner".equalsIgnoreCase(user.getRole())) {
		        resp.sendRedirect("owner/dashboard");
		    } else {
		        resp.sendRedirect("callRestuarantServlet");
		    }
		}
		else {
			resp.sendRedirect("Login.html?error=true");
			
		}
	}

}
