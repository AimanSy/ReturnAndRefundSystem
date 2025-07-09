package com.controllers;

import com.daos.ReturnDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class RejectReturnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int requestId = Integer.parseInt(request.getParameter("requestId"));
        ReturnDAO dao = new ReturnDAO();

        try {
            boolean updated = dao.updateReturnStatus(requestId, "rejected");
            if (updated) {
                request.getSession().setAttribute("successMessage", "Return request rejected.");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to reject request.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error processing rejection.");
        }

        response.sendRedirect("admin-dashboard.jsp");
    }
}
