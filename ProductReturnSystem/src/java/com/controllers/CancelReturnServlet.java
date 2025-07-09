package com.controllers;

import com.daos.ReturnDAO;
import com.models.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class CancelReturnServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("requestId");
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || idParam == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int requestId = Integer.parseInt(idParam);
            ReturnDAO dao = new ReturnDAO();

            boolean deleted = dao.deleteReturnRequest(requestId);
            if (deleted) {
                session.setAttribute("successMessage", "Return request canceled.");
            } else {
                session.setAttribute("errorMessage", "Cannot cancel—either not pending or not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error canceling return request.");
        }

        response.sendRedirect("ViewReturnServlet");  // your user-view servlet
    }
}
