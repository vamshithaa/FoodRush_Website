package com.tap.Servlets;

import java.io.IOException;
import java.util.List;

import com.tap.model.Menu;
import com.tap.model.Restuarant;
import com.tap.userDAOImpl.MenuDAOImpl;
import com.tap.userDAOImpl.RestuarantDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/menu")
public class MenuServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MenuDAOImpl menuDAOImpl=new MenuDAOImpl();
		RestuarantDAOImpl restuarantDAOImpl=new RestuarantDAOImpl();

		int restuarantId=Integer.parseInt(req.getParameter("restuarantId"));
		List<Menu> allMenusByRestaurant=menuDAOImpl.getAllMenu(restuarantId);
		Restuarant restuarant=restuarantDAOImpl.getRestuarant(restuarantId);

		req.setAttribute("allMenusByRestaurant", allMenusByRestaurant);
		req.setAttribute("restuarant", restuarant);
		RequestDispatcher rd=req.getRequestDispatcher("Menu.jsp");
		rd.forward(req, resp);
	}
}