<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Position, java.sql.*, dao.connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> chức vụ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container mt-4">
        <div class="form-container">
            <h2><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> chức vụ</h2>
            <%
                Position pos = new Position();
                String action = request.getParameter("action");
                if ("update".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    try (Connection conn = connection.getConnection();
                         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdPosition WHERE TdtdPositionId = ? AND TdtdIsDeleted = FALSE")) {
                        stmt.setInt(1, id);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            pos.setPositionId(rs.getInt("TdtdPositionId"));
                            pos.setPositionName(rs.getString("TdtdPositionName"));
                            pos.setSalaryBase(rs.getBigDecimal("TdtdSalaryBase"));
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
            <form action="PositionServlet" method="post" class="form-group">
                <input type="hidden" name="action" value="<%= action %>">
                <% if ("update".equals(action)) { %>
                <input type="hidden" name="TdtdPositionId" value="<%= pos.getPositionId() %>">
                <% } %>
                <div class="mb-3">
                    <label for="TdtdPositionName">Tên chức vụ:</label>
                    <input type="text" id="TdtdPositionName" name="TdtdPositionName" class="form-control"
                           value="<%= pos.getPositionName() != null ? pos.getPositionName() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="TdtdSalaryBase">Lương cơ bản:</label>
                    <input type="number" id="TdtdSalaryBase" name="TdtdSalaryBase" class="form-control" step="0.01"
                           value="<%= pos.getSalaryBase() != null ? pos.getSalaryBase() : "0.00" %>" required>
                </div>
                <div class="d-flex justify-content-between">
                    <input type="submit" value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="btn btn-add">
                    <a href="PositionServlet" class="btn btn-delete">Quay lại</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>