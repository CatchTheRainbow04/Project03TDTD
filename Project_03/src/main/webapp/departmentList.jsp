<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Department" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách phòng ban</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/list_style.css">
</head>
<body>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">Danh sách phòng ban</h2>
            <a href="#" onclick="loadContent('departmentForm.jsp?action=add')" class="btn btn-add">
                <i class="fas fa-plus"></i> Thêm phòng ban
            </a>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên phòng ban</th>
                        <th>Mô tả</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Department> departments = Department.getAllDepartment();
                        if (departments != null && !departments.isEmpty()) {
                            for (Department dept : departments) {
                    %>
                    <tr>
                        <td><%= dept.getDepartmentId() %></td>
                        <td><%= dept.getDepartmentName() != null ? dept.getDepartmentName() : "" %></td>
                        <td><%= dept.getDescription() != null ? dept.getDescription() : "" %></td>
                        <td>
                            <a href="#" onclick="loadContent('departmentForm.jsp?action=update&id=<%= dept.getDepartmentId() %>')" 
                               class="btn btn-sm btn-edit">Sửa</a>
                            <a href="DepartmentServlet?action=delete&id=<%= dept.getDepartmentId() %>"
                               onclick="return confirm('Bạn có chắc muốn xóa?');" 
                               class="btn btn-sm btn-delete">Xóa</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" class="text-center">Không có dữ liệu phòng ban.</td>
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