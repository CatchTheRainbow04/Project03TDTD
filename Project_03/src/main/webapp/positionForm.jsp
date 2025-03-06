<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Position, java.sql.* , dao.connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> chức vụ</title>
    <style>
        .form-container { width: 50%; margin: 20px auto; }
        label { display: block; margin: 10px 0 5px; }
        input, textarea { width: 100%; padding: 5px; }
        .button { padding: 5px 10px; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> chức vụ</h2>
        <%
            Position pos = new Position();
            String action = request.getParameter("action");
            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = connection.getConnection();
                    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdPosition WHERE TdtdPositionId = ? AND TdtdIsDeleted = FALSE");
                    stmt.setInt(1, id);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        pos.setPositionId(rs.getInt("TdtdPositionId"));
                        pos.setPositionName(rs.getString("TdtdPositionName"));
                        pos.setSalaryBase(rs.getBigDecimal("TdtdSalaryBase"));
                    }
                    rs.close(); stmt.close(); conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
        <form action="PositionServlet" method="post">
            <input type="hidden" name="action" value="<%= action %>">
            <% if ("update".equals(action)) { %>
                <input type="hidden" name="TdtdPositionId" value="<%= pos.getPositionId() %>">
            <% } %>
            <label>Tên chức vụ:</label>
            <input type="text" name="TdtdPositionName" value="<%= pos.getPositionName() != null ? pos.getPositionName() : "" %>" required>
            <label>Lương cơ bản:</label>
            <input type="number" step="0.01" name="TdtdSalaryBase" value="<%= pos.getSalaryBase() != null ? pos.getSalaryBase() : "0.00" %>" required>
            <input type="submit" value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="button">
            <a href="positionList.jsp" class="button">Quay lại</a>
        </form>
    </div>
</body>
</html>