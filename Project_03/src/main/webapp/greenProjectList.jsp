<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.GreenProject" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách dự án cây xanh</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid black; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        .button { padding: 5px 10px; margin: 5px; }
    </style>
</head>
<body>
    <h2>Danh sách dự án cây xanh</h2>
    <a href="greenProjectForm.jsp?action=add" class="button">Thêm dự án</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên dự án</th>
            <th>Vị trí</th>
            <th>Ngày bắt đầu</th>
            <th>Ngày kết thúc</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
        </tr>
        <%
            List<GreenProject> projects = GreenProject.getAllGreenProjects();
            if (projects != null && !projects.isEmpty()) {
                for (GreenProject proj : projects) {
        %>
            <tr>
                <td><%= proj.getProjectId() %></td>
                <td><%= proj.getProjectName() != null ? proj.getProjectName() : "" %></td>
                <td><%= proj.getLocation() != null ? proj.getLocation() : "" %></td>
                <td><%= proj.getStartDate() != null ? proj.getStartDate() : "" %></td>
                <td><%= proj.getEndDate() != null ? proj.getEndDate() : "" %></td>
                <td><%= proj.getStatus() != null ? proj.getStatus() : "" %></td>
                <td>
                    <a href="greenProjectForm.jsp?action=update&id=<%= proj.getProjectId() %>" class="button">Sửa</a>
                    <a href="GreenProjectServlet?action=delete&id=<%= proj.getProjectId() %>" 
                       onclick="return confirm('Bạn có chắc muốn xóa?');" class="button">Xóa</a>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="7">Không có dữ liệu dự án.</td>
            </tr>
        <%
            }
        %>
    </table>
</body>
</html>