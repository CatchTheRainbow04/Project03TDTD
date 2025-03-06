<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="model.Attendance, model.Employee, java.sql.*, dao.connection, java.util.List, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %>
	chấm công</title>
<style>
.form-container {
	width: 50%;
	margin: 20px auto;
}

label {
	display: block;
	margin: 10px 0 5px;
}

input, select, textarea {
	width: 100%;
	padding: 5px;
}

.button {
	padding: 5px 10px;
	margin-top: 10px;
}
</style>
</head>
<body>
	<div class="form-container">
		<h2><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %>
			chấm công
		</h2>
		<%
            Attendance att = new Attendance();
            String action = request.getParameter("action");
            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                try (Connection conn = connection.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdAttendance WHERE TdtdAttendanceId = ? AND TdtdIsDeleted = FALSE")) {
                    stmt.setInt(1, id);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        att.setAttendanceId(rs.getInt("TdtdAttendanceId"));
                        att.setEmployeeId(rs.getInt("TdtdEmployeeId"));
                        att.setDate(rs.getDate("TdtdDate").toLocalDate());
                        att.setClockIn(rs.getTime("TdtdClockIn") != null ? rs.getTime("TdtdClockIn").toLocalTime() : null);
                        att.setClockOut(rs.getTime("TdtdClockOut") != null ? rs.getTime("TdtdClockOut").toLocalTime() : null);
                        att.setStatus(rs.getString("TdtdStatus"));
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            // Lấy danh sách nhân viên
            List<Employee> employees = new ArrayList<>();
            try (Connection conn = connection.getConnection();
                 Statement stmt = conn.createStatement()) {
                ResultSet rsEmployees = stmt.executeQuery("SELECT TdtdEmployeeId, TdtdFullName FROM TdtdEmployee WHERE TdtdIsDeleted = FALSE");
                while (rsEmployees.next()) {
                    Employee emp = new Employee();
                    emp.setEmployeeId(rsEmployees.getInt("TdtdEmployeeId"));
                    emp.setFullName(rsEmployees.getString("TdtdFullName"));
                    employees.add(emp);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
		<form action="AttendanceServlet" method="post">
			<input type="hidden" name="action" value="<%= action %>">
			<% if ("update".equals(action)) { %>
			<input type="hidden" name="attendanceId"
				value="<%= att.getAttendanceId() %>">
			<% } %>
			<label>Nhân viên:</label> <select name="employeeId" required>
				<% for (Employee emp : employees) { %>
				<option value="<%= emp.getEmployeeId() %>"
					<%= emp.getEmployeeId() == att.getEmployeeId() ? "selected" : "" %>>
					<%= emp.getFullName() %>
				</option>
				<% } %>
			</select> <label>Ngày:</label> <input type="date" name="date"
				value="<%= att.getDate() != null ? att.getDate() : "" %>" required>
			<label>Giờ vào:</label> <input type="time" name="clockIn"
				value="<%= att.getClockIn() != null ? att.getClockIn() : "" %>">
			<label>Giờ ra:</label> <input type="time" name="clockOut"
				value="<%= att.getClockOut() != null ? att.getClockOut() : "" %>">
			<label>Trạng thái:</label> <select name="status" required>
				<option value="Đi làm"
					<%= "Đi làm".equals(att.getStatus()) ? "selected" : "" %>>Đi
					làm</option>
				<option value="Vắng mặt"
					<%= "Vắng mặt".equals(att.getStatus()) ? "selected" : "" %>>Vắng
					mặt</option>
				<option value="Nghỉ phép"
					<%= "Nghỉ phép".equals(att.getStatus()) ? "selected" : "" %>>Nghỉ
					phép</option>
			</select> <input type="submit"
				value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="button">
			<a href="AttendanceServlet" class="button">Quay lại</a>
		</form>
	</div>
</body>
</html>