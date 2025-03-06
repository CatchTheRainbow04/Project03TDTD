package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.connection;

public class Department {
	private int departmentId;
	private String departmentName;
	private String description;
	private boolean isDeleted;

	// Constructor
	public Department() {
	}

	public Department(int departmentId, String departmentName, String description, boolean isDeleted) {
		this.departmentId = departmentId;
		this.departmentName = departmentName;
		this.description = description;
		this.isDeleted = isDeleted;
	}

	// Getters and Setters
	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public static List<Department> getAllDepartment() throws ClassNotFoundException {
		List<Department> departments = new ArrayList<>();
		try {
			try (Connection conn = connection.getConnection();
					Statement stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("SELECT * FROM TdtdDepartment where tdtdisdeleted = false")) {

				while (rs.next()) {
					Department dept = new Department();
					dept.setDepartmentId(rs.getInt("TdtdDepartmentId"));
					dept.setDepartmentName(rs.getString("TdtdDepartmentName"));
					dept.setDescription(rs.getString("TdtdDescription"));
					departments.add(dept);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return departments;
	}

	public static void addDepartment(String name, String description) {
		try {
			try (Connection conn = connection.getConnection();
					PreparedStatement stmt = conn.prepareStatement(
							"INSERT INTO TdtdDepartment (TdtdDepartmentName, TdtdDescription) VALUES (?, ?)")) {
				stmt.setString(1, name);
				stmt.setString(2, description);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void updateDepartment(int id, String name, String description) {
		try {
			try (Connection conn = connection.getConnection();
					PreparedStatement stmt = conn.prepareStatement(
							"UPDATE TdtdDepartment SET TdtdDepartmentName = ?, TdtdDescription = ? WHERE TdtdDepartmentId = ?")) {
				stmt.setString(1, name);
				stmt.setString(2, description);
				stmt.setInt(3, id);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void deleteDepartment(int id) {
		try {
			try (Connection conn = connection.getConnection();
					PreparedStatement stmt = conn.prepareStatement(
							"update tdtdDepartment set tdtdIsDeleted = true where tdtdDepartmentId = ?")) {
				stmt.setInt(1, id);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}