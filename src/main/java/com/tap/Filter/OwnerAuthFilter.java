package com.tap.Filter;

import java.io.IOException;

import com.tap.model.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/owner/*")
public class OwnerAuthFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		HttpSession session = req.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("user") : null;

		if (user == null) {
			// not logged in at all -> send to login
			resp.sendRedirect(req.getContextPath() + "/Login.html?ownerRequired=true");
			return;
		}

		if (!"restuarantOwner".equalsIgnoreCase(user.getRole())) {
			// logged in, but not a restaurant owner -> block access
			resp.sendRedirect(req.getContextPath() + "/Login.html?notAuthorized=true");
			return;
		}

		// user is a logged-in restaurant owner, let the request through
		chain.doFilter(request, response);
	}
}