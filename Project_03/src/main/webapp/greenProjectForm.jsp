<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.GreenProject, java.sql.*, dao.connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> dự án cây xanh</title>
    <style>
        .form-container { width: 50%; margin: 20px auto; }
        label { display: block; margin: 10px 0 5px; }
        input, select, textarea { width: 100%; padding: 5px; }
        .button { padding: 5px 10px; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> dự án cây xanh</h2>
        <%
            GreenProject proj = new GreenProject();
            String action = request.getParameter("action");
            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                try (Connection conn = connection.getConnection();
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdGreenProject WHERE TdtdProjectId = ? AND TdtdIsDeleted = FALSE")) {
                    stmt.setInt(1, id);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        proj.setProjectId(rs.getInt("TdtdProjectId"));
                        proj.setProjectName(rs.getString("TdtdProjectName"));
                        proj.setLocation(rs.getString("TdtdLocation"));
                        proj.setStartDate(rs.getDate("TdtdStartDate").toLocalDate());
                        proj.setEndDate(rs.getDate("TdtdEndDate") != null ? rs.getDate("TdtdEndDate").toLocalDate() : null);
                        proj.setStatus(rs.getString("TdtdStatus"));
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
        <form action="GreenProjectServlet" method="post">
            <input type="hidden" name="action" value="<%= action %>">
            <% if ("update".equals(action)) { %>
                <input type="hidden" name="TdtdProjectId" value="<%= proj.getProjectId() %>">
            <% } %>
            <label>Tên dự án:</label>
            <input type="text" name="TdtdProjectName" value="<%= proj.getProjectName() != null ? proj.getProjectName() : "" %>" required>
            <label>Vị trí:</label>
            <input type="text" name="TdtdLocation" value="<%= proj.getLocation() != null ? proj.getLocation() : "" %>" required>
            <label>Ngày bắt đầu:</label>
            <input type="date" name="TdtdStartDate" value="<%= proj.getStartDate() != null ? proj.getStartDate() : "" %>" required>
            <label>Ngày kết thúc:</label>
            <input type="date" name="TdtdEndDate" value="<%= proj.getEndDate() != null ? proj.getEndDate() : "" %>">
            <label>Trạng thái:</label>
            <select name="TdtdStatus" required>
                <option value="Chuẩn bị" <%= "Chuẩn bị".equals(proj.getStatus()) ? "selected" : "" %>>Chuẩn bị</option>
                <option value="Đang thực hiện" <%= "Đang thực hiện".equals(proj.getStatus()) ? "selected" : "" %>>Đang thực hiện</option>
                <option value="Hoàn thành" <%= "Hoàn thành".equals(proj.getStatus()) ? "selected" : "" %>>Hoàn thành</option>
                <option value="Tạm dừng" <%= "Tạm dừng".equals(proj.getStatus()) ? "selected" : "" %>>Tạm dừng</option>
            </select>
            <input type="submit" value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="button">
            <a href="greenProjectList.jsp" class="button">Quay lại</a>
        </form>
    </div>
</body>
</html>