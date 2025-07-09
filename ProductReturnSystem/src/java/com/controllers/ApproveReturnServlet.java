package com.controllers;

import com.daos.ReturnDAO;
import com.daos.RefundDAO;
import com.daos.ProductDAO;
import com.models.ReturnRequest;
import com.models.Refund;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;

public class ApproveReturnServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int requestId = Integer.parseInt(request.getParameter("requestId"));
        int adminId = 999; // Replace with actual admin session ID if needed

        try {
            ReturnDAO returnDAO = new ReturnDAO();
            ReturnRequest returnReq = returnDAO.getReturnRequestById(requestId);

            if (returnReq == null) {
                throw new Exception("Return request not found.");
            }

            // Mark return as approved
            returnDAO.updateReturnStatus(requestId, "approved");

            // Insert refund automatically
            ProductDAO productDAO = new ProductDAO();
            double amount = productDAO.getProductById(returnReq.getProductId()).getPrice() * returnReq.getQuantity();

            Refund refund = new Refund();
            refund.setRequestId(requestId);
            refund.setAmount(amount);
            refund.setMethod("bank_transfer");
            refund.setAccountDetails("Auto-approved"); // You may change this
            refund.setProcessedBy(adminId);
            refund.setProcessedDate(new Timestamp(System.currentTimeMillis()));
            refund.setStatus("approved");

            RefundDAO refundDAO = new RefundDAO();
            refundDAO.createRefund(refund);

            // Redirect back to dashboard
            response.sendRedirect("AdminDashboardServlet");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to approve request: " + e.getMessage());
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

}
