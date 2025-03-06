<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Position" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách chức vụ</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid black; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        .button { padding: 5px 10px; margin: 5px; }
    </style>
</head>
<body>
    <h2>Danh sách chức vụ</h2>
    <a href="positionForm.jsp?action=add" class="button">Thêm chức vụ</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên chức vụ</th>
            <th>Lương cơ bản</th>
            <th>Thao tác</th>
        </tr>
        <%
            List<Position> positions = Position.getAllPosition();
            if (positions != null && !positions.isEmpty()) {
                for (Position pos : positions) {
        %>
            <tr>
                <td><%= pos.getPositionId() %></td>
                <td><%= pos.getPositionName() != null ? pos.getPositionName() : "" %></td>
                <td><%= pos.getSalaryBase() != null ? pos.getSalaryBase() : "" %> VND</td>
                <td>
                    <a href="positionForm.jsp?action=update&id=<%= pos.getPositionId() %>" class="button">Sửa</a>
                    <a href="PositionServlet?action=delete&id=<%= pos.getPositionId() %>" 
                       onclick="return confirm('Bạn có chắc muốn xóa?');" class="button">Xóa</a>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="4">Không có dữ liệu chức vụ.</td>
            </tr>
        <%
            }
        %>
    </table>
</body>
</html>