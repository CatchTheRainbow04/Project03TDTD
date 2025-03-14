package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.User;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            User.delete(id);
        }
        response.sendRedirect("userList.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        String employeeIdStr = request.getParameter("employeeId");
        Integer employeeId = (employeeIdStr != null && !employeeIdStr.isEmpty()) ? Integer.parseInt(employeeIdStr) : null;
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        boolean isActive = "true".equals(request.getParameter("isActive"));
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        
        if ("add".equals(action)) {
        	if(User.isUsernameExists(username)) {
        		request.setAttribute("error", "Tài khoản '" + username + "' đã tồn tại!");
                request.setAttribute("employeeId", employeeId);
                request.setAttribute("username", username);
                request.setAttribute("password", password);
                request.setAttribute("role", role);
                request.setAttribute("isActive", isActive);
                request.getRequestDispatcher("userForm.jsp").forward(request, response);
                return;
        	}
        	else {
        		User.add(employeeId, username, password, role, isActive);
        		response.getWriter().write("{\"success\": true, \"message\": \"Thêm người dùng thành công\", \"redirect\": \"UserServlet\"}");
        	}
        } else if ("update".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            User.update(userId, employeeId, username, password, role, isActive);
            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật người dùng thành công\", \"redirect\": \"UserServlet\"}");
        }
    }
}
