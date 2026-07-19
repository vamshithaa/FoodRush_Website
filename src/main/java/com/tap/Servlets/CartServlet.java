package com.tap.Servlets;

import java.io.IOException;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;
import com.tap.userDAOImpl.MenuDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.tap.model.Restuarant;
import com.tap.userDAOImpl.RestuarantDAOImpl;

@WebServlet("/cartServlet")
public class CartServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		Cart cart = (Cart) session.getAttribute("cart");
		Integer restuarantId = (Integer) session.getAttribute("restuarantId");

		int newRestuarantId = Integer.parseInt(req.getParameter("restuarantId"));

		if (cart == null || restuarantId == null || !restuarantId.equals(newRestuarantId)) {
			cart = new Cart();
			session.setAttribute("cart", cart);
			session.setAttribute("restuarantId", newRestuarantId);
		}

		String action = req.getParameter("action");

		if (action.equals("add")) {
			addItemToCart(req, cart);
		} else if (action.equals("update")) {
			updateItemToCart(req, cart);
		} else if (action.equals("delete")) {
			deleteItemFromCart(req, cart);
		}
		resp.sendRedirect("Cart.jsp");
	}

	private void deleteItemFromCart(HttpServletRequest req, Cart cart) {
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		cart.removeItem(menuId);
	}

	private void updateItemToCart(HttpServletRequest req, Cart cart) {
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));

		cart.updateItem(menuId, quantity);
	}

	private void addItemToCart(HttpServletRequest req, Cart cart) {
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));

		MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
		Menu menu = menuDAOImpl.getMenu(menuId);

		RestuarantDAOImpl restuarantDAOImpl = new RestuarantDAOImpl();
		Restuarant restuarant = restuarantDAOImpl.getRestuarant(menu.getRestuarantId());

		int discountPercent = (restuarant != null && restuarant.hasActiveOffer()) ? restuarant.getOfferPercent() : 0;

		CartItem cartItem = new CartItem(menu.getMenuId(), menu.getRestuarantId(), menu.getItemName(), menu.getPrice(), quantity);
		cartItem.setDiscountPercent(discountPercent);

		cart.addItem(cartItem);
	}

}