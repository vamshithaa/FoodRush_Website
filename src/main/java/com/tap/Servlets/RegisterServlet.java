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

@WebServlet("/callRegisterServlet")
public class RegisterServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name=req.getParameter("Username");
		String email=req.getParameter("Email");
		String Address=req.getParameter("Address");
		String Password=req.getParameter("Password");
		String role=req.getParameter("role");
		
		
		String hashpw=BCrypt.hashpw(Password, BCrypt.gensalt(8));
		
		User user=new User(name,hashpw,email,Address,role);
		
		UserDAOImpl userDAOImpl=new UserDAOImpl();
		int res=userDAOImpl.addUser(user);
		
		
		if(res==1) {
			com.tap.Utility.MailUtil.sendWelcomeEmail(email, name);
			resp.sendRedirect("Login.html");
		}
		else {
			resp.sendRedirect("Register.html");
		}
	}
}
