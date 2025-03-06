<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List, model.Employee, model.Department, model.Position"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách nhân viên</title>
<style>
table {
	border-collapse: collapse;
	width: 90%;
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
	<h2>Danh sách nhân viên</h2>
	<a href="employeeForm.jsp?action=add" class="button">Thêm nhân viên</a>
	<table>
		<tr>
			<th>ID</th>
			<th>Họ tên</th>
			<th>Phòng ban</th>
			<th>Chức vụ</th>
			<th>Ngày sinh</th>
			<th>Giới tính</th>
			<th>SĐT</th>
			<th>Email</th>
			<th>Ngày tuyển</th>
			<th>Trạng thái</th>
			<th>Thao tác</th>
		</tr>
		<%
            List<Employee> employees = Employee.getAllEmployee();
            List<Department> departments = Department.getAllDepartment();
            List<Position> positions = Position.getAllPosition();
            if (employees != null && !employees.isEmpty()) {
                for (Employee emp : employees) {
                    String deptName = "";
                    String posName = "";
                    for (Department dept : departments) {
                        if (dept.getDepartmentId() == emp.getDepartmentId()) {
                            deptName = dept.getDepartmentName();
                            break;
                        }
                    }
                    for (Position pos : positions) {
                        if (pos.getPositionId() == emp.getPositionId()) {
                            posName = pos.getPositionName();
                            break;
                        }
                    }
        %>
		<tr>
			<td><%= emp.getEmployeeId() %></td>
			<td><%= emp.getFullName() != null ? emp.getFullName() : "" %></td>
			<td><%= deptName %></td>
			<td><%= posName %></td>
			<td><%= emp.getDateOfBirth() != null ? new java.text.SimpleDateFormat("dd-MM-yyyy").format(java.sql.Date.valueOf(emp.getDateOfBirth())) : "" %></td>
			<td><%= emp.getGender() != null ? emp.getGender() : "" %></td>
			<td><%= emp.getPhoneNumber() != null ? emp.getPhoneNumber() : "" %></td>
			<td><%= emp.getEmail() != null ? emp.getEmail() : "" %></td>
			<td><%= emp.getHireDate() != null ? new java.text.SimpleDateFormat("dd-MM-yyyy").format(java.sql.Date.valueOf(emp.getHireDate())) : "" %></td>
			<td><%= emp.getStatus() != null ? emp.getStatus() : "" %></td>
			<td><a
				href="employeeForm.jsp?action=update&id=<%= emp.getEmployeeId() %>"
				class="button">Sửa</a> <a
				href="EmployeeServlet?action=delete&id=<%= emp.getEmployeeId() %>"
				onclick="return confirm('Bạn có chắc muốn xóa?');" class="button">Xóa</a>
			</td>
		</tr>
		<%
                }
            } else {
        %>
		<tr>
			<td colspan="11">Không có dữ liệu nhân viên.</td>
		</tr>
		<%
            }
        %>
	</table>
</body>
</html>