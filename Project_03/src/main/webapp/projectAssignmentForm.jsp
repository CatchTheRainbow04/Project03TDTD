<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ProjectAssignment, model.GreenProject, model.Employee, java.sql.*, dao.connection, java.util.*, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> phân công dự án</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container mt-4">
        <div class="form-container">
            <h2><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> phân công dự án</h2>
            <%
                ProjectAssignment assign = new ProjectAssignment();
                String action = request.getParameter("action");
                if ("update".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    try (Connection conn = connection.getConnection();
                         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdProjectAssignment WHERE TdtdAssignmentId = ? AND TdtdIsDeleted = FALSE")) {
                        stmt.setInt(1, id);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            assign.setAssignmentId(rs.getInt("TdtdAssignmentId"));
                            assign.setProjectId(rs.getInt("TdtdProjectId"));
                            assign.setEmployeeId(rs.getInt("TdtdEmployeeId"));
                            assign.setRole(rs.getString("TdtdRole"));
                            assign.setStartDate(rs.getDate("TdtdStartDate").toLocalDate());
                            assign.setEndDate(rs.getDate("TdtdEndDate") != null ? rs.getDate("TdtdEndDate").toLocalDate() : null);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                List<GreenProject> projects = new ArrayList<>();
                List<Employee> employees = new ArrayList<>();
                try (Connection conn = connection.getConnection();
                     Statement stmt = conn.createStatement()) {
                    ResultSet rsProjects = stmt.executeQuery("SELECT TdtdProjectId, TdtdProjectName FROM TdtdGreenProject WHERE TdtdIsDeleted = FALSE");
                    while (rsProjects.next()) {
                        GreenProject proj = new GreenProject();
                        proj.setProjectId(rsProjects.getInt("TdtdProjectId"));
                        proj.setProjectName(rsProjects.getString("TdtdProjectName"));
                        projects.add(proj);
                    }
                    ResultSet rsEmployees = stmt.executeQuery("SELECT TdtdEmployeeId, TdtdFullName FROM TdtdEmployee WHERE TdtdIsDeleted = FALSE");
                    while (rsEmployees.next()) {
                        Employee emp = new Employee();
                        emp.setEmployeeId(rsEmployees.getInt("TdtdEmployeeId"));
                        emp.setFullName(rsEmployees.getString("TdtdFullName"));
                        employees.add(emp);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
            <form action="ProjectAssignmentServlet" method="post" class="form-group">
                <input type="hidden" name="action" value="<%= action %>">
                <% if ("update".equals(action)) { %>
                <input type="hidden" name="TdtdAssignmentId" value="<%= assign.getAssignmentId() %>">
                <% } %>
                <div class="mb-3">
                    <label for="TdtdProjectId">Dự án:</label>
                    <select id="TdtdProjectId" name="TdtdProjectId" class="form-control" required>
                        <% for (GreenProject proj : projects) { %>
                        <option value="<%= proj.getProjectId() %>"
                            <%= proj.getProjectId() == assign.getProjectId() ? "selected" : "" %>>
                            <%= proj.getProjectName() %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="TdtdEmployeeId">Nhân viên:</label>
                    <select id="TdtdEmployeeId" name="TdtdEmployeeId" class="form-control" required>
                        <% for (Employee emp : employees) { %>
                        <option value="<%= emp.getEmployeeId() %>"
                            <%= emp.getEmployeeId() == assign.getEmployeeId() ? "selected" : "" %>>
                            <%= emp.getFullName() %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="TdtdRole">Vai trò:</label>
                    <input type="text" id="TdtdRole" name="TdtdRole" class="form-control"
                           value="<%= assign.getRole() != null ? assign.getRole() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="TdtdStartDate">Ngày bắt đầu:</label>
                    <input type="date" id="TdtdStartDate" name="TdtdStartDate" class="form-control"
                           value="<%= assign.getStartDate() != null ? assign.getStartDate() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="TdtdEndDate">Ngày kết thúc:</label>
                    <input type="date" id="TdtdEndDate" name="TdtdEndDate" class="form-control"
                           value="<%= assign.getEndDate() != null ? assign.getEndDate() : "" %>">
                </div>
                <div class="d-flex justify-content-between">
                    <input type="submit" value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="btn btn-add">
                    <a href="ProjectAssignmentServlet" class="btn btn-delete">Quay lại</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>