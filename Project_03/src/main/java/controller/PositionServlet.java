package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Position;

import java.io.IOException;
import java.math.BigDecimal;

/**
 * Servlet implementation class PositionServlet
 */
@WebServlet("/PositionServlet")
public class PositionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PositionServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("delete".equals(action)) {
			int id = Integer.parseInt(request.getParameter("id"));
			Position.deletePosition(id);
		}
		response.sendRedirect("positionList.jsp");
	}

	// Xử lý thêm hoặc sửa
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận đúng tiếng Việt
		String action = request.getParameter("action");

		String name = request.getParameter("TdtdPositionName");
		BigDecimal salaryBase = new BigDecimal(request.getParameter("TdtdSalaryBase"));

		if ("add".equals(action)) {
			Position.addPosition(name, salaryBase);
		} else if ("update".equals(action)) {
			int id = Integer.parseInt(request.getParameter("TdtdPositionId"));
			Position.updatePosition(id, name, salaryBase);
		}
		// Sau khi thêm/sửa, quay lại danh sách
		response.sendRedirect("positionList.jsp");
	}

}
