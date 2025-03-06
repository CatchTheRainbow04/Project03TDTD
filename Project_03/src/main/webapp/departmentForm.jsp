<%@page import="dao.connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Department, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> phòng ban</title>
    <style>
        .form-container { width: 50%; margin: 20px auto; }
        label { display: block; margin: 10px 0 5px; }
        input, textarea { width: 100%; padding: 5px; }
        .button { padding: 5px 10px; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> phòng ban</h2>
        <%
            Department dept = new Department();
            String action = request.getParameter("action");
            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = connection.getConnection();
                    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdDepartment WHERE TdtdDepartmentId = ?");
                    stmt.setInt(1, id);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        dept.setDepartmentId(rs.getInt("TdtdDepartmentId"));
                        dept.setDepartmentName(rs.getString("TdtdDepartmentName"));
                        dept.setDescription(rs.getString("TdtdDescription"));
                    }
                    rs.close(); stmt.close(); conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
        <form action="DepartmentServlet" method="post">
            <input type="hidden" name="action" value="<%= action %>">
            <% if ("update".equals(action)) { %>
                <input type="hidden" name="TdtdDepartmentId" value="<%= dept.getDepartmentId() %>">
            <% } %>
            <label>Tên phòng ban:</label>
            <input type="text" name="TdtdDepartmentName" value="<%= dept.getDepartmentName() != null ? dept.getDepartmentName() : "" %>" required>
            <label>Mô tả:</label>
            <textarea name="TdtdDescription"><%= dept.getDescription() != null ? dept.getDescription() : "" %></textarea>
            <input type="submit" value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="button">
            <a href="departmentList.jsp" class="button">Quay lại</a>
        </form>
    </div>
</body>
</html>