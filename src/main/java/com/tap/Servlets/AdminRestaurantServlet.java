package com.tap.Servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import com.tap.model.Restuarant;
import com.tap.userDAOImpl.RestuarantDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/admin/restaurants")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB per image
public class AdminRestaurantServlet extends HttpServlet {

	private RestuarantDAOImpl restuarantDAOImpl = new RestuarantDAOImpl();
	private static final String UPLOAD_DIR = "images/restaurants";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String action = req.getParameter("action");
		if (action == null) {
			action = "list";
		}

		if (action.equals("delete")) {
			int id = Integer.parseInt(req.getParameter("id"));
			restuarantDAOImpl.deleteRestuarant(id);
			resp.sendRedirect(req.getContextPath() + "/admin/restaurants");
			return;
		}

		if (action.equals("edit")) {
			int id = Integer.parseInt(req.getParameter("id"));
			Restuarant editRestuarant = restuarantDAOImpl.getRestuarant(id);
			req.setAttribute("editRestuarant", editRestuarant);
		}

		listAndForward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String action = req.getParameter("action");

		if ("add".equals(action)) {
			addRestuarant(req);
		} else if ("update".equals(action)) {
			updateRestuarant(req);
		}

		resp.sendRedirect(req.getContextPath() + "/admin/restaurants");
	}

	private void addRestuarant(HttpServletRequest req) throws IOException, ServletException {
		Restuarant restuarant = new Restuarant();
		populateFromRequest(req, restuarant);
		restuarantDAOImpl.addRestuarant(restuarant);
	}

	private void updateRestuarant(HttpServletRequest req) throws IOException, ServletException {
		int restuarantId = Integer.parseInt(req.getParameter("restuarantId"));
		Restuarant restuarant = new Restuarant();
		restuarant.setRestuarantId(restuarantId);
		populateFromRequest(req, restuarant);
		restuarantDAOImpl.updateRestuarant(restuarant);
	}

	private void populateFromRequest(HttpServletRequest req, Restuarant restuarant) throws IOException, ServletException {
		String resName = req.getParameter("resName");
		String cuisineType = req.getParameter("cuisineType");
		String address = req.getParameter("address");
		float rating = parseFloatSafe(req.getParameter("rating"), 0f);
		int deliveryMinutes = parseIntSafe(req.getParameter("deliveryMinutes"), 0);
		boolean isActive = "on".equals(req.getParameter("isActive"));

		restuarant.setResName(resName);
		restuarant.setCuisineType(cuisineType);
		restuarant.setAddress(address);
		restuarant.setImagePath(resolveImagePath(req));
		restuarant.setRating(rating);
		restuarant.setActive(isActive);
		restuarant.setDeliveryTime(minutesToTimestamp(deliveryMinutes));
	}

	/**
	 * If a new image file was uploaded, save it to disk and return its path.
	 * Otherwise fall back to whatever image path was already on the restaurant
	 * (sent along as a hidden field from the edit form), so editing other fields
	 * doesn't wipe out the existing image.
	 */
	private String resolveImagePath(HttpServletRequest req) throws IOException, ServletException {

		Part imagePart = req.getPart("imageFile");
		String existingImagePath = req.getParameter("existingImagePath");

		if (imagePart == null || imagePart.getSize() == 0) {
			// no new file chosen, keep whatever was there before (may be null/empty for a brand new restaurant)
			return existingImagePath;
		}

		String submittedFileName = imagePart.getSubmittedFileName();
		String extension = "";
		if (submittedFileName != null && submittedFileName.contains(".")) {
			extension = submittedFileName.substring(submittedFileName.lastIndexOf('.')).toLowerCase();
		}

		if (!isAllowedImageExtension(extension)) {
			// not an image we recognise, ignore the upload and keep the existing image
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

		// this is the path stored in the DB and used directly as <img src="...">
		return UPLOAD_DIR + "/" + newFileName;
	}

	private boolean isAllowedImageExtension(String extension) {
		return extension.equals(".jpg") || extension.equals(".jpeg") || extension.equals(".png")
				|| extension.equals(".gif") || extension.equals(".webp");
	}

	private Timestamp minutesToTimestamp(int totalMinutes) {
		int hours = totalMinutes / 60;
		int minutes = totalMinutes % 60;

		Calendar cal = Calendar.getInstance();
		cal.set(1970, Calendar.JANUARY, 1, hours, minutes, 0);
		cal.set(Calendar.MILLISECOND, 0);

		return new Timestamp(cal.getTimeInMillis());
	}

	private void listAndForward(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		List<Restuarant> allRestuarants = restuarantDAOImpl.getAllRestuarant();
		req.setAttribute("allRestuarants", allRestuarants);

		RequestDispatcher rd = req.getRequestDispatcher("/admin/AdminRestaurants.jsp");
		rd.forward(req, resp);
	}

	private float parseFloatSafe(String value, float fallback) {
		try {
			return Float.parseFloat(value);
		} catch (Exception e) {
			return fallback;
		}
	}

	private int parseIntSafe(String value, int fallback) {
		try {
			return Integer.parseInt(value);
		} catch (Exception e) {
			return fallback;
		}
	}
}