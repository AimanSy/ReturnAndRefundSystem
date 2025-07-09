package com.controllers;

import com.daos.ProductDAO;
import com.models.Product;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ProductListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();

        request.setAttribute("productList", productList);
        request.getRequestDispatcher("product-list.jsp").forward(request, response);
    }
}
