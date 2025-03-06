<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, model.Salary, model.Employee, java.sql.*, dao.connection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=request.getParameter("action").equals("add") ? "Thêm" : "Sửa"%>
	lương</title>
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
		<h2><%=request.getParameter("action").equals("add") ? "Thêm" : "Sửa"%>
			lương
		</h2>
		<%
		Salary sal = new Salary();
		String action = request.getParameter("action");
		if ("update".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			try (Connection conn = connection.getConnection();
			PreparedStatement stmt = conn
					.prepareStatement("SELECT * FROM TdtdSalary WHERE TdtdSalaryId = ? AND TdtdIsDeleted = FALSE")) {
				stmt.setInt(1, id);
				ResultSet rs = stmt.executeQuery();
				if (rs.next()) {
			sal.setSalaryId(rs.getInt("TdtdSalaryId"));
			sal.setEmployeeId(rs.getInt("TdtdEmployeeId"));
			sal.setMonth(rs.getInt("TdtdMonth"));
			sal.setYear(rs.getInt("TdtdYear"));
			sal.setBasicSalary(rs.getBigDecimal("TdtdBasicSalary"));
			sal.setAllowance(rs.getBigDecimal("TdtdAllowance"));
			sal.setBonus(rs.getBigDecimal("TdtdBonus"));
			sal.setFinalSalary(rs.getBigDecimal("TdtdFinalSalary"));
			sal.setPaymentStatus(rs.getString("TdtdPaymentStatus"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		List<Employee> employees = new ArrayList<>();
		try (Connection conn = connection.getConnection(); Statement stmt = conn.createStatement()) {
			ResultSet rsEmployees = stmt
			.executeQuery("SELECT TdtdEmployeeId, TdtdFullName FROM TdtdEmployee WHERE TdtdIsDeleted = FALSE");
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
		<form action="SalaryServlet" method="post">
			<input type="hidden" name="action" value="<%=action%>">
			<%
			if ("update".equals(action)) {
			%>
			<input type="hidden" name="salaryId" value="<%=sal.getSalaryId()%>">
			<%
			}
			%>
			<label>Nhân viên:</label> <select name="employeeId" required>
				<%
				for (Employee emp : employees) {
				%>
				<option value="<%=emp.getEmployeeId()%>"
					<%=emp.getEmployeeId() == sal.getEmployeeId() ? "selected" : ""%>>
					<%=emp.getFullName()%>
				</option>
				<%
				}
				%>
			</select> <label>Tháng:</label> <input type="number" name="month" min="1"
				max="12" value="<%=sal.getMonth() != 0 ? sal.getMonth() : ""%>"
				required> <label>Năm:</label> <input type="number"
				name="year" min="2000" max="9999"
				value="<%=sal.getYear() != 0 ? sal.getYear() : ""%>" required>
			<label>Lương cơ bản:</label> <input type="number" step="0.01"
				name="basicSalary"
				value="<%=sal.getBasicSalary() != null ? sal.getBasicSalary() : "0.00"%>"
				required> <label>Phụ cấp:</label> <input type="number"
				step="0.01" name="allowance"
				value="<%=sal.getAllowance() != null ? sal.getAllowance() : "0.00"%>"
				required> <label>Thưởng:</label> <input type="number"
				step="0.01" name="bonus"
				value="<%=sal.getBonus() != null ? sal.getBonus() : "0.00"%>"
				required> <label>Trạng thái thanh toán:</label> <select
				name="paymentStatus" required>
				<option value="Chưa thanh toán"
					<%="Chưa thanh toán".equals(sal.getPaymentStatus()) ? "selected" : ""%>>Chưa
					thanh toán</option>
				<option value="Đã thanh toán"
					<%="Đã thanh toán".equals(sal.getPaymentStatus()) ? "selected" : ""%>>Đã
					thanh toán</option>
			</select> <input type="submit"
				value="<%=action.equals("add") ? "Thêm" : "Sửa"%>" class="button">
			<a href="SalaryServlet" class="button">Quay lại</a>
		</form>
	</div>
</body>
</html>