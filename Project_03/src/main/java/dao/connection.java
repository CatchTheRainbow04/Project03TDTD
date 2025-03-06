package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class connection {
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/mydatabase";
	private static final String JDBC_USERNAME = "root";
	private static final String JDBC_PASSWORD = "";

	public static Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new SQLException("Không tìm thấy Driver MySQL", e);
		}
		return DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
	}
}
