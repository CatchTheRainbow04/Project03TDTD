<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List, model.Attendance, model.Employee, java.sql.*,java.util.*, dao.connection"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách chấm công</title>
<style>
table {
	border-collapse: collapse;
	width: 80%;
	margin: 20px auto;
}

th, td {
	border: 1px solid black;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}

.button {
	padding: 5px 10px;
	margin: 5px;
}
</style>
</head>
<body>
	<h2>Danh sách chấm công</h2>
	<a href="attendanceForm.jsp?action=add" class="button">Thêm chấm
		công</a>
	<table>
		<tr>
			<th>ID</th>
			<th>Tên nhân viên</th>
			<th>Ngày</th>
			<th>Giờ vào</th>
			<th>Giờ ra</th>
			<th>Trạng thái</th>
			<th>Thao tác</th>
		</tr>
		<%
            List<Attendance> attendances = Attendance.getAllAttendances();
            List<Employee> employees = null;

            // Lấy danh sách nhân viên từ cơ sở dữ liệu
            try (Connection conn = connection.getConnection()) {
                Statement stmt = conn.createStatement();
                ResultSet rsEmployees = stmt.executeQuery("SELECT TdtdEmployeeId, TdtdFullName FROM TdtdEmployee WHERE TdtdIsDeleted = FALSE");
                employees = new ArrayList<>();
                while (rsEmployees.next()) {
                    Employee emp = new Employee();
                    emp.setEmployeeId(rsEmployees.getInt("TdtdEmployeeId"));
                    emp.setFullName(rsEmployees.getString("TdtdFullName"));
                    employees.add(emp);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            if (attendances != null && !attendances.isEmpty()) {
                for (Attendance att : attendances) {
                    String employeeName = "";
                    for (Employee emp : employees) {
                        if (emp.getEmployeeId() == att.getEmployeeId()) {
                            employeeName = emp.getFullName();
                            break;
                        }
                    }
        %>
		<tr>
			<td><%= att.getAttendanceId() %></td>
			<td><%= employeeName %></td>
			<td><%= att.getDate() != null ? new java.text.SimpleDateFormat("dd-MM-yyyy").format(java.sql.Date.valueOf(att.getDate())) : "" %></td>
			<td><%= att.getClockIn() != null ? att.getClockIn() : "" %></td>
			<td><%= att.getClockOut() != null ? att.getClockOut() : "" %></td>
			<td><%= att.getStatus() != null ? att.getStatus() : "" %></td>
			<td><a
				href="attendanceForm.jsp?action=update&id=<%= att.getAttendanceId() %>"
				class="button">Sửa</a> <a
				href="AttendanceServlet?action=delete&id=<%= att.getAttendanceId() %>"
				onclick="return confirm('Bạn có chắc muốn xóa?');" class="button">Xóa</a>
			</td>
		</tr>
		<%
                }
            } else {
        %>
		<tr>
			<td colspan="7">Không có dữ liệu chấm công.</td>
		</tr>
		<%
            }
        %>
	</table>
</body>
</html>