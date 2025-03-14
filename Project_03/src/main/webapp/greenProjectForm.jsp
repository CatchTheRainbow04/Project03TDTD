<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.GreenProject, java.sql.*, dao.connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> dự án cây xanh</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container mt-4">
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
            <form action="GreenProjectServlet" method="post" class="form-group">
                <input type="hidden" name="action" value="<%= action %>">
                <% if ("update".equals(action)) { %>
                <input type="hidden" name="TdtdProjectId" value="<%= proj.getProjectId() %>">
                <% } %>
                <div class="mb-3">
                    <label for="TdtdProjectName">Tên dự án:</label>
                    <input type="text" id="TdtdProjectName" name="TdtdProjectName" class="form-control"
                           value="<%= proj.getProjectName() != null ? proj.getProjectName() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="TdtdLocation">Vị trí:</label>
                    <input type="text" id="TdtdLocation" name="TdtdLocation" class="form-control"
                           value="<%= proj.getLocation() != null ? proj.getLocation() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="TdtdStartDate">Ngày bắt đầu:</label>
                    <input type="date" id="TdtdStartDate" name="TdtdStartDate" class="form-control"
                           value="<%= proj.getStartDate() != null ? proj.getStartDate() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="TdtdEndDate">Ngày kết thúc:</label>
                    <input type="date" id="TdtdEndDate" name="TdtdEndDate" class="form-control"
                           value="<%= proj.getEndDate() != null ? proj.getEndDate() : "" %>">
                </div>
                <div class="mb-3">
                    <label for="TdtdStatus">Trạng thái:</label>
                    <select id="TdtdStatus" name="TdtdStatus" class="form-control" required>
                        <option value="Chuẩn bị" <%= "Chuẩn bị".equals(proj.getStatus()) ? "selected" : "" %>>Chuẩn bị</option>
                        <option value="Đang thực hiện" <%= "Đang thực hiện".equals(proj.getStatus()) ? "selected" : "" %>>Đang thực hiện</option>
                        <option value="Hoàn thành" <%= "Hoàn thành".equals(proj.getStatus()) ? "selected" : "" %>>Hoàn thành</option>
                        <option value="Tạm dừng" <%= "Tạm dừng".equals(proj.getStatus()) ? "selected" : "" %>>Tạm dừng</option>
                    </select>
                </div>
                <div class="d-flex justify-content-between">
                    <input type="submit" value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="btn btn-add">
                    <a href="GreenProjectServlet" class="btn btn-delete">Quay lại</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>