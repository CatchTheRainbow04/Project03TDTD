package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Attendance;

/**
 * Servlet implementation class AttendanceServlet
 */
@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			Attendance.delete(id);
		}
		response.sendRedirect("attendanceList.jsp");
	}

	// Xử lý thêm hoặc sửa
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		int employeeId = Integer.parseInt(request.getParameter("employeeId"));
		LocalDate date = LocalDate.parse(request.getParameter("date"));
		String clockInStr = request.getParameter("clockIn");
		LocalTime clockIn = (clockInStr != null && !clockInStr.isEmpty()) ? LocalTime.parse(clockInStr) : null;
		String clockOutStr = request.getParameter("clockOut");
		LocalTime clockOut = (clockOutStr != null && !clockOutStr.isEmpty()) ? LocalTime.parse(clockOutStr) : null;
		String status = request.getParameter("status");

		if ("add".equals(action)) {
			Attendance.add(employeeId, date, clockIn, clockOut, status);
		} else if ("update".equals(action)) {
			int attendanceId = Integer.parseInt(request.getParameter("attendanceId"));
			Attendance.update(attendanceId, employeeId, date, clockIn, clockOut, status);
		}

		response.sendRedirect("attendanceList.jsp");
	}
}
