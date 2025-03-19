<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.User, dao.connection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách người dùng</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/list_style.css">
</head>
<body>
	<%
        // Kiểm tra đăng nhập
        if (session.getAttribute("username") == null) {
            response.sendRedirect("LoginServlet");
            return;
        }
String role = (String) session.getAttribute("role");
    %>
	<div class="container mt-4">
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="mb-0">Danh sách người dùng</h2>
			<%
			if ("Admin".equals(role)) {
			%>
			<a href="#" onclick="loadContent('userForm.jsp?action=add')"
				class="btn btn-add"> <i class="fas fa-plus"></i> Thêm người dùng
			</a>
			<%
			}
			%>

		</div>
		<div class="table-responsive">
			<table class="table table-hover table-striped">
				<thead class="thead-dark">
					<tr>
						<th>ID</th>
						<th>ID Nhân viên</th>
						<th>Tên đăng nhập</th>
						<th>Vai trò</th>
						<th>Hoạt động</th>
						<%
			if ("Admin".equals(role)) {
			%>
						<th>Thao tác</th>
						<%
			}
			%>

					</tr>
				</thead>
				<tbody>
					<%
                        List<User> users = User.getAllUsers();
                        if (users != null && !users.isEmpty()) {
                            for (User user : users) {
                    %>
					<tr>
						<td><%= user.getUserId() %></td>
						<td><%= user.getEmployeeId() != null ? user.getEmployeeId() : "N/A" %></td>
						<td><%= user.getUsername() != null ? user.getUsername() : "" %></td>
						<td><%= user.getRole() != null ? user.getRole() : "" %></td>
						<td><span
							class="status <%= user.isActive() ? "green" : "red" %>"> <%= user.isActive() ? "Đang hoạt động" : "Không còn hoạt động" %>
						</span></td>
						<%
			if ("Admin".equals(role)) {
			%>
						<td><a href="#"
							onclick="loadContent('userForm.jsp?action=update&id=<%= user.getUserId() %>')"
							class="btn btn-sm btn-edit">Sửa</a> <a
							href="UserServlet?action=delete&id=<%= user.getUserId() %>"
							onclick="return confirm('Bạn có chắc muốn xóa?');"
							class="btn btn-sm btn-delete">Xóa</a></td>
						<%
			}
			%>

					</tr>
					<%
                            }
                        } else {
                    %>
					<tr>
						<td colspan="6" class="text-center">Không có dữ liệu người
							dùng.</td>
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