package com.controllers;

import com.daos.ProductDAO;
import com.models.Product;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;


public class ReturnRequestServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Authentication check
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get products for dropdown
        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();

        // Forward to existing JSP
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("return-request.jsp").forward(request, response);
    }
}