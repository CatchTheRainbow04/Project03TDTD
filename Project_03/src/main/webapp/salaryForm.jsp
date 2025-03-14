<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Salary, model.Employee, java.sql.*, dao.connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> lương</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container mt-4">
        <div class="form-container">
            <h2><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> lương</h2>
            <%
                Salary sal = new Salary();
                String action = request.getParameter("action");
                if ("update".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    try (Connection conn = connection.getConnection();
                         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdSalary WHERE TdtdSalaryId = ? AND TdtdIsDeleted = FALSE")) {
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
            <form action="SalaryServlet" method="post" class="form-group">
                <input type="hidden" name="action" value="<%= action %>">
                <% if ("update".equals(action)) { %>
                <input type="hidden" name="salaryId" value="<%= sal.getSalaryId() %>">
                <% } %>
                <div class="mb-3">
                    <label for="employeeId">Nhân viên:</label>
                    <select id="employeeId" name="employeeId" class="form-control" required>
                        <% for (Employee emp : employees) { %>
                        <option value="<%= emp.getEmployeeId() %>"
                            <%= emp.getEmployeeId() == sal.getEmployeeId() ? "selected" : "" %>>
                            <%= emp.getFullName() %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="month">Tháng:</label>
                    <input type="number" id="month" name="month" class="form-control" min="1" max="12"
                           value="<%= sal.getMonth() != 0 ? sal.getMonth() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="year">Năm:</label>
                    <input type="number" id="year" name="year" class="form-control" min="2000" max="9999"
                           value="<%= sal.getYear() != 0 ? sal.getYear() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="basicSalary">Lương cơ bản:</label>
                    <input type="number" id="basicSalary" name="basicSalary" class="form-control" step="0.01"
                           value="<%= sal.getBasicSalary() != null ? sal.getBasicSalary() : "0.00" %>" required>
                </div>
                <div class="mb-3">
                    <label for="allowance">Phụ cấp:</label>
                    <input type="number" id="allowance" name="allowance" class="form-control" step="0.01"
                           value="<%= sal.getAllowance() != null ? sal.getAllowance() : "0.00" %>" required>
                </div>
                <div class="mb-3">
                    <label for="bonus">Thưởng:</label>
                    <input type="number" id="bonus" name="bonus" class="form-control" step="0.01"
                           value="<%= sal.getBonus() != null ? sal.getBonus() : "0.00" %>" required>
                </div>
                <div class="mb-3">
                    <label for="paymentStatus">Trạng thái thanh toán:</label>
                    <select id="paymentStatus" name="paymentStatus" class="form-control" required>
                        <option value="Chưa thanh toán" <%= "Chưa thanh toán".equals(sal.getPaymentStatus()) ? "selected" : "" %>>Chưa thanh toán</option>
                        <option value="Đã thanh toán" <%= "Đã thanh toán".equals(sal.getPaymentStatus()) ? "selected" : "" %>>Đã thanh toán</option>
                    </select>
                </div>
                <div class="d-flex justify-content-between">
                    <input type="submit" value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="btn btn-add">
                    <a href="SalaryServlet" class="btn btn-delete">Quay lại</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>