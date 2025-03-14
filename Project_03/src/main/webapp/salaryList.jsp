<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Salary, model.Employee" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách lương</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/list_style.css">
</head>
<body>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">Danh sách lương</h2>
            <a href="#" onclick="loadContent('salaryForm.jsp?action=add')" class="btn btn-add">
                <i class="fas fa-plus"></i> Thêm lương
            </a>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-striped">
                <thead class="thead-dark">
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
                </thead>
                <tbody>
                    <%
                        List<Salary> salaries = Salary.getAllSalaries();
                        List<Employee> employees = Employee.getAllEmployee();

                        if (salaries != null && !salaries.isEmpty()) {
                            for (Salary sal : salaries) {
                                String employeeName = "N/A";
                                if (employees != null) {
                                    for (Employee emp : employees) {
                                        if (emp.getEmployeeId() == sal.getEmployeeId()) {
                                            employeeName = emp.getFullName();
                                            break;
                                        }
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
                        <td>
                            <span class="status <%= sal.getPaymentStatus() != null && sal.getPaymentStatus().equals("Đã thanh toán") ? "active" : "inactive" %>">
                                <%= sal.getPaymentStatus() != null ? sal.getPaymentStatus() : "" %>
                            </span>
                        </td>
                        <td>
                            <a href="#" onclick="loadContent('salaryForm.jsp?action=update&id=<%= sal.getSalaryId() %>')" 
                               class="btn btn-sm btn-edit">Sửa</a>
                            <a href="SalaryServlet?action=delete&id=<%= sal.getSalaryId() %>"
                               onclick="return confirm('Bạn có chắc muốn xóa?');" 
                               class="btn btn-sm btn-delete">Xóa</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="10" class="text-center">Không có dữ liệu lương.</td>
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