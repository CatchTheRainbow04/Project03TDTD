package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Department;

@WebServlet("/DepartmentServlet")
public class DepartmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			Department.deleteDepartment(id);
		}
		response.sendRedirect("departmentList.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		String name = request.getParameter("TdtdDepartmentName");
		String description = request.getParameter("TdtdDescription");

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		if ("add".equals(action)) {
			Department.addDepartment(name, description);
			response.getWriter().write(
					"{\"success\": true, \"message\": \"Thêm phòng ban thành công\", \"redirect\": \"DepartmentServlet\"}");
		} else if ("update".equals(action)) {
			int id = Integer.parseInt(request.getParameter("TdtdDepartmentId"));
			Department.updateDepartment(id, name, description);
			response.getWriter().write(
					"{\"success\": true, \"message\": \"Cập nhật phòng ban thành công\", \"redirect\": \"DepartmentServlet\"}");
		}
	}
}