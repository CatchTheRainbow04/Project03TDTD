<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Department, java.sql.*, dao.connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> phòng ban</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container mt-4">
        <div class="form-container">
            <h2><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> phòng ban</h2>
            <%
                Department dept = new Department();
                String action = request.getParameter("action");
                if ("update".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    try (Connection conn = connection.getConnection();
                         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdDepartment WHERE TdtdDepartmentId = ?")) {
                        stmt.setInt(1, id);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            dept.setDepartmentId(rs.getInt("TdtdDepartmentId"));
                            dept.setDepartmentName(rs.getString("TdtdDepartmentName"));
                            dept.setDescription(rs.getString("TdtdDescription"));
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
            <form action="DepartmentServlet" method="post" class="form-group">
                <input type="hidden" name="action" value="<%= action %>">
                <% if ("update".equals(action)) { %>
                <input type="hidden" name="TdtdDepartmentId" value="<%= dept.getDepartmentId() %>">
                <% } %>
                <div class="mb-3">
                    <label for="TdtdDepartmentName">Tên phòng ban:</label>
                    <input type="text" id="TdtdDepartmentName" name="TdtdDepartmentName" class="form-control"
                           value="<%= dept.getDepartmentName() != null ? dept.getDepartmentName() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="TdtdDescription">Mô tả:</label>
                    <textarea id="TdtdDescription" name="TdtdDescription" class="form-control"><%= dept.getDescription() != null ? dept.getDescription() : "" %></textarea>
                </div>
                <div class="d-flex justify-content-between">
                    <input type="submit" value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="btn btn-add">
                    <a href="DepartmentServlet" class="btn btn-delete">Quay lại</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>