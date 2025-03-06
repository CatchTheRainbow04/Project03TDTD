<%@page import="dao.connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List, model.Employee, model.Department, model.Position, java.sql.*, java.util.List , java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %>
	nhân viên</title>
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
			nhân viên
		</h2>
		<%
            Employee emp = new Employee();
            String action = request.getParameter("action");
            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                try {
                	 Connection conn = connection.getConnection();
                    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdEmployee WHERE TdtdEmployeeId = ? AND TdtdIsDeleted = FALSE");
                    stmt.setInt(1, id);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
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
                    }
                    rs.close(); stmt.close(); conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
		<form action="EmployeeServlet" method="post">
			<input type="hidden" name="action" value="<%= action %>">
			<% if ("update".equals(action)) { %>
			<input type="hidden" name="TdtdEmployeeId"
				value="<%= emp.getEmployeeId() %>">
			<% } %>
			<label>Phòng ban:</label> <select name="TdtdDepartmentId" required>
				<%
                    List<Department> departments = Department.getAllDepartment();
                    if (departments == null) {
                        try {
                            Connection conn = connection.getConnection();
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM TdtdDepartment WHERE TdtdIsDeleted = FALSE");
                            departments = new ArrayList<>();
                            while (rs.next()) {
                                Department dept = new Department();
                                dept.setDepartmentId(rs.getInt("TdtdDepartmentId"));
                                dept.setDepartmentName(rs.getString("TdtdDepartmentName"));
                                departments.add(dept);
                            }
                            rs.close(); stmt.close(); conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    for (Department dept : departments) {
                %>
				<option value="<%= dept.getDepartmentId() %>"
					<%= dept.getDepartmentId() == emp.getDepartmentId() ? "selected" : "" %>>
					<%= dept.getDepartmentName() %>
				</option>
				<%
                    }
                %>
			</select> <label>Chức vụ:</label> <select name="TdtdPositionId" required>
				<%
                    List<Position> positions = Position.getAllPosition();
                    if (positions == null) {
                        try {
                        	Connection conn = connection.getConnection();
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM TdtdPosition WHERE TdtdIsDeleted = FALSE");
                            positions = new ArrayList<>();
                            while (rs.next()) {
                                Position pos = new Position();
                                pos.setPositionId(rs.getInt("TdtdPositionId"));
                                pos.setPositionName(rs.getString("TdtdPositionName"));
                                positions.add(pos);
                            }
                            rs.close(); stmt.close(); conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    for (Position pos : positions) {
                %>
				<option value="<%= pos.getPositionId() %>"
					<%= pos.getPositionId() == emp.getPositionId() ? "selected" : "" %>>
					<%= pos.getPositionName() %>
				</option>
				<%
                    }
                %>
			</select> <label>Họ tên:</label> <input type="text" name="TdtdFullName"
				value="<%= emp.getFullName() != null ? emp.getFullName() : "" %>"
				required> <label>Ngày sinh:</label> <input type="date"
				name="TdtdDateOfBirth"
				value="<%= emp.getDateOfBirth() != null ? emp.getDateOfBirth() : "" %>"
				required> <label>Giới tính:</label> <select
				name="TdtdGender" required>
				<option value="Nam"
					<%= "Nam".equals(emp.getGender()) ? "selected" : "" %>>Nam</option>
				<option value="Nữ"
					<%= "Nữ".equals(emp.getGender()) ? "selected" : "" %>>Nữ</option>
				<option value="Khác"
					<%= "Khác".equals(emp.getGender()) ? "selected" : "" %>>Khác</option>
			</select> <label>Số điện thoại:</label> <input type="text"
				name="TdtdPhoneNumber"
				value="<%= emp.getPhoneNumber() != null ? emp.getPhoneNumber() : "" %>"
				required> <label>Email:</label> <input type="email"
				name="TdtdEmail"
				value="<%= emp.getEmail() != null ? emp.getEmail() : "" %>">
			<label>Ngày tuyển dụng:</label> <input type="date"
				name="TdtdHireDate"
				value="<%= emp.getHireDate() != null ? emp.getHireDate() : "" %>"
				required> <label>Trạng thái:</label> <select
				name="TdtdStatus" required>
				<option value="Đang làm việc"
					<%= "Đang làm việc".equals(emp.getStatus()) ? "selected" : "" %>>Đang
					làm việc</option>
				<option value="Đã nghỉ việc"
					<%= "Đã nghỉ việc".equals(emp.getStatus()) ? "selected" : "" %>>Đã
					nghỉ việc</option>
				<option value="Tạm nghỉ"
					<%= "Tạm nghỉ".equals(emp.getStatus()) ? "selected" : "" %>>Tạm
					nghỉ</option>
			</select> <input type="submit"
				value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="button">
			<a href="employeeList.jsp" class="button">Quay lại</a>
		</form>
	</div>
</body>
</html>