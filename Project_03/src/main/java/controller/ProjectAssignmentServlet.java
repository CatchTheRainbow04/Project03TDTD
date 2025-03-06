package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProjectAssignment;

import java.io.IOException;
import java.time.LocalDate;

/**
 * Servlet implementation class ProjectAssignment
 */
@WebServlet("/ProjectAssignmentServlet")
public class ProjectAssignmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Hiển thị danh sách hoặc xử lý xóa mềm
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			ProjectAssignment.deleteProjectAssignment(id);
		}
        response.sendRedirect("projectAssignmentList.jsp");
	}

	// Xử lý thêm hoặc sửa
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		ProjectAssignment assignment = new ProjectAssignment();
		assignment.setProjectId(Integer.parseInt(request.getParameter("TdtdProjectId")));
		assignment.setEmployeeId(Integer.parseInt(request.getParameter("TdtdEmployeeId")));
		assignment.setRole(request.getParameter("TdtdRole"));
		assignment.setStartDate(LocalDate.parse(request.getParameter("TdtdStartDate")));
		String endDateStr = request.getParameter("TdtdEndDate");
		assignment.setEndDate((endDateStr != null && !endDateStr.isEmpty()) ? LocalDate.parse(endDateStr) : null);

		if ("add".equals(action)) {
			ProjectAssignment.addProjectAssignment(assignment);
		} else if ("update".equals(action)) {
			assignment.setAssignmentId(Integer.parseInt(request.getParameter("TdtdAssignmentId")));
			ProjectAssignment.updateProjectAssignment(assignment);
		}

		response.sendRedirect("projectAssignmentList.jsp");
	}

}
