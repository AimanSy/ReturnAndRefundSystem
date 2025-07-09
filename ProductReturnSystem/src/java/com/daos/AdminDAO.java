package com.daos;

import com.models.Admin;
import com.utils.DBConnection;

import java.sql.*;

public class AdminDAO {

    /**
     * Validates an admin by username & password.
     * @return an Admin object if credentials match, or null otherwise.
     */
    public Admin validateAdmin(String username, String password) {
        String sql = "SELECT adminId, username, password FROM admin "
                   + "WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setAdminId(rs.getInt("adminId"));
                    admin.setUsername(rs.getString("username"));
                    // NOTE: you may choose not to set password back into the model
                    return admin;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error validating admin: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
