package com.controllers;

import com.daos.RefundDAO;
import com.models.Refund;
import com.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;


public class RefundServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in user
        User user = (User) session.getAttribute("user");

        // Fetch refunds for the user
        RefundDAO refundDAO = new RefundDAO();
        List<Refund> refundList = refundDAO.getRefundsByUserId(user.getUserId());

        // Set refund list to request scope
        request.setAttribute("refundList", refundList);

        // Forward to JSP
        request.getRequestDispatcher("view-refund.jsp").forward(request, response);
    }
}
