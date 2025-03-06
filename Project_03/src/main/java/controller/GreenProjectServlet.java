package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.GreenProject;

import java.io.IOException;
import java.time.LocalDate;

/**
 * Servlet implementation class GreenProjectServlet
 */
@WebServlet("/GreenProjectServlet")
public class GreenProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Hiển thị danh sách hoặc xử lý xóa mềm
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			GreenProject.deleteGreenProject(id);
		}
		response.sendRedirect("greenProjectList.jsp");
	}

	// Xử lý thêm hoặc sửa
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận đúng tiếng Việt
		String action = request.getParameter("action");

		GreenProject project = new GreenProject();
		project.setProjectName(request.getParameter("TdtdProjectName"));
		project.setLocation(request.getParameter("TdtdLocation"));
		project.setStartDate(LocalDate.parse(request.getParameter("TdtdStartDate")));
		String endDateStr = request.getParameter("TdtdEndDate");
		project.setEndDate((endDateStr != null && !endDateStr.isEmpty()) ? LocalDate.parse(endDateStr) : null);
		project.setStatus(request.getParameter("TdtdStatus"));

		if ("add".equals(action)) {
			GreenProject.addGreenProject(project);
		} else if ("update".equals(action)) {
			project.setProjectId(Integer.parseInt(request.getParameter("TdtdProjectId")));
			GreenProject.updateGreenProject(project);
		}
		response.sendRedirect("greenProjectList.jsp");
	}

}
