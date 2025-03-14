<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List, model.Employee, model.Department, model.Position, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách nhân viên</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/list_style.css">
</head>
<body>
	<div class="container mt-4">
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="mb-0">Danh sách nhân viên</h2>
			<a href="#" onclick="loadContent('employeeForm.jsp?action=add')"
				class="btn btn-add"> <i class="fas fa-plus"></i> Thêm nhân viên
			</a>
		</div>
		<div class="table-responsive">
			<table class="table table-hover table-striped">
				<thead class="thead-dark">
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
						<th colspan="2">Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<%
                        List<Employee> employees = Employee.getAllEmployee();
                        List<Department> departments = Department.getAllDepartment();
                        List<Position> positions = Position.getAllPosition();
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

                        if (employees != null && !employees.isEmpty()) {
                            for (Employee emp : employees) {
                                String deptName = "N/A";
                                String posName = "N/A";
                                if (departments != null) {
                                    for (Department dept : departments) {
                                        if (dept.getDepartmentId() == emp.getDepartmentId()) {
                                            deptName = dept.getDepartmentName();
                                            break;
                                        }
                                    }
                                }
                                if (positions != null) {
                                    for (Position pos : positions) {
                                        if (pos.getPositionId() == emp.getPositionId()) {
                                            posName = pos.getPositionName();
                                            break;
                                        }
                                    }
                                }
                    %>
					<tr>
						<td><%= emp.getEmployeeId() %></td>
						<td><%= emp.getFullName() != null ? emp.getFullName() : "" %></td>
						<td><%= deptName %></td>
						<td><%= posName %></td>
						<td><%= emp.getDateOfBirth() != null ? dateFormat.format(java.sql.Date.valueOf(emp.getDateOfBirth())) : "" %></td>
						<td><%= emp.getGender() != null ? emp.getGender() : "" %></td>
						<td><%= emp.getPhoneNumber() != null ? emp.getPhoneNumber() : "" %></td>
						<td><%= emp.getEmail() != null ? emp.getEmail() : "" %></td>
						<td><%= emp.getHireDate() != null ? dateFormat.format(java.sql.Date.valueOf(emp.getHireDate())) : "" %></td>
						<% String statusString = "red";
						String status = emp.getStatus();
						if(status.equals("Đang làm việc")){
							statusString = "blue";
						}
						if(status.equals("Tạm nghỉ")){
							statusString = "orange";
						}
						%>
						<td><span
							class="status <%= statusString %>">
								<%= status %>
						</span></td>
						<td><a href="#"
							onclick="loadContent('employeeForm.jsp?action=update&id=<%= emp.getEmployeeId() %>')"
							class="btn btn-sm btn-edit">Sửa</a></td>
						<td><a
							href="EmployeeServlet?action=delete&id=<%= emp.getEmployeeId() %>"
							onclick="return confirm('Bạn có chắc muốn xóa?');"
							class="btn btn-sm btn-delete">Xóa</a></td>
					</tr>
					<%
                            }
                        } else {
                    %>
					<tr>
						<td colspan="11" class="text-center">Không có dữ liệu nhân
							viên.</td>
					</tr>
					<%
                        }
                    %>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>