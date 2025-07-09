package com.controllers;

import com.daos.AdminDAO;
import com.models.Admin;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO dao = new AdminDAO();
        Admin admin = dao.validateAdmin(username, password);

        if (admin != null) {
            // Successful login
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            response.sendRedirect("AdminDashboardServlet");
        } else {
            // Failed
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }
}
