<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Attendance, model.Employee, java.text.SimpleDateFormat" %>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">Danh sách chấm công</h2>
            <a href="#" onclick="loadContent('attendanceForm.jsp?action=add')" class="btn btn-add">
                <i class="fas fa-plus"></i> Thêm chấm công
            </a>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên nhân viên</th>
                        <th>Ngày</th>
                        <th>Giờ vào</th>
                        <th>Giờ ra</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Attendance> attendances = Attendance.getAllAttendances();
                        List<Employee> employees = Employee.getAllEmployee();
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

                        if (attendances != null && !attendances.isEmpty()) {
                            for (Attendance att : attendances) {
                                String employeeName = "N/A";
                                if (employees != null) {
                                    for (Employee emp : employees) {
                                        if (emp.getEmployeeId() == att.getEmployeeId()) {
                                            employeeName = emp.getFullName();
                                            break;
                                        }
                                    }
                                }
                    %>
                    <tr>
                        <td><%= att.getAttendanceId() %></td>
                        <td><%= employeeName %></td>
                        <td><%= att.getDate() != null ? dateFormat.format(java.sql.Date.valueOf(att.getDate())) : "" %></td>
                        <td><%= att.getClockIn() != null ? att.getClockIn() : "" %></td>
                        <td><%= att.getClockOut() != null ? att.getClockOut() : "" %></td>
                        <td>
                            <span class="status <%= att.getStatus() != null && att.getStatus().equals("Đi làm") ? "green" : (att.getStatus() != null && att.getStatus().equals("Vắng mặt") ? "red" : "yellow") %>">
                                <%= att.getStatus() != null ? att.getStatus() : "" %>
                            </span>
                        </td>
                        <td>
                            <a href="#" onclick="loadContent('attendanceForm.jsp?action=update&id=<%= att.getAttendanceId() %>')" 
                               class="btn btn-sm btn-edit">Sửa</a>
                            <a href="AttendanceServlet?action=delete&id=<%= att.getAttendanceId() %>"
                               onclick="return confirm('Bạn có chắc muốn xóa?');" 
                               class="btn btn-sm btn-delete">Xóa</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center">Không có dữ liệu chấm công.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
