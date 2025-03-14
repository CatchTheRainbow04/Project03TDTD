package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Employee;

import java.io.IOException;
import java.time.LocalDate;

/**
 * Servlet implementation class EemployeeServlet
 */
@WebServlet("/EmployeeServlet")
public class EmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmployeeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Employee.deleteEmployee(id);
        }
        response.sendRedirect("employeeList.jsp");
    }

    // Xử lý thêm hoặc sửa
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        int departmentId = Integer.parseInt(request.getParameter("TdtdDepartmentId"));
        int positionId = Integer.parseInt(request.getParameter("TdtdPositionId"));
        String fullName = request.getParameter("TdtdFullName");
        LocalDate dateOfBirth = LocalDate.parse(request.getParameter("TdtdDateOfBirth"));
        String gender = request.getParameter("TdtdGender");
        String phoneNumber = request.getParameter("TdtdPhoneNumber");
        String email = request.getParameter("TdtdEmail");
        LocalDate hireDate = LocalDate.parse(request.getParameter("TdtdHireDate"));
        String status = request.getParameter("TdtdStatus");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if ("add".equals(action)) {
            Employee.addEmployee(departmentId, positionId, fullName, dateOfBirth, gender, phoneNumber, email, hireDate, status);
            response.getWriter().write("{\"success\": true, \"message\": \"Thêm nhân viên thành công\", \"redirect\": \"EmployeeServlet\"}");
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("TdtdEmployeeId"));
            Employee.updateEmployee(id, departmentId, positionId, fullName, dateOfBirth, gender, phoneNumber, email, hireDate, status);
            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật nhân viên thành công\", \"redirect\": \"EmployeeServlet\"}");
        }
    }

}
