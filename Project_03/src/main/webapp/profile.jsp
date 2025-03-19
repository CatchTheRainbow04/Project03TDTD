<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="model.Employee, model.Department, model.Position, model.ProjectAssignment, model.GreenProject, model.Salary, java.sql.*, dao.connection, java.text.SimpleDateFormat, java.util.*"%>

<%
        if (session.getAttribute("username") == null) {
            response.sendRedirect("LoginServlet");
            return;
        }
    %>
<div class="container mt-4">
	<h2>Thông tin cá nhân</h2>
	<%
            String username = (String) session.getAttribute("username");
        	String user_id = (String) session.getAttribute("user_id");
            Employee emp = null;
            Department dept = null;
            Position pos = null;
            List<ProjectAssignment> assignments = new ArrayList<>();
            List<GreenProject> projects = GreenProject.getAllGreenProjects();
            Salary salary = null;
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

            try (Connection conn = connection.getConnection()) {
                // Lấy thông tin nhân viên dựa trên username (giả sử username = email)
                PreparedStatement empStmt = conn.prepareStatement("SELECT * FROM TdtdEmployee WHERE TdtdEmployeeId = ? AND TdtdIsDeleted = FALSE");
                empStmt.setString(1, user_id);
                ResultSet empRs = empStmt.executeQuery();
                if (empRs.next()) {
                    emp = new Employee();
                    emp.setEmployeeId(empRs.getInt("TdtdEmployeeId"));
                    emp.setDepartmentId(empRs.getInt("TdtdDepartmentId"));
                    emp.setPositionId(empRs.getInt("TdtdPositionId"));
                    emp.setFullName(empRs.getString("TdtdFullName"));
                    emp.setDateOfBirth(empRs.getDate("TdtdDateOfBirth").toLocalDate());
                    emp.setGender(empRs.getString("TdtdGender"));
                    emp.setPhoneNumber(empRs.getString("TdtdPhoneNumber"));
                    emp.setEmail(empRs.getString("TdtdEmail"));
                    emp.setHireDate(empRs.getDate("TdtdHireDate").toLocalDate());
                    emp.setStatus(empRs.getString("TdtdStatus"));
                }

                if (emp != null) {
                    // Lấy thông tin phòng ban
                    PreparedStatement deptStmt = conn.prepareStatement("SELECT * FROM TdtdDepartment WHERE TdtdDepartmentId = ?");
                    deptStmt.setInt(1, emp.getDepartmentId());
                    ResultSet deptRs = deptStmt.executeQuery();
                    if (deptRs.next()) {
                        dept = new Department();
                        dept.setDepartmentName(deptRs.getString("TdtdDepartmentName"));
                    }

                    // Lấy thông tin chức vụ
                    PreparedStatement posStmt = conn.prepareStatement("SELECT * FROM TdtdPosition WHERE TdtdPositionId = ?");
                    posStmt.setInt(1, emp.getPositionId());
                    ResultSet posRs = posStmt.executeQuery();
                    if (posRs.next()) {
                        pos = new Position();
                        pos.setPositionName(posRs.getString("TdtdPositionName"));
                    }

                    // Lấy danh sách dự án tham gia
                    PreparedStatement assignStmt = conn.prepareStatement("SELECT * FROM TdtdProjectAssignment WHERE TdtdEmployeeId = ? AND TdtdIsDeleted = FALSE");
                    assignStmt.setInt(1, emp.getEmployeeId());
                    ResultSet assignRs = assignStmt.executeQuery();
                    while (assignRs.next()) {
                        ProjectAssignment assign = new ProjectAssignment();
                        assign.setProjectId(assignRs.getInt("TdtdProjectId"));
                        assign.setRole(assignRs.getString("TdtdRole"));
                        assignments.add(assign);
                    }

                    // Lấy thông tin lương (lấy bản ghi mới nhất)
                    PreparedStatement salaryStmt = conn.prepareStatement("SELECT * FROM TdtdSalary WHERE TdtdEmployeeId = ? AND TdtdIsDeleted = FALSE ORDER BY TdtdYear DESC, TdtdMonth DESC LIMIT 1");
                    salaryStmt.setInt(1, emp.getEmployeeId());
                    ResultSet salaryRs = salaryStmt.executeQuery();
                    if (salaryRs.next()) {
                        salary = new Salary();
                        salary.setBasicSalary(salaryRs.getBigDecimal("TdtdBasicSalary"));
                        salary.setAllowance(salaryRs.getBigDecimal("TdtdAllowance"));
                        salary.setBonus(salaryRs.getBigDecimal("TdtdBonus"));
                        salary.setFinalSalary(salaryRs.getBigDecimal("TdtdFinalSalary"));
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
	<% if (emp != null) { %>
	<div class="card mb-4">
		<div class="card-body">
			<h5 class="card-title">Thông tin cơ bản</h5>
			<p>
				<strong>Họ tên:</strong>
				<%= emp.getFullName() %></p>
			<p>
				<strong>Phòng ban:</strong>
				<%= dept != null ? dept.getDepartmentName() : "N/A" %></p>
			<p>
				<strong>Chức vụ:</strong>
				<%= pos != null ? pos.getPositionName() : "N/A" %></p>
			<p>
				<strong>Ngày sinh:</strong>
				<%= emp.getDateOfBirth() != null ? dateFormat.format(java.sql.Date.valueOf(emp.getDateOfBirth())) : "N/A" %></p>
			<p>
				<strong>Giới tính:</strong>
				<%= emp.getGender() != null ? emp.getGender() : "N/A" %></p>
			<p>
				<strong>Số điện thoại:</strong>
				<%= emp.getPhoneNumber() != null ? emp.getPhoneNumber() : "N/A" %></p>
			<p>
				<strong>Email:</strong>
				<%= emp.getEmail() != null ? emp.getEmail() : "N/A" %></p>
			<p>
				<strong>Ngày tuyển dụng:</strong>
				<%= emp.getHireDate() != null ? dateFormat.format(java.sql.Date.valueOf(emp.getHireDate())) : "N/A" %></p>
			<p>
				<strong>Trạng thái:</strong>
				<%= emp.getStatus() != null ? emp.getStatus() : "N/A" %></p>
		</div>
	</div>

	<div class="card mb-4">
		<div class="card-body">
			<h5 class="card-title">Dự án tham gia</h5>
			<% if (!assignments.isEmpty()) { %>
			<ul class="list-group">
				<% for (ProjectAssignment assign : assignments) { 
                        String projectName = "N/A";
                        if (projects != null) {
                            for (GreenProject proj : projects) {
                                if (proj.getProjectId() == assign.getProjectId()) {
                                    projectName = proj.getProjectName();
                                    break;
                                }
                            }
                        }
                    %>
				<li class="list-group-item"><strong><%= projectName %></strong>
					- Vai trò: <%= assign.getRole() != null ? assign.getRole() : "N/A" %>
				</li>
				<% } %>
			</ul>
			<% } else { %>
			<p>Chưa tham gia dự án nào.</p>
			<% } %>
		</div>
	</div>

	<div class="card mb-4">
		<div class="card-body">
			<h5 class="card-title">Thông tin lương</h5>
			<% if (salary != null) { %>
			<p>
				<strong>Lương cơ bản:</strong>
				<%= salary.getBasicSalary() != null ? salary.getBasicSalary() : "0.00" %>
				VND
			</p>
			<p>
				<strong>Phụ cấp:</strong>
				<%= salary.getAllowance() != null ? salary.getAllowance() : "0.00" %>
				VND
			</p>
			<p>
				<strong>Thưởng:</strong>
				<%= salary.getBonus() != null ? salary.getBonus() : "0.00" %>
				VND
			</p>
			<p>
				<strong>Tổng lương:</strong>
				<%= salary.getFinalSalary() != null ? salary.getFinalSalary() : "0.00" %>
				VND
			</p>
			<% } else { %>
			<p>Chưa có thông tin lương.</p>
			<% } %>
		</div>
	</div>
	<% } else { %>
	<p class="text-danger">Không tìm thấy thông tin cá nhân. Vui lòng
		kiểm tra lại email đăng nhập!</p>
	<% } %>
</div>