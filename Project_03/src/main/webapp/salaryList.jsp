<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Salary, model.Employee, java.sql.*, dao.connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách lương</title>
    <style>
        table { border-collapse: collapse; width: 90%; margin: 20px auto; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .button { padding: 5px 10px; margin: 5px; }
    </style>
</head>
<body>
    <h2>Danh sách lương</h2>
    <a href="salaryForm.jsp?action=add" class="button">Thêm lương</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên nhân viên</th>
            <th>Tháng</th>
            <th>Năm</th>
            <th>Lương cơ bản</th>
            <th>Phụ cấp</th>
            <th>Thưởng</th>
            <th>Tổng lương</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
        </tr>
        <%
            List<Salary> salaries = Salary.getAllSalaries();
            List<Employee> employees = null;

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

            if (salaries != null && !salaries.isEmpty()) {
                for (Salary sal : salaries) {
                    String employeeName = "";
                    for (Employee emp : employees) {
                        if (emp.getEmployeeId() == sal.getEmployeeId()) {
                            employeeName = emp.getFullName();
                            break;
                        }
                    }
        %>
            <tr>
                <td><%= sal.getSalaryId() %></td>
                <td><%= employeeName %></td>
                <td><%= sal.getMonth() %></td>
                <td><%= sal.getYear() %></td>
                <td><%= sal.getBasicSalary() != null ? sal.getBasicSalary() : "0.00" %></td>
                <td><%= sal.getAllowance() != null ? sal.getAllowance() : "0.00" %></td>
                <td><%= sal.getBonus() != null ? sal.getBonus() : "0.00" %></td>
                <td><%= sal.getFinalSalary() != null ? sal.getFinalSalary() : "0.00" %></td>
                <td><%= sal.getPaymentStatus() != null ? sal.getPaymentStatus() : "" %></td>
                <td>
                    <a href="salaryForm.jsp?action=update&id=<%= sal.getSalaryId() %>" class="button">Sửa</a>
                    <a href="SalaryServlet?action=delete&id=<%= sal.getSalaryId() %>" 
                       onclick="return confirm('Bạn có chắc muốn xóa?');" class="button">Xóa</a>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="10">Không có dữ liệu lương.</td>
            </tr>
        <%
            }
        %>
    </table>
</body>
</html>