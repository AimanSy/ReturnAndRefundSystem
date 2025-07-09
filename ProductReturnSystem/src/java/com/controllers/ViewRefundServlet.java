package com.controllers;

import com.daos.RefundDAO;
import com.models.Refund;
import com.models.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ViewRefundServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        RefundDAO refundDAO = new RefundDAO();
        List<Refund> refundList = refundDAO.getRefundsByUser(user.getUserId());
        request.setAttribute("refundList", refundList);
        request.getRequestDispatcher("view-refund.jsp").forward(request, response);
    }
}
