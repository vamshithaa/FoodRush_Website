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
import com.tap.userDAOImpl.MenuDAOImpl;
import com.tap.userDAOImpl.RestuarantDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/admin/menu")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB per image
public class AdminMenuServlet extends HttpServlet {

	private MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
	private RestuarantDAOImpl restuarantDAOImpl = new RestuarantDAOImpl();
	private static final String UPLOAD_DIR = "images/menu";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int restuarantId = Integer.parseInt(req.getParameter("restuarantId"));
		String action = req.getParameter("action");

		if (action == null) {
			action = "list";
		}

		if (action.equals("delete")) {
			int id = Integer.parseInt(req.getParameter("id"));
			menuDAOImpl.deleteMenu(id);
			resp.sendRedirect(req.getContextPath() + "/admin/menu?restuarantId=" + restuarantId);
			return;
		}

		if (action.equals("edit")) {
			int id = Integer.parseInt(req.getParameter("id"));
			Menu menu = menuDAOImpl.getMenu(id);
			req.setAttribute("editMenu", menu);
		}

		listAndForward(req, resp, restuarantId);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int restuarantId = Integer.parseInt(req.getParameter("restuarantId"));
		String action = req.getParameter("action");

		if (action.equals("add")) {
			addMenu(req, restuarantId);
		} else if (action.equals("update")) {
			updateMenu(req, restuarantId);
		}

		resp.sendRedirect(req.getContextPath() + "/admin/menu?restuarantId=" + restuarantId);
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

	/**
	 * If a new image file was uploaded, save it to disk and return its path.
	 * Otherwise fall back to whatever image path was already on the item
	 * (sent along as a hidden field from the edit form), so editing other fields
	 * doesn't wipe out the existing image.
	 */
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

	private void listAndForward(HttpServletRequest req, HttpServletResponse resp, int restuarantId)
			throws ServletException, IOException {

		List<Menu> allMenu = menuDAOImpl.getAllMenu(restuarantId);
		Restuarant restuarant = restuarantDAOImpl.getRestuarant(restuarantId);

		req.setAttribute("allMenu", allMenu);
		req.setAttribute("restuarant", restuarant);

		RequestDispatcher rd = req.getRequestDispatcher("/admin/AdminMenu.jsp");
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