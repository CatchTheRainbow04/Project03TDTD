package model;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dao.connection;

public class Position {
	private int positionId;
	private String positionName;
	private BigDecimal salaryBase;
	private boolean isDeleted;

	// Constructor
	public Position() {
	}

	public Position(int positionId, String positionName, BigDecimal salaryBase, boolean isDeleted) {
		this.positionId = positionId;
		this.positionName = positionName;
		this.salaryBase = salaryBase;
		this.isDeleted = isDeleted;
	}

	// Getters and Setters
	public int getPositionId() {
		return positionId;
	}

	public void setPositionId(int positionId) {
		this.positionId = positionId;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	public BigDecimal getSalaryBase() {
		return salaryBase;
	}

	public void setSalaryBase(BigDecimal salaryBase) {
		this.salaryBase = salaryBase;
	}

	public boolean getIsDeleted() {
		return isDeleted;
	}

	public void setIsDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}
	
	public static List<Position> getAllPosition() {
		List<Position> positions = new ArrayList<>();
		try {
			try (Connection conn = connection.getConnection();
					Statement stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("SELECT * FROM TdtdPosition where TdtdIsDeleted = false")) {

				while (rs.next()) {
					Position post = new Position();
					post.setPositionId(rs.getInt("TdtdPositionId"));
					post.setPositionName(rs.getString("TdtdPositionName"));
					post.setSalaryBase(rs.getBigDecimal("TdtdSalaryBase"));
					positions.add(post);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return positions;
	}
	public static void addPosition(String name, BigDecimal salaryBase) {
		try {
			try (Connection conn = connection.getConnection();
					PreparedStatement stmt = conn.prepareStatement(
							"INSERT INTO TdtdPosition (TdtdPositionName, TdtdSalaryBase) VALUES (?, ?)")) {
				stmt.setString(1, name);
				stmt.setBigDecimal(2, salaryBase);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void updatePosition(int id, String name, BigDecimal salaryBase) {
		try {
			try (Connection conn = connection.getConnection();
					PreparedStatement stmt = conn.prepareStatement(
							"UPDATE TdtdPosition SET TdtdPositionName = ?, TdtdSalaryBase = ? WHERE TdtdPositionId = ?")) {
				stmt.setString(1, name);
				stmt.setBigDecimal(2, salaryBase);
				stmt.setInt(3, id);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void deletePosition(int id) {
		try {
			try (Connection conn = connection.getConnection();
					PreparedStatement stmt = conn.prepareStatement(
							"update TdtdPosition set TdtdIsDeleted = true where TdtdPositionId = ?")) {
				stmt.setInt(1, id);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}