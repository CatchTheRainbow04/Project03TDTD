<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.ProjectAssignment, model.GreenProject, model.Employee, java.sql.*, dao.connection , java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách phân công dự án</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .button { padding: 5px 10px; margin: 5px; }
    </style>
</head>
<body>
    <h2>Danh sách phân công dự án</h2>
    <a href="projectAssignmentForm.jsp?action=add" class="button">Thêm phân công</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Tên dự án</th>
            <th>Tên nhân viên</th>
            <th>Vai trò</th>
            <th>Ngày bắt đầu</th>
            <th>Ngày kết thúc</th>
            <th>Thao tác</th>
        </tr>
        <%
            List<ProjectAssignment> assignments = ProjectAssignment.getAllProjectAssignments();
            List<GreenProject> projects = null;
            List<Employee> employees = null;

            // Lấy danh sách dự án và nhân viên từ cơ sở dữ liệu
            try (Connection conn = connection.getConnection()) {
                Statement stmt = conn.createStatement();
                ResultSet rsProjects = stmt.executeQuery("SELECT TdtdProjectId, TdtdProjectName FROM TdtdGreenProject WHERE TdtdIsDeleted = FALSE");
                projects = new ArrayList<>();
                while (rsProjects.next()) {
                    GreenProject proj = new GreenProject();
                    proj.setProjectId(rsProjects.getInt("TdtdProjectId"));
                    proj.setProjectName(rsProjects.getString("TdtdProjectName"));
                    projects.add(proj);
                }

                ResultSet rsEmployees = stmt.executeQuery("SELECT TdtdEmployeeId, TdtdFullName FROM TdtdEmployee WHERE TdtdIsDeleted = FALSE");
                employees = new ArrayList<>();
                while (rsEmployees.next()) {
                    Employee emp = new Employee();
                    emp.setEmployeeId(rsEmployees.getInt("TdtdEmployeeId"));
                    emp.setFullName(rsEmployees.getString("TdtdFullName"));
                    employees.add(emp);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            if (assignments != null && !assignments.isEmpty()) {
                for (ProjectAssignment assign : assignments) {
                    String projectName = "";
                    String employeeName = "";
                    for (GreenProject proj : projects) {
                        if (proj.getProjectId() == assign.getProjectId()) {
                            projectName = proj.getProjectName();
                            break;
                        }
                    }
                    for (Employee emp : employees) {
                        if (emp.getEmployeeId() == assign.getEmployeeId()) {
                            employeeName = emp.getFullName();
                            break;
                        }
                    }
        %>
            <tr>
                <td><%= assign.getAssignmentId() %></td>
                <td><%= projectName %></td>
                <td><%= employeeName %></td>
                <td><%= assign.getRole() != null ? assign.getRole() : "" %></td>
                <td><%= assign.getStartDate() != null ? assign.getStartDate() : "" %></td>
                <td><%= assign.getEndDate() != null ? assign.getEndDate() : "" %></td>
                <td>
                    <a href="projectAssignmentForm.jsp?action=update&id=<%= assign.getAssignmentId() %>" class="button">Sửa</a>
                    <a href="ProjectAssignmentServlet?action=delete&id=<%= assign.getAssignmentId() %>" 
                       onclick="return confirm('Bạn có chắc muốn xóa?');" class="button">Xóa</a>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="7">Không có dữ liệu phân công dự án.</td>
            </tr>
        <%
            }
        %>
    </table>
</body>
</html>