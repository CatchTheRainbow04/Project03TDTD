<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Employee, model.Department, model.Position, java.sql.*, dao.connection, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> nhân viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container mt-4">
        <div class="form-container">
            <h2><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> nhân viên</h2>
            <%
                Employee emp = new Employee();
                String action = request.getParameter("action");
                if ("update".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    try (Connection conn = connection.getConnection();
                         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdEmployee WHERE TdtdEmployeeId = ? AND TdtdIsDeleted = FALSE")) {
                        stmt.setInt(1, id);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            emp.setEmployeeId(rs.getInt("TdtdEmployeeId"));
                            emp.setDepartmentId(rs.getInt("TdtdDepartmentId"));
                            emp.setPositionId(rs.getInt("TdtdPositionId"));
                            emp.setFullName(rs.getString("TdtdFullName"));
                            emp.setDateOfBirth(rs.getDate("TdtdDateOfBirth").toLocalDate());
                            emp.setGender(rs.getString("TdtdGender"));
                            emp.setPhoneNumber(rs.getString("TdtdPhoneNumber"));
                            emp.setEmail(rs.getString("TdtdEmail"));
                            emp.setHireDate(rs.getDate("TdtdHireDate").toLocalDate());
                            emp.setStatus(rs.getString("TdtdStatus"));
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                List<Department> departments = Department.getAllDepartment();
                if (departments == null) {
                    departments = new ArrayList<>();
                    try (Connection conn = connection.getConnection();
                         Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT * FROM TdtdDepartment WHERE TdtdIsDeleted = FALSE")) {
                        while (rs.next()) {
                            Department dept = new Department();
                            dept.setDepartmentId(rs.getInt("TdtdDepartmentId"));
                            dept.setDepartmentName(rs.getString("TdtdDepartmentName"));
                            departments.add(dept);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                List<Position> positions = Position.getAllPosition();
                if (positions == null) {
                    positions = new ArrayList<>();
                    try (Connection conn = connection.getConnection();
                         Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT * FROM TdtdPosition WHERE TdtdIsDeleted = FALSE")) {
                        while (rs.next()) {
                            Position pos = new Position();
                            pos.setPositionId(rs.getInt("TdtdPositionId"));
                            pos.setPositionName(rs.getString("TdtdPositionName"));
                            positions.add(pos);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
            <form action="EmployeeServlet" method="post" class="form-group">
                <input type="hidden" name="action" value="<%= action %>">
                <% if ("update".equals(action)) { %>
                <input type="hidden" name="TdtdEmployeeId" value="<%= emp.getEmployeeId() %>">
                <% } %>
                <div class="mb-3">
                    <label for="TdtdDepartmentId">Phòng ban:</label>
                    <select id="TdtdDepartmentId" name="TdtdDepartmentId" class="form-control" required>
                        <% for (Department dept : departments) { %>
                        <option value="<%= dept.getDepartmentId() %>"
                            <%= dept.getDepartmentId() == emp.getDepartmentId() ? "selected" : "" %>>
                            <%= dept.getDepartmentName() %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="TdtdPositionId">Chức vụ:</label>
                    <select id="TdtdPositionId" name="TdtdPositionId" class="form-control" required>
                        <% for (Position pos : positions) { %>
                        <option value="<%= pos.getPositionId() %>"
                            <%= pos.getPositionId() == emp.getPositionId() ? "selected" : "" %>>
                            <%= pos.getPositionName() %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="TdtdFullName">Họ tên:</label>
                    <input type="text" id="TdtdFullName" name="TdtdFullName" class="form-control"
                           value="<%= emp.getFullName() != null ? emp.getFullName() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="TdtdDateOfBirth">Ngày sinh:</label>
                    <input type="date" id="TdtdDateOfBirth" name="TdtdDateOfBirth" class="form-control"
                           value="<%= emp.getDateOfBirth() != null ? emp.getDateOfBirth() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="TdtdGender">Giới tính:</label>
                    <select id="TdtdGender" name="TdtdGender" class="form-control" required>
                        <option value="Nam" <%= "Nam".equals(emp.getGender()) ? "selected" : "" %>>Nam</option>
                        <option value="Nữ" <%= "Nữ".equals(emp.getGender()) ? "selected" : "" %>>Nữ</option>
                        <option value="Khác" <%= "Khác".equals(emp.getGender()) ? "selected" : "" %>>Khác</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="TdtdPhoneNumber">Số điện thoại:</label>
                    <input type="text" id="TdtdPhoneNumber" name="TdtdPhoneNumber" class="form-control"
                           value="<%= emp.getPhoneNumber() != null ? emp.getPhoneNumber() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="TdtdEmail">Email:</label>
                    <input type="email" id="TdtdEmail" name="TdtdEmail" class="form-control"
                           value="<%= emp.getEmail() != null ? emp.getEmail() : "" %>">
                </div>
                <div class="mb-3">
                    <label for="TdtdHireDate">Ngày tuyển dụng:</label>
                    <input type="date" id="TdtdHireDate" name="TdtdHireDate" class="form-control"
                           value="<%= emp.getHireDate() != null ? emp.getHireDate() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="TdtdStatus">Trạng thái:</label>
                    <select id="TdtdStatus" name="TdtdStatus" class="form-control" required>
                        <option value="Đang làm việc" <%= "Đang làm việc".equals(emp.getStatus()) ? "selected" : "" %>>Đang làm việc</option>
                        <option value="Đã nghỉ việc" <%= "Đã nghỉ việc".equals(emp.getStatus()) ? "selected" : "" %>>Đã nghỉ việc</option>
                        <option value="Tạm nghỉ" <%= "Tạm nghỉ".equals(emp.getStatus()) ? "selected" : "" %>>Tạm nghỉ</option>
                    </select>
                </div>
                <div class="d-flex justify-content-between">
                    <input type="submit" value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="btn btn-add">
                    <a href="EmployeeServlet" class="btn btn-delete">Quay lại</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>