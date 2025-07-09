package com.controllers;

import com.daos.ReturnDAO;
import com.daos.RefundDAO;
import com.models.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getUserId();
        ReturnDAO returnDAO = new ReturnDAO();
        RefundDAO refundDAO = new RefundDAO();

        try {
            int pendingReturns = returnDAO.countReturnsByStatus(userId, "pending");
            int approvedReturns = returnDAO.countReturnsByStatus(userId, "approved");
            double totalRefunds = refundDAO.getTotalRefundAmountByUser(userId);

            request.setAttribute("pendingReturnsCount", pendingReturns);
            request.setAttribute("approvedReturnsCount", approvedReturns);
            request.setAttribute("totalRefunds", totalRefunds);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load dashboard data.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
        dispatcher.forward(request, response);
    }
}
