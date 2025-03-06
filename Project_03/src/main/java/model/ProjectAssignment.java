package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import dao.connection;

public class ProjectAssignment {
	private int assignmentId;
	private int projectId;
	private int employeeId;
	private String role;
	private LocalDate startDate;
	private LocalDate endDate;

	// Constructor
	public ProjectAssignment() {
	}

	public ProjectAssignment(int assignmentId, int projectId, int employeeId, String role, LocalDate startDate,
			LocalDate endDate) {
		this.assignmentId = assignmentId;
		this.projectId = projectId;
		this.employeeId = employeeId;
		this.role = role;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	// Getters and Setters
	public int getAssignmentId() {
		return assignmentId;
	}

	public void setAssignmentId(int assignmentId) {
		this.assignmentId = assignmentId;
	}

	public int getProjectId() {
		return projectId;
	}

	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}

	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public LocalDate getStartDate() {
		return startDate;
	}

	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}

	public LocalDate getEndDate() {
		return endDate;
	}

	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}

	// Hàm lấy tất cả phân công dự án (chưa bị xóa)
	public static List<ProjectAssignment> getAllProjectAssignments() {
		List<ProjectAssignment> assignments = new ArrayList<>();
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn
						.prepareStatement("SELECT * FROM TdtdProjectAssignment WHERE TdtdIsDeleted = FALSE");
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				ProjectAssignment assign = new ProjectAssignment();
				assign.setAssignmentId(rs.getInt("TdtdAssignmentId"));
				assign.setProjectId(rs.getInt("TdtdProjectId"));
				assign.setEmployeeId(rs.getInt("TdtdEmployeeId"));
				assign.setRole(rs.getString("TdtdRole"));
				assign.setStartDate(rs.getDate("TdtdStartDate").toLocalDate());
				assign.setEndDate(rs.getDate("TdtdEndDate") != null ? rs.getDate("TdtdEndDate").toLocalDate() : null);
				assignments.add(assign);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return assignments;
	}

	// Hàm thêm phân công dự án
	public static void addProjectAssignment(ProjectAssignment x) {
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(
						"INSERT INTO TdtdProjectAssignment (TdtdProjectId, TdtdEmployeeId, TdtdRole, TdtdStartDate, TdtdEndDate, TdtdIsDeleted) VALUES (?, ?, ?, ?, ?, FALSE)")) {
			stmt.setInt(1, x.getProjectId());
			stmt.setInt(2, x.getEmployeeId());
			stmt.setString(3, x.getRole());
			stmt.setObject(4, x.getStartDate());
			stmt.setObject(5, x.getEndDate());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Hàm sửa phân công dự án
	public static void updateProjectAssignment(ProjectAssignment x) {
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(
						"UPDATE TdtdProjectAssignment SET TdtdProjectId = ?, TdtdEmployeeId = ?, TdtdRole = ?, TdtdStartDate = ?, TdtdEndDate = ? WHERE TdtdAssignmentId = ? AND TdtdIsDeleted = FALSE")) {
			stmt.setInt(1, x.getProjectId());
			stmt.setInt(2, x.getEmployeeId());
			stmt.setString(3, x.getRole());
			stmt.setObject(4, x.getStartDate());
			stmt.setObject(5, x.getEndDate());
			stmt.setInt(6, x.getAssignmentId());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Hàm xóa mềm phân công dự án
	public static void deleteProjectAssignment(int id) {
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(
						"UPDATE TdtdProjectAssignment SET TdtdIsDeleted = TRUE WHERE TdtdAssignmentId = ?")) {
			stmt.setInt(1, id);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}