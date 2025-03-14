<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Position" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách chức vụ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/list_style.css">
</head>
<body>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">Danh sách chức vụ</h2>
            <a href="#" onclick="loadContent('positionForm.jsp?action=add')" class="btn btn-add">
                <i class="fas fa-plus"></i> Thêm chức vụ
            </a>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên chức vụ</th>
                        <th>Lương cơ bản</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Position> positions = Position.getAllPosition();
                        if (positions != null && !positions.isEmpty()) {
                            for (Position pos : positions) {
                    %>
                    <tr>
                        <td><%= pos.getPositionId() %></td>
                        <td><%= pos.getPositionName() != null ? pos.getPositionName() : "" %></td>
                        <td><%= pos.getSalaryBase() != null ? pos.getSalaryBase() : "0" %> VND</td>
                        <td>
                            <a href="#" onclick="loadContent('positionForm.jsp?action=update&id=<%= pos.getPositionId() %>')" 
                               class="btn btn-sm btn-edit">Sửa</a>
                            <a href="PositionServlet?action=delete&id=<%= pos.getPositionId() %>"
                               onclick="return confirm('Bạn có chắc muốn xóa?');" 
                               class="btn btn-sm btn-delete">Xóa</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" class="text-center">Không có dữ liệu chức vụ.</td>
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