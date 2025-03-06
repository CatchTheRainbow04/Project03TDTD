package model;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.connection;

public class Salary {
	private int salaryId;
	private int employeeId;
	private int month;
	private int year;
	private BigDecimal basicSalary;
	private BigDecimal allowance;
	private BigDecimal bonus;
	private BigDecimal finalSalary;
	private String paymentStatus;
	private boolean isDeleted;

	// Constructor
	public Salary() {
	}

	public Salary(int salaryId, int employeeId, int month, int year, BigDecimal basicSalary, BigDecimal allowance,
			BigDecimal bonus, BigDecimal finalSalary, String paymentStatus, boolean isDeleted) {
		this.salaryId = salaryId;
		this.employeeId = employeeId;
		this.month = month;
		this.year = year;
		this.basicSalary = basicSalary;
		this.allowance = allowance;
		this.bonus = bonus;
		this.finalSalary = finalSalary; // Sẽ được tính lại trong add/update
		this.paymentStatus = paymentStatus;
		this.isDeleted = isDeleted;
	}

	// Getters and Setters
	public int getSalaryId() {
		return salaryId;
	}

	public void setSalaryId(int salaryId) {
		this.salaryId = salaryId;
	}

	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public BigDecimal getBasicSalary() {
		return basicSalary;
	}

	public void setBasicSalary(BigDecimal basicSalary) {
		this.basicSalary = basicSalary;
	}

	public BigDecimal getAllowance() {
		return allowance;
	}

	public void setAllowance(BigDecimal allowance) {
		this.allowance = allowance;
	}

	public BigDecimal getBonus() {
		return bonus;
	}

	public void setBonus(BigDecimal bonus) {
		this.bonus = bonus;
	}

	public BigDecimal getFinalSalary() {
		return finalSalary;
	}

	public void setFinalSalary(BigDecimal finalSalary) {
		this.finalSalary = finalSalary;
	}

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public boolean isDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	// Hàm tính finalSalary
	private static BigDecimal calculateFinalSalary(BigDecimal basicSalary, BigDecimal allowance, BigDecimal bonus) {
		// Xử lý null bằng cách thay bằng 0
		BigDecimal safeBasic = (basicSalary != null) ? basicSalary : BigDecimal.ZERO;
		BigDecimal safeAllowance = (allowance != null) ? allowance : BigDecimal.ZERO;
		BigDecimal safeBonus = (bonus != null) ? bonus : BigDecimal.ZERO;
		return safeBasic.add(safeAllowance).add(safeBonus);
	}

	// Hàm lấy tất cả lương (chưa bị xóa) - static
	public static List<Salary> getAllSalaries() {
		List<Salary> salaries = new ArrayList<>();
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdSalary WHERE TdtdIsDeleted = FALSE");
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				Salary sal = new Salary();
				sal.setSalaryId(rs.getInt("TdtdSalaryId"));
				sal.setEmployeeId(rs.getInt("TdtdEmployeeId"));
				sal.setMonth(rs.getInt("TdtdMonth"));
				sal.setYear(rs.getInt("TdtdYear"));
				sal.setBasicSalary(rs.getBigDecimal("TdtdBasicSalary"));
				sal.setAllowance(rs.getBigDecimal("TdtdAllowance"));
				sal.setBonus(rs.getBigDecimal("TdtdBonus"));
				sal.setFinalSalary(rs.getBigDecimal("TdtdFinalSalary"));
				sal.setPaymentStatus(rs.getString("TdtdPaymentStatus"));
				sal.setDeleted(rs.getBoolean("TdtdIsDeleted"));
				salaries.add(sal);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return salaries;
	}

	// Hàm thêm lương - static
	public static void add(int employeeId, int month, int year, BigDecimal basicSalary, BigDecimal allowance,
			BigDecimal bonus, String paymentStatus) {
		BigDecimal finalSalary = calculateFinalSalary(basicSalary, allowance, bonus);
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(
						"INSERT INTO TdtdSalary (TdtdEmployeeId, TdtdMonth, TdtdYear, TdtdBasicSalary, TdtdAllowance, TdtdBonus, TdtdFinalSalary, TdtdPaymentStatus, TdtdIsDeleted) VALUES (?, ?, ?, ?, ?, ?, ?, ?, FALSE)")) {
			stmt.setInt(1, employeeId);
			stmt.setByte(2, (byte) month);
			stmt.setShort(3, (short) year);
			stmt.setBigDecimal(4, basicSalary);
			stmt.setBigDecimal(5, allowance);
			stmt.setBigDecimal(6, bonus);
			stmt.setBigDecimal(7, finalSalary);
			stmt.setString(8, paymentStatus);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Hàm sửa lương - static
	public static void update(int salaryId, int employeeId, int month, int year, BigDecimal basicSalary,
			BigDecimal allowance, BigDecimal bonus, String paymentStatus) {
		BigDecimal finalSalary = calculateFinalSalary(basicSalary, allowance, bonus);
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(
						"UPDATE TdtdSalary SET TdtdEmployeeId = ?, TdtdMonth = ?, TdtdYear = ?, TdtdBasicSalary = ?, TdtdAllowance = ?, TdtdBonus = ?, TdtdFinalSalary = ?, TdtdPaymentStatus = ? WHERE TdtdSalaryId = ? AND TdtdIsDeleted = FALSE")) {
			stmt.setInt(1, employeeId);
			stmt.setByte(2, (byte) month);
			stmt.setShort(3, (short) year);
			stmt.setBigDecimal(4, basicSalary);
			stmt.setBigDecimal(5, allowance);
			stmt.setBigDecimal(6, bonus);
			stmt.setBigDecimal(7, finalSalary);
			stmt.setString(8, paymentStatus);
			stmt.setInt(9, salaryId);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Hàm xóa mềm lương - static
	public static void delete(int salaryId) {
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn
						.prepareStatement("UPDATE TdtdSalary SET TdtdIsDeleted = TRUE WHERE TdtdSalaryId = ?")) {
			stmt.setInt(1, salaryId);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}