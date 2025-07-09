package com.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
   private static final String DB_URL = "jdbc:derby://localhost:1527/product_return";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "app";

    public static Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Database connection established successfully (from DBConnection)");
            return conn;
        } catch (SQLException e) {
            System.err.println("Failed to establish database connection: " + e.getMessage());
            throw e;
        }
    }
    
}