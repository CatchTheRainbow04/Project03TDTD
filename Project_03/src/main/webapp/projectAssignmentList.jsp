<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.ProjectAssignment, model.GreenProject, model.Employee , java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách phân công dự án</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/list_style.css">
</head>
<body>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">Danh sách phân công dự án</h2>
            <a href="#" onclick="loadContent('projectAssignmentForm.jsp?action=add')" class="btn btn-add">
                <i class="fas fa-plus"></i> Thêm phân công
            </a>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên dự án</th>
                        <th>Tên nhân viên</th>
                        <th>Vai trò</th>
                        <th>Ngày bắt đầu</th>
                        <th>Ngày kết thúc</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<ProjectAssignment> assignments = ProjectAssignment.getAllProjectAssignments();
                        List<GreenProject> projects = GreenProject.getAllGreenProjects();
                        List<Employee> employees = Employee.getAllEmployee();
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

                        if (assignments != null && !assignments.isEmpty()) {
                            for (ProjectAssignment assign : assignments) {
                                String projectName = "N/A";
                                String employeeName = "N/A";
                                if (projects != null) {
                                    for (GreenProject proj : projects) {
                                        if (proj.getProjectId() == assign.getProjectId()) {
                                            projectName = proj.getProjectName();
                                            break;
                                        }
                                    }
                                }
                                if (employees != null) {
                                    for (Employee emp : employees) {
                                        if (emp.getEmployeeId() == assign.getEmployeeId()) {
                                            employeeName = emp.getFullName();
                                            break;
                                        }
                                    }
                                }
                    %>
                    <tr>
                        <td><%= assign.getAssignmentId() %></td>
                        <td><%= projectName %></td>
                        <td><%= employeeName %></td>
                        <td><%= assign.getRole() != null ? assign.getRole() : "" %></td>
                        <td><%= assign.getStartDate() != null ? dateFormat.format(java.sql.Date.valueOf(assign.getStartDate())) : "" %></td>
                        <td><%= assign.getEndDate() != null ? dateFormat.format(java.sql.Date.valueOf(assign.getEndDate())) : "" %></td>
                        <td>
                            <a href="#" onclick="loadContent('projectAssignmentForm.jsp?action=update&id=<%= assign.getAssignmentId() %>')" 
                               class="btn btn-sm btn-edit">Sửa</a>
                            <a href="ProjectAssignmentServlet?action=delete&id=<%= assign.getAssignmentId() %>"
                               onclick="return confirm('Bạn có chắc muốn xóa?');" 
                               class="btn btn-sm btn-delete">Xóa</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center">Không có dữ liệu phân công dự án.</td>
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