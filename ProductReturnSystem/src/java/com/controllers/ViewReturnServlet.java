package com.controllers;

import com.daos.ReturnDAO;
import com.models.ReturnRequest;
import com.models.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ViewReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Ensure user is logged in
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            ReturnDAO returnDAO = new ReturnDAO();
            List<ReturnRequest> returnList = returnDAO.getReturnsByUser(user.getUserId());

            request.setAttribute("returnList", returnList);
            request.getRequestDispatcher("view-return.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load return requests.");
            request.getRequestDispatcher("view-return.jsp").forward(request, response);
        }
    }
}
