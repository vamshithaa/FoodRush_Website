package com.tap.Servlets;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.tap.model.Order;
import com.tap.model.Restuarant;
import com.tap.model.User;
import com.tap.userDAOImpl.OrderDAOImpl;
import com.tap.userDAOImpl.RestuarantDAOImpl;
import com.tap.userDAOImpl.UserDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		RestuarantDAOImpl restuarantDAOImpl = new RestuarantDAOImpl();
		OrderDAOImpl orderDAOImpl = new OrderDAOImpl();
		UserDAOImpl userDAOImpl = new UserDAOImpl();

		List<Restuarant> allRestuarants = restuarantDAOImpl.getAllRestuarant();
		List<Order> allOrders = orderDAOImpl.getAllOrderItem();
		List<User> allUsers = userDAOImpl.getAllUser();

		req.setAttribute("restaurantCount", allRestuarants.size());
		req.setAttribute("orderCount", allOrders.size());
		req.setAttribute("userCount", allUsers.size());

		// orders are marked "Not delivered" at checkout until an admin updates them
		long pendingCount = allOrders.stream()
				.filter(o -> o.getStatus() != null && o.getStatus().equalsIgnoreCase("Not delivered"))
				.count();
		req.setAttribute("pendingOrderCount", pendingCount);

		// ---------- chart data ----------
		req.setAttribute("statusChartJson", buildStatusBreakdownJson(allOrders));
		req.setAttribute("trendChartJson", buildLast7DaysJson(allOrders));
		req.setAttribute("topRestaurantsChartJson", buildTopRestaurantsJson(allOrders, allRestuarants));

		RequestDispatcher rd = req.getRequestDispatcher("/admin/AdminDashboard.jsp");
		rd.forward(req, resp);
	}

	/** Doughnut chart: how many orders are in each status. */
	private String buildStatusBreakdownJson(List<Order> allOrders) {

		Map<String, Integer> counts = new LinkedHashMap<>();
		counts.put("Not delivered", 0);
		counts.put("Packed", 0);
		counts.put("Delivered", 0);
		counts.put("Cancelled", 0);

		for (Order o : allOrders) {
			String status = o.getStatus();
			if (status == null) continue;

			if (status.equalsIgnoreCase("Not delivered")) {
				counts.merge("Not delivered", 1, Integer::sum);
			} else if (status.equalsIgnoreCase("packed")) {
				counts.merge("Packed", 1, Integer::sum);
			} else if (status.equalsIgnoreCase("delivered")) {
				counts.merge("Delivered", 1, Integer::sum);
			} else if (status.equalsIgnoreCase("Cancelled")) {
				counts.merge("Cancelled", 1, Integer::sum);
			}
		}

		StringBuilder labels = new StringBuilder("[");
		StringBuilder values = new StringBuilder("[");
		boolean first = true;
		for (Map.Entry<String, Integer> entry : counts.entrySet()) {
			if (!first) {
				labels.append(",");
				values.append(",");
			}
			labels.append("\"").append(entry.getKey()).append("\"");
			values.append(entry.getValue());
			first = false;
		}
		labels.append("]");
		values.append("]");

		return "{\"labels\":" + labels + ",\"values\":" + values + "}";
	}

	/** Bar/line chart: order count & revenue for each of the last 7 days. */
	private String buildLast7DaysJson(List<Order> allOrders) {

		DateTimeFormatter labelFormat = DateTimeFormatter.ofPattern("MMM d");
		LinkedHashMap<LocalDate, Integer> orderCounts = new LinkedHashMap<>();
		LinkedHashMap<LocalDate, Double> revenue = new LinkedHashMap<>();

		LocalDate today = LocalDate.now();
		for (int i = 6; i >= 0; i--) {
			LocalDate day = today.minusDays(i);
			orderCounts.put(day, 0);
			revenue.put(day, 0.0);
		}

		for (Order o : allOrders) {
			if (o.getOrderDate() == null) continue;
			LocalDate day = o.getOrderDate().toLocalDateTime().toLocalDate();
			if (orderCounts.containsKey(day)) {
				orderCounts.merge(day, 1, Integer::sum);
				revenue.merge(day, o.getTotalAmount(), Double::sum);
			}
		}

		StringBuilder labels = new StringBuilder("[");
		StringBuilder counts = new StringBuilder("[");
		StringBuilder rev = new StringBuilder("[");
		boolean first = true;
		for (LocalDate day : orderCounts.keySet()) {
			if (!first) {
				labels.append(",");
				counts.append(",");
				rev.append(",");
			}
			labels.append("\"").append(day.format(labelFormat)).append("\"");
			counts.append(orderCounts.get(day));
			rev.append(String.format("%.2f", revenue.get(day)));
			first = false;
		}
		labels.append("]");
		counts.append("]");
		rev.append("]");

		return "{\"labels\":" + labels + ",\"orderCounts\":" + counts + ",\"revenue\":" + rev + "}";
	}

	/** Horizontal bar chart: top 5 restaurants by number of orders. */
	private String buildTopRestaurantsJson(List<Order> allOrders, List<Restuarant> allRestuarants) {

		Map<Integer, String> nameById = new HashMap<>();
		for (Restuarant r : allRestuarants) {
			nameById.put(r.getRestuarantId(), r.getResName());
		}

		Map<Integer, Integer> orderCountByRestaurant = new HashMap<>();
		for (Order o : allOrders) {
			orderCountByRestaurant.merge(o.getRestuarantId(), 1, Integer::sum);
		}

		List<Map.Entry<Integer, Integer>> sorted = new java.util.ArrayList<>(orderCountByRestaurant.entrySet());
		sorted.sort((a, b) -> b.getValue() - a.getValue());

		StringBuilder labels = new StringBuilder("[");
		StringBuilder values = new StringBuilder("[");
		boolean first = true;
		int limit = Math.min(5, sorted.size());
		for (int i = 0; i < limit; i++) {
			Map.Entry<Integer, Integer> entry = sorted.get(i);
			String name = nameById.getOrDefault(entry.getKey(), "Restaurant #" + entry.getKey());
			name = name.replace("\"", "'"); // keep the JSON simple/safe

			if (!first) {
				labels.append(",");
				values.append(",");
			}
			labels.append("\"").append(name).append("\"");
			values.append(entry.getValue());
			first = false;
		}
		labels.append("]");
		values.append("]");

		return "{\"labels\":" + labels + ",\"values\":" + values + "}";
	}
}