package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import dao.connection; // Package DAO theo yêu cầu

public class Attendance {
	private int attendanceId;
	private int employeeId;
	private LocalDate date;
	private LocalTime clockIn;
	private LocalTime clockOut;
	private String status;
	private boolean isDeleted;

	// Constructor
	public Attendance() {
	}

	public Attendance(int attendanceId, int employeeId, LocalDate date, LocalTime clockIn, LocalTime clockOut,
			String status, boolean isDeleted) {
		this.attendanceId = attendanceId;
		this.employeeId = employeeId;
		this.date = date;
		this.clockIn = clockIn;
		this.clockOut = clockOut;
		this.status = status;
		this.isDeleted = isDeleted;
	}

	// Getters and Setters
	public int getAttendanceId() {
		return attendanceId;
	}

	public void setAttendanceId(int attendanceId) {
		this.attendanceId = attendanceId;
	}

	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public LocalDate getDate() {
		return date;
	}

	public void setDate(LocalDate date) {
		this.date = date;
	}

	public LocalTime getClockIn() {
		return clockIn;
	}

	public void setClockIn(LocalTime clockIn) {
		this.clockIn = clockIn;
	}

	public LocalTime getClockOut() {
		return clockOut;
	}

	public void setClockOut(LocalTime clockOut) {
		this.clockOut = clockOut;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public boolean isDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	// Hàm lấy tất cả chấm công (chưa bị xóa) - static
	public static List<Attendance> getAllAttendances() {
		List<Attendance> attendances = new ArrayList<>();
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn
						.prepareStatement("SELECT * FROM TdtdAttendance WHERE TdtdIsDeleted = FALSE");
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				Attendance att = new Attendance();
				att.setAttendanceId(rs.getInt("TdtdAttendanceId"));
				att.setEmployeeId(rs.getInt("TdtdEmployeeId"));
				att.setDate(rs.getDate("TdtdDate").toLocalDate());
				att.setClockIn(rs.getTime("TdtdClockIn") != null ? rs.getTime("TdtdClockIn").toLocalTime() : null);
				att.setClockOut(rs.getTime("TdtdClockOut") != null ? rs.getTime("TdtdClockOut").toLocalTime() : null);
				att.setStatus(rs.getString("TdtdStatus"));
				attendances.add(att);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return attendances;
	}

	// Hàm thêm chấm công - static
	public static void add(int employeeId, LocalDate date, LocalTime clockIn, LocalTime clockOut, String status) {
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(
						"INSERT INTO TdtdAttendance (TdtdEmployeeId, TdtdDate, TdtdClockIn, TdtdClockOut, TdtdStatus, TdtdIsDeleted) VALUES (?, ?, ?, ?, ?, FALSE)")) {
			stmt.setInt(1, employeeId);
			stmt.setObject(2, date);
			stmt.setObject(3, clockIn);
			stmt.setObject(4, clockOut);
			stmt.setString(5, status);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Hàm sửa chấm công - static
	public static void update(int attendanceId, int employeeId, LocalDate date, LocalTime clockIn, LocalTime clockOut,
			String status) {
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(
						"UPDATE TdtdAttendance SET TdtdEmployeeId = ?, TdtdDate = ?, TdtdClockIn = ?, TdtdClockOut = ?, TdtdStatus = ? WHERE TdtdAttendanceId = ? AND TdtdIsDeleted = FALSE")) {
			stmt.setInt(1, employeeId);
			stmt.setObject(2, date);
			stmt.setObject(3, clockIn);
			stmt.setObject(4, clockOut);
			stmt.setString(5, status);
			stmt.setInt(6, attendanceId);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Hàm xóa mềm chấm công - static
	public static void delete(int attendanceId) {
		try (Connection conn = connection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(
						"UPDATE TdtdAttendance SET TdtdIsDeleted = TRUE WHERE TdtdAttendanceId = ?")) {
			stmt.setInt(1, attendanceId);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}