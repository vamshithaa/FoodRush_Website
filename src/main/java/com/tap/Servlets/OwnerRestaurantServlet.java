package com.tap.Servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.UUID;

import com.tap.model.Restuarant;
import com.tap.model.User;
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

@WebServlet("/owner/restaurant")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB per image
public class OwnerRestaurantServlet extends HttpServlet {

	private RestuarantDAOImpl restuarantDAOImpl = new RestuarantDAOImpl();
	private static final String UPLOAD_DIR = "images/restaurants";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		User owner = getOwner(req);
		Restuarant myRestuarant = restuarantDAOImpl.getRestuarantByOwnerId(owner.getUserId());

		if (myRestuarant != null) {
			// they already have a restaurant -> go straight to menu management
			resp.sendRedirect(req.getContextPath() + "/owner/menu");
			return;
		}

		// no restaurant yet -> show the setup form
		RequestDispatcher rd = req.getRequestDispatcher("/owner/OwnerRestaurantSetup.jsp");
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		User owner = getOwner(req);

		// safety check: don't let them create a second restaurant via a repeated POST
		Restuarant existing = restuarantDAOImpl.getRestuarantByOwnerId(owner.getUserId());
		if (existing != null) {
			resp.sendRedirect(req.getContextPath() + "/owner/menu");
			return;
		}

		String resName = req.getParameter("resName");
		String cuisineType = req.getParameter("cuisineType");
		String address = req.getParameter("address");
		int deliveryMinutes = parseIntSafe(req.getParameter("deliveryMinutes"), 30);

		Restuarant restuarant = new Restuarant();
		restuarant.setResName(resName);
		restuarant.setCuisineType(cuisineType);
		restuarant.setAddress(address);
		restuarant.setImagePath(resolveImagePath(req));
		restuarant.setRating(0f);
		restuarant.setActive(true);
		restuarant.setDeliveryTime(minutesToTimestamp(deliveryMinutes));
		restuarant.setOwnerId(owner.getUserId());

		restuarantDAOImpl.addRestuarant(restuarant);

		resp.sendRedirect(req.getContextPath() + "/owner/menu");
	}

	private User getOwner(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		return (User) session.getAttribute("user");
	}

	private String resolveImagePath(HttpServletRequest req) throws IOException, ServletException {

		Part imagePart = req.getPart("imageFile");

		if (imagePart == null || imagePart.getSize() == 0) {
			return null;
		}

		String submittedFileName = imagePart.getSubmittedFileName();
		String extension = "";
		if (submittedFileName != null && submittedFileName.contains(".")) {
			extension = submittedFileName.substring(submittedFileName.lastIndexOf('.')).toLowerCase();
		}

		if (!isAllowedImageExtension(extension)) {
			return null;
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

	private Timestamp minutesToTimestamp(int totalMinutes) {
		int hours = totalMinutes / 60;
		int minutes = totalMinutes % 60;

		Calendar cal = Calendar.getInstance();
		cal.set(1970, Calendar.JANUARY, 1, hours, minutes, 0);
		cal.set(Calendar.MILLISECOND, 0);

		return new Timestamp(cal.getTimeInMillis());
	}

	private int parseIntSafe(String value, int fallback) {
		try {
			return Integer.parseInt(value);
		} catch (Exception e) {
			return fallback;
		}
	}
}