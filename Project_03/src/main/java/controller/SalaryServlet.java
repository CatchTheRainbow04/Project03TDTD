package controller;

import java.io.IOException;
import java.math.BigDecimal;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Salary;

@WebServlet("/SalaryServlet")
public class SalaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			Salary.delete(id);
		}
		response.sendRedirect("salaryList.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");

		int employeeId = Integer.parseInt(request.getParameter("employeeId"));
		int month = Integer.parseInt(request.getParameter("month"));
		int year = Integer.parseInt(request.getParameter("year"));
		BigDecimal basicSalary = new BigDecimal(request.getParameter("basicSalary"));
		BigDecimal allowance = new BigDecimal(request.getParameter("allowance"));
		BigDecimal bonus = new BigDecimal(request.getParameter("bonus"));
		String paymentStatus = request.getParameter("paymentStatus");

		if ("add".equals(action)) {
			Salary.add(employeeId, month, year, basicSalary, allowance, bonus, paymentStatus);
		} else if ("update".equals(action)) {
			int salaryId = Integer.parseInt(request.getParameter("salaryId"));
			Salary.update(salaryId, employeeId, month, year, basicSalary, allowance, bonus, paymentStatus);
		}

		response.sendRedirect("salaryList.jsp");
	}
}