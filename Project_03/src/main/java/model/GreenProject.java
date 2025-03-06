package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import dao.connection;

public class GreenProject {
	private int projectId;
	private String projectName;
	private String location;
	private LocalDate startDate;
	private LocalDate endDate;
	private String status; // Có thể dùng enum nếu muốn

	// Constructor
	public GreenProject() {
	}

	public GreenProject(int projectId, String projectName, String location, LocalDate startDate, LocalDate endDate,
			String status) {
		this.projectId = projectId;
		this.projectName = projectName;
		this.location = location;
		this.startDate = startDate;
		this.endDate = endDate;
		this.status = status;
	}

	// Getters and Setters
	public int getProjectId() {
		return projectId;
	}

	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	public static List<GreenProject> getAllGreenProjects() {
        List<GreenProject> projects = new ArrayList<>();
        try (Connection conn = connection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM TdtdGreenProject WHERE TdtdIsDeleted = FALSE")) {

            while (rs.next()) {
                GreenProject proj = new GreenProject();
                proj.setProjectId(rs.getInt("TdtdProjectId"));
                proj.setProjectName(rs.getString("TdtdProjectName"));
                proj.setLocation(rs.getString("TdtdLocation"));
                proj.setStartDate(rs.getDate("TdtdStartDate").toLocalDate());
                proj.setEndDate(rs.getDate("TdtdEndDate") != null ? rs.getDate("TdtdEndDate").toLocalDate() : null);
                proj.setStatus(rs.getString("TdtdStatus"));
                projects.add(proj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

	public static void addGreenProject(GreenProject greenPoroject) {
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(
						"INSERT INTO TdtdGreenProject (TdtdProjectName, TdtdLocation, TdtdStartDate, TdtdEndDate, TdtdStatus, TdtdIsDeleted) VALUES (?, ?, ?, ?, ?, FALSE)")) {
			stmt.setString(1, greenPoroject.getProjectName());
			stmt.setString(2, greenPoroject.getLocation());
			stmt.setObject(3, greenPoroject.getStartDate());
			stmt.setObject(4, greenPoroject.getEndDate());
			stmt.setString(5, greenPoroject.getStatus());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Hàm sửa dự án
	public static void updateGreenProject(GreenProject greenPoroject) {
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(
						"UPDATE TdtdGreenProject SET TdtdProjectName = ?, TdtdLocation = ?, TdtdStartDate = ?, TdtdEndDate = ?, TdtdStatus = ? WHERE TdtdProjectId = ? AND TdtdIsDeleted = FALSE")) {
			stmt.setString(1, greenPoroject.getProjectName());
			stmt.setString(2, greenPoroject.getLocation());
			stmt.setObject(3, greenPoroject.getStartDate());
			stmt.setObject(4, greenPoroject.getEndDate());
			stmt.setString(5, greenPoroject.getStatus());
			stmt.setInt(6, greenPoroject.getProjectId());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Hàm xóa mềm dự án
	public static void deleteGreenProject(int id) {
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn
						.prepareStatement("UPDATE TdtdGreenProject SET TdtdIsDeleted = TRUE WHERE TdtdProjectId = ?")) {
			stmt.setInt(1, id);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}