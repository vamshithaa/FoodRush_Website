package com.tap.Servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

import com.tap.model.Menu;
import com.tap.model.Restuarant;
import com.tap.model.User;
import com.tap.userDAOImpl.MenuDAOImpl;
import com.tap.userDAOImpl.RestuarantDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/owner/menu")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB per image
public class OwnerMenuServlet extends HttpServlet {

	private MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
	private RestuarantDAOImpl restuarantDAOImpl = new RestuarantDAOImpl();
	private static final String UPLOAD_DIR = "images/menu";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Restuarant myRestuarant = getMyRestuarantOrRedirect(req, resp);
		if (myRestuarant == null) return; // already redirected

		String action = req.getParameter("action");
		if (action == null) action = "list";

		if (action.equals("delete")) {
			int id = Integer.parseInt(req.getParameter("id"));
			Menu menu = menuDAOImpl.getMenu(id);
			if (menu != null && menu.getRestuarantId() == myRestuarant.getRestuarantId()) {
				menuDAOImpl.deleteMenu(id);
			}
			resp.sendRedirect(req.getContextPath() + "/owner/menu");
			return;
		}

		if (action.equals("edit")) {
			int id = Integer.parseInt(req.getParameter("id"));
			Menu menu = menuDAOImpl.getMenu(id);
			if (menu != null && menu.getRestuarantId() == myRestuarant.getRestuarantId()) {
				req.setAttribute("editMenu", menu);
			}
		}

		listAndForward(req, resp, myRestuarant);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Restuarant myRestuarant = getMyRestuarantOrRedirect(req, resp);
		if (myRestuarant == null) return; // already redirected

		String action = req.getParameter("action");

		if ("add".equals(action)) {
			addMenu(req, myRestuarant.getRestuarantId());
		} else if ("update".equals(action)) {
			updateMenu(req, myRestuarant.getRestuarantId());
		}

		resp.sendRedirect(req.getContextPath() + "/owner/menu");
	}

	/**
	 * Looks up the logged-in owner's restaurant. If they don't have one yet,
	 * sends them to the setup page instead and returns null.
	 */
	private Restuarant getMyRestuarantOrRedirect(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession(false);
		User owner = (User) session.getAttribute("user");

		Restuarant myRestuarant = restuarantDAOImpl.getRestuarantByOwnerId(owner.getUserId());

		if (myRestuarant == null) {
			resp.sendRedirect(req.getContextPath() + "/owner/restaurant");
			return null;
		}

		return myRestuarant;
	}

	private void addMenu(HttpServletRequest req, int restuarantId) throws IOException, ServletException {
		String itemName = req.getParameter("itemName");
		String description = req.getParameter("description");
		float price = parseFloatSafe(req.getParameter("price"), 0f);
		boolean isAvailable = "on".equals(req.getParameter("isAvailable"));

		Menu menu = new Menu();
		menu.setRestuarantId(restuarantId);
		menu.setItemName(itemName);
		menu.setDescription(description);
		menu.setPrice(price);
		menu.setImagePath(resolveImagePath(req));
		menu.setAvailable(isAvailable);

		menuDAOImpl.addMenu(menu);
	}

	private void updateMenu(HttpServletRequest req, int restuarantId) throws IOException, ServletException {
		int menuId = Integer.parseInt(req.getParameter("menuId"));

		// ownership check: make sure this menu item actually belongs to the owner's restaurant
		Menu existing = menuDAOImpl.getMenu(menuId);
		if (existing == null || existing.getRestuarantId() != restuarantId) {
			return; // not their item, silently ignore
		}

		String itemName = req.getParameter("itemName");
		String description = req.getParameter("description");
		float price = parseFloatSafe(req.getParameter("price"), 0f);
		boolean isAvailable = "on".equals(req.getParameter("isAvailable"));

		Menu menu = new Menu();
		menu.setMenuId(menuId);
		menu.setRestuarantId(restuarantId);
		menu.setItemName(itemName);
		menu.setDescription(description);
		menu.setPrice(price);
		menu.setImagePath(resolveImagePath(req));
		menu.setAvailable(isAvailable);

		menuDAOImpl.updateMenu(menu);
	}

	private String resolveImagePath(HttpServletRequest req) throws IOException, ServletException {

		Part imagePart = req.getPart("imageFile");
		String existingImagePath = req.getParameter("existingImagePath");

		if (imagePart == null || imagePart.getSize() == 0) {
			return existingImagePath;
		}

		String submittedFileName = imagePart.getSubmittedFileName();
		String extension = "";
		if (submittedFileName != null && submittedFileName.contains(".")) {
			extension = submittedFileName.substring(submittedFileName.lastIndexOf('.')).toLowerCase();
		}

		if (!isAllowedImageExtension(extension)) {
			return existingImagePath;
		}

		String realUploadDir = req.getServletContext().getRealPath("/" + UPLOAD_DIR);
		File uploadDirFile = new File(realUploadDir);
		if (!uploadDirFile.exists()) {
			uploadDirFile.mkdirs();
		}

		String newFileName = UUID.randomUUID().toString() + extension;
		Path targetPath = uploadDirFile.toPath().resolve(newFileName);

		try (InputStream in = imagePart.getInputStream()) {
			Files.copy(in, targetPath, StandardCopyOption.REPLACE_EXISTING);
		}

		return UPLOAD_DIR + "/" + newFileName;
	}

	private boolean isAllowedImageExtension(String extension) {
		return extension.equals(".jpg") || extension.equals(".jpeg") || extension.equals(".png")
				|| extension.equals(".gif") || extension.equals(".webp");
	}

	private void listAndForward(HttpServletRequest req, HttpServletResponse resp, Restuarant myRestuarant)
			throws ServletException, IOException {

		List<Menu> allMenu = menuDAOImpl.getAllMenu(myRestuarant.getRestuarantId());

		req.setAttribute("allMenu", allMenu);
		req.setAttribute("restuarant", myRestuarant);

		RequestDispatcher rd = req.getRequestDispatcher("/owner/OwnerMenu.jsp");
		rd.forward(req, resp);
	}

	private float parseFloatSafe(String value, float fallback) {
		try {
			return Float.parseFloat(value);
		} catch (Exception e) {
			return fallback;
		}
	}
}