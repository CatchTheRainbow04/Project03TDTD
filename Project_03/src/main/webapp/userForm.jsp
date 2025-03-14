<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User, java.sql.*, dao.connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> người dùng</title>
    <style>
        .form-container { width: 50%; margin: 20px auto; }
        label { display: block; margin: 10px 0 5px; }
        input, select { width: 100%; padding: 5px; }
        .button { padding: 5px 10px; margin-top: 10px; }
        .error { color: red; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> người dùng</h2>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error"><%= error %></div>
        <%
            }

            User user = new User();
            String action = request.getParameter("action");
            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                try (Connection conn = connection.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdUser WHERE TdtdUserId = ? AND TdtdIsDeleted = FALSE")) {
                    stmt.setInt(1, id);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        user.setUserId(rs.getInt("TdtdUserId"));
                        int empId = rs.getInt("TdtdEmployeeId");
                        user.setEmployeeId(rs.wasNull() ? null : empId);
                        user.setUsername(rs.getString("TdtdUsername"));
                        user.setPassword(rs.getString("TdtdPassword"));
                        user.setRole(rs.getString("TdtdRole"));
                        user.setActive(rs.getBoolean("TdtdIsActive"));
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } else if ("add".equals(action) && error != null) {
                // Giữ lại giá trị đã nhập nếu thêm thất bại
                user.setEmployeeId((Integer) request.getAttribute("employeeId"));
                user.setUsername((String) request.getAttribute("username"));
                user.setPassword((String) request.getAttribute("password"));
                user.setRole((String) request.getAttribute("role"));
                user.setActive(request.getAttribute("isActive") != null && (Boolean) request.getAttribute("isActive"));
            }
        %>
        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="<%= action %>">
            <% if ("update".equals(action)) { %>
                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
            <% } %>
            <label>ID Nhân viên (nếu có):</label>
            <input type="number" name="employeeId" value="<%= user.getEmployeeId() != null ? user.getEmployeeId() : "" %>">
            <label>Tên đăng nhập:</label>
            <input type="text" name="username" value="<%= user.getUsername() != null ? user.getUsername() : "" %>" required>
            <label>Mật khẩu:</label>
            <input type="password" name="password" value="<%= user.getPassword() != null ? user.getPassword() : "" %>" required>
            <label>Vai trò:</label>
            <select name="role" required>
                <option value="HR" <%= "HR".equals(user.getRole()) ? "selected" : "" %>>HR</option>
                <option value="Employee" <%= "Employee".equals(user.getRole()) ? "selected" : "" %>>Employee</option>
                <option value="Manager" <%= "Manager".equals(user.getRole()) ? "selected" : "" %>>Manager</option>
            </select>
            <label>Hoạt động:</label>
            <select name="isActive" required>
                <option value="true" <%= user.isActive() ? "selected" : "" %>>Có</option>
                <option value="false" <%= !user.isActive() ? "selected" : "" %>>Không</option>
            </select>
            <input type="submit" value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="button">
            <a href="#" onclick="loadContent('userList.jsp')" class="button">Quay lại</a>
        </form>
    </div>
</body>
</html>