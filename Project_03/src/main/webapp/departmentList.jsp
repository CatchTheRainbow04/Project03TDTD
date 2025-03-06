<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Department" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách phòng ban</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid black; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        .button { padding: 5px 10px; margin: 5px; }
    </style>
</head>
<body>
    <h2>Danh sách phòng ban</h2>
    <a href="departmentForm.jsp?action=add" class="button">Thêm phòng ban</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên phòng ban</th>
            <th>Mô tả</th>
            <th>Hành động</th>
        </tr>
        <%
            List<Department> departments = Department.getAllDepartment();
            if (departments != null && !departments.isEmpty()) {
                for (Department dept : departments) {
        %>
            <tr>
                <td><%= dept.getDepartmentId() %></td>
                <td><%= dept.getDepartmentName() != null ? dept.getDepartmentName() : "" %></td>
                <td><%= dept.getDescription() != null ? dept.getDescription() : "" %></td>
                <td style = "text-align:center">
                    <a href="departmentForm.jsp?action=update&id=<%= dept.getDepartmentId() %>" class="button">Sửa</a>
                    <a href="DepartmentServlet?action=delete&id=<%= dept.getDepartmentId() %>" 
                       onclick="return confirm('Bạn có chắc muốn xóa?');" class="button">Xóa</a>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="4" style = "text-align:center">Không có dữ liệu phòng ban.</td>
            </tr>
        <%
            }
        %>
    </table>
</body>
</html>