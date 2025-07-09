package com.controllers;

import com.daos.ReturnRequestDAO;
import com.daos.ProductDAO;
import com.models.ReturnRequest;
import com.models.Product;
import com.models.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;


public class SubmitReturnServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get form data
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String reason = request.getParameter("reason");

            // Create and populate return request
            ReturnRequest returnRequest = new ReturnRequest();
            returnRequest.setUserId(user.getUserId());
            returnRequest.setProductId(productId);
            returnRequest.setQuantity(quantity);
            returnRequest.setReason(reason);
            returnRequest.setStatus("pending");
            returnRequest.setRequestDate(new Timestamp(System.currentTimeMillis()));

            // Save to database
            ReturnRequestDAO returnDAO = new ReturnRequestDAO();
            boolean success = returnDAO.createReturnRequest(returnRequest);

            if (success) {
                // Success - redirect to confirmation
                session.setAttribute("successMessage", "Return request submitted successfully!");
                response.sendRedirect("return-confirmation.jsp");
            } else {
                // Failure - reload form with products
                handleError(request, response, "Failed to submit return request");
            }
            
        } catch (NumberFormatException e) {
            handleError(request, response, "Invalid quantity or product ID");
        } catch (Exception e) {
            handleError(request, response, "System error: " + e.getMessage());
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, 
                           String errorMessage) throws ServletException, IOException {
        // Reload products for dropdown
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();
        
        request.setAttribute("productList", productList);
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("return-request.jsp").forward(request, response);
    }
}