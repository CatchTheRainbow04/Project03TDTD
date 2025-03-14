<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.GreenProject"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách dự án cây xanh</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/list_style.css">
</head>
<body>
	<div class="container mt-4">
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="mb-0">Danh sách dự án cây xanh</h2>
			<a href="#" onclick="loadContent('greenProjectForm.jsp?action=add')"
				class="btn btn-add"> <i class="fas fa-plus"></i> Thêm dự án
			</a>
		</div>
		<div class="table-responsive">
			<table class="table table-hover table-striped">
				<thead class="thead-dark">
					<tr>
						<th>ID</th>
						<th>Tên dự án</th>
						<th>Vị trí</th>
						<th>Ngày bắt đầu</th>
						<th>Ngày kết thúc</th>
						<th>Trạng thái</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<%
                        List<GreenProject> projects = GreenProject.getAllGreenProjects();
                        if (projects != null && !projects.isEmpty()) {
                            for (GreenProject proj : projects) {
                    %>
					<tr>
						<td><%= proj.getProjectId() %></td>
						<td><%= proj.getProjectName() != null ? proj.getProjectName() : "" %></td>
						<td><%= proj.getLocation() != null ? proj.getLocation() : "" %></td>
						<td><%= proj.getStartDate() != null ? proj.getStartDate() : "" %></td>
						<td><%= proj.getEndDate() != null ? proj.getEndDate() : "" %></td>
						<% String status = "";
                        String statusString = proj.getStatus();
                        if(statusString.equals("Hoàn thành")){
                        	status = "blue";
                        }else if(statusString.equals("Đang thực hiện")){
                        	status = "green";
                        }else if(statusString.equals("Tạm dừng")){
                        	status = "orange";
                        }else{
                        	status = "red";
                        }
                        %>
						<td><span class="status <%= status%>"> <%= statusString %>
						</span></td>
						<td><a href="#"
							onclick="loadContent('greenProjectForm.jsp?action=update&id=<%= proj.getProjectId() %>')"
							class="btn btn-sm btn-edit">Sửa</a> <a
							href="GreenProjectServlet?action=delete&id=<%= proj.getProjectId() %>"
							onclick="return confirm('Bạn có chắc muốn xóa?');"
							class="btn btn-sm btn-delete">Xóa</a></td>
					</tr>
					<%
                            }
                        } else {
                    %>
					<tr>
						<td colspan="7" class="text-center">Không có dữ liệu dự án.</td>
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