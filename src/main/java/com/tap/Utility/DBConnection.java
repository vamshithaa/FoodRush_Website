package com.tap.Utility;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;

public class DBConnection {

	// Reads Clever Cloud's auto-injected MYSQL_ADDON_* vars in production.
	// Falls back to local defaults so the app still runs unchanged on your machine.
	private static String env(String key, String fallback) {
		String value = System.getenv(key);
		return (value == null || value.isEmpty()) ? fallback : value;
	}

	public static final String HOST = env("MYSQL_ADDON_HOST", "localhost");
	public static final String PORT = env("MYSQL_ADDON_PORT", "3306");
	public static final String DB_NAME = env("MYSQL_ADDON_DB", "food_delivery_app");
	public static final String USERNAME = env("MYSQL_ADDON_USER", "root");
	public static final String PASSWORD = env("MYSQL_ADDON_PASSWORD", "");

	public static final String URL =
			"jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME + "?useSSL=true&serverTimezone=UTC";

	public static Connection con;

	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
}
