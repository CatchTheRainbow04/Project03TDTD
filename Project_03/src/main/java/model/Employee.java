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

public class Employee {
	private int employeeId;
	private int departmentId;
	private int positionId;
	private String fullName;
	private LocalDate dateOfBirth;
	private String gender; // Có thể dùng enum nếu muốn
	private String phoneNumber;
	private String email;
	private LocalDate hireDate;
	private String status; // Có thể dùng enum nếu muốn
	private boolean isDeleted;

	// Constructor
	public Employee() {
	}

	public Employee(int employeeId, int departmentId, int positionId, String fullName, LocalDate dateOfBirth,
			String gender, String phoneNumber, String email, LocalDate hireDate, String status, boolean isDeleted) {
		this.employeeId = employeeId;
		this.departmentId = departmentId;
		this.positionId = positionId;
		this.fullName = fullName;
		this.dateOfBirth = dateOfBirth;
		this.gender = gender;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.hireDate = hireDate;
		this.status = status;
		this.isDeleted = isDeleted;
	}

	// Getters and Setters
	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public int getPositionId() {
		return positionId;
	}

	public void setPositionId(int positionId) {
		this.positionId = positionId;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public LocalDate getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(LocalDate dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public LocalDate getHireDate() {
		return hireDate;
	}

	public void setHireDate(LocalDate hireDate) {
		this.hireDate = hireDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setIsDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public boolean getIsDeleted() {
		return isDeleted;
	}

	public static List<Employee> getAllEmployee() throws ClassNotFoundException {
		List<Employee> employees = new ArrayList<>();
		try {
			try (Connection conn = connection.getConnection();
					Statement stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("SELECT * FROM TdtdEmployee WHERE tdtdIsDeleted = FALSE")) {

				while (rs.next()) {
					Employee emp = new Employee();
					emp.setEmployeeId(rs.getInt("TdtdEmployeeId"));
					emp.setDepartmentId(rs.getInt("TdtdDepartmentId"));
					emp.setPositionId(rs.getInt("TdtdPositionId"));
					emp.setFullName(rs.getString("TdtdFullName"));
					emp.setDateOfBirth(rs.getDate("TdtdDateOfBirth").toLocalDate());
					emp.setGender(rs.getString("TdtdGender"));
					emp.setPhoneNumber(rs.getString("TdtdPhoneNumber"));
					emp.setEmail(rs.getString("TdtdEmail"));
					emp.setHireDate(rs.getDate("TdtdHireDate").toLocalDate());
					emp.setStatus(rs.getString("TdtdStatus"));
					emp.setIsDeleted(rs.getBoolean("TdtdIsDeleted"));
					employees.add(emp);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return employees;
	}

	public static void addEmployee(int departmentId, int positionId, String fullName, LocalDate dateOfBirth,
			String gender, String phoneNumber, String email, LocalDate hireDate, String status) {
		try {
			try (Connection conn = connection.getConnection();
					PreparedStatement stmt = conn.prepareStatement(
							"INSERT INTO TdtdEmployee (TdtdDepartmentId, TdtdPositionId, TdtdFullName, TdtdDateOfBirth, TdtdGender, TdtdPhoneNumber, TdtdEmail, TdtdHireDate, TdtdStatus, TdtdIsDeleted) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, FALSE)")) {
				stmt.setInt(1, departmentId);
				stmt.setInt(2, positionId);
				stmt.setString(3, fullName);
				stmt.setObject(4, dateOfBirth);
				stmt.setString(5, gender);
				stmt.setString(6, phoneNumber);
				stmt.setString(7, email);
				stmt.setObject(8, hireDate);
				stmt.setString(9, status);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void updateEmployee(int id, int departmentId, int positionId, String fullName, LocalDate dateOfBirth,
			String gender, String phoneNumber, String email, LocalDate hireDate, String status) {
		try {
			try (Connection conn = connection.getConnection();
					PreparedStatement stmt = conn.prepareStatement(
							"UPDATE TdtdEmployee SET TdtdDepartmentId = ?, TdtdPositionId = ?, TdtdFullName = ?, TdtdDateOfBirth = ?, TdtdGender = ?, TdtdPhoneNumber = ?, TdtdEmail = ?, TdtdHireDate = ?, TdtdStatus = ? WHERE TdtdEmployeeId = ? AND TdtdIsDeleted = FALSE")) {
				stmt.setInt(1, departmentId);
				stmt.setInt(2, positionId);
				stmt.setString(3, fullName);
				stmt.setObject(4, dateOfBirth);
				stmt.setString(5, gender);
				stmt.setString(6, phoneNumber);
				stmt.setString(7, email);
				stmt.setObject(8, hireDate);
				stmt.setString(9, status);
				stmt.setInt(10, id);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void deleteEmployee(int id) {
		try {
			try (Connection conn = connection.getConnection();
					PreparedStatement stmt = conn.prepareStatement(
							"UPDATE TdtdEmployee SET TdtdIsDeleted = TRUE WHERE TdtdEmployeeId = ?")) {
				stmt.setInt(1, id);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}