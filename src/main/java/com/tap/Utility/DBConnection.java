package com.tap.Utility;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;

public class DBConnection {

	// Reads standard DB_* env vars (set these in Render's dashboard using
	// your Aiven MySQL connection details). Falls back to local defaults
	// so the app still runs unchanged on your machine.
	private static String env(String key, String fallback) {
		String value = System.getenv(key);
		return (value == null || value.isEmpty()) ? fallback : value;
	}

	public static final String HOST = env("DB_HOST", "localhost");
	public static final String PORT = env("DB_PORT", "3306");
	public static final String DB_NAME = env("DB_NAME", "food_delivery_app");
	public static final String USERNAME = env("DB_USER", "root");
	public static final String PASSWORD = env("DB_PASSWORD", "");

	// sslMode=REQUIRED: Aiven's MySQL requires an encrypted connection.
	public static final String URL =
			"jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME + "?sslMode=REQUIRED&serverTimezone=UTC";

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