<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Attendance, model.Employee, java.sql.*, dao.connection, java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> chấm công</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container mt-4">
        <div class="form-container">
            <h2><%= request.getParameter("action").equals("add") ? "Thêm" : "Sửa" %> chấm công</h2>
            <%
                Attendance att = new Attendance();
                String action = request.getParameter("action");
                if ("update".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    try (Connection conn = connection.getConnection();
                         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdAttendance WHERE TdtdAttendanceId = ? AND TdtdIsDeleted = FALSE")) {
                        stmt.setInt(1, id);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            att.setAttendanceId(rs.getInt("TdtdAttendanceId"));
                            att.setEmployeeId(rs.getInt("TdtdEmployeeId"));
                            att.setDate(rs.getDate("TdtdDate").toLocalDate());
                            att.setClockIn(rs.getTime("TdtdClockIn") != null ? rs.getTime("TdtdClockIn").toLocalTime() : null);
                            att.setClockOut(rs.getTime("TdtdClockOut") != null ? rs.getTime("TdtdClockOut").toLocalTime() : null);
                            att.setStatus(rs.getString("TdtdStatus"));
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                List<Employee> employees = new ArrayList<>();
                try (Connection conn = connection.getConnection();
                     Statement stmt = conn.createStatement()) {
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
            <form action="AttendanceServlet" method="post" class="form-group">
                <input type="hidden" name="action" value="<%= action %>">
                <% if ("update".equals(action)) { %>
                <input type="hidden" name="attendanceId" value="<%= att.getAttendanceId() %>">
                <% } %>
                <div class="mb-3">
                    <label for="employeeId">Nhân viên:</label>
                    <select id="employeeId" name="employeeId" class="form-control" required>
                        <% for (Employee emp : employees) { %>
                        <option value="<%= emp.getEmployeeId() %>"
                            <%= emp.getEmployeeId() == att.getEmployeeId() ? "selected" : "" %>>
                            <%= emp.getFullName() %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="date">Ngày:</label>
                    <input type="date" id="date" name="date" class="form-control"
                           value="<%= att.getDate() != null ? att.getDate() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label for="clockIn">Giờ vào:</label>
                    <input type="time" id="clockIn" name="clockIn" class="form-control"
                           value="<%= att.getClockIn() != null ? att.getClockIn() : "" %>">
                </div>
                <div class="mb-3">
                    <label for="clockOut">Giờ ra:</label>
                    <input type="time" id="clockOut" name="clockOut" class="form-control"
                           value="<%= att.getClockOut() != null ? att.getClockOut() : "" %>">
                </div>
                <div class="mb-3">
                    <label for="status">Trạng thái:</label>
                    <select id="status" name="status" class="form-control" required>
                        <option value="Đi làm" <%= "Đi làm".equals(att.getStatus()) ? "selected" : "" %>>Đi làm</option>
                        <option value="Vắng mặt" <%= "Vắng mặt".equals(att.getStatus()) ? "selected" : "" %>>Vắng mặt</option>
                        <option value="Nghỉ phép" <%= "Nghỉ phép".equals(att.getStatus()) ? "selected" : "" %>>Nghỉ phép</option>
                    </select>
                </div>
                <div class="d-flex justify-content-between">
                    <input type="submit" value="<%= action.equals("add") ? "Thêm" : "Sửa" %>" class="btn btn-add">
                    <a href="AttendanceServlet" class="btn btn-delete">Quay lại</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>