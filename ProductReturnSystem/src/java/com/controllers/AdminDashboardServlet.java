package com.controllers;

import com.daos.ReturnDAO;
import com.models.ReturnRequest;
import com.models.Admin;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("admin") : null;
        if (admin == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        try {
            ReturnDAO returnDAO = new ReturnDAO();
            List<ReturnRequest> pendingReturns = returnDAO.getReturnsByStatus("pending");
            request.setAttribute("pendingReturns", pendingReturns);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load pending return requests.");
        }

        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        }
    }

