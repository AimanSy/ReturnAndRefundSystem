package com.daos;
import com.models.User;
import com.utils.DBConnection;
import java.sql.*;

public class UserDAO {
    
    public Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }
    
    public User validateUser(String username, String password) {
        String sql = "SELECT * FROM app_user WHERE username=? AND password=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("userid"));  
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                // user.setRole(rs.getString("role")); // Removed
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error validating user: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean usernameExists(String username) {
        String sql = "SELECT userid FROM app_user WHERE username=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println("Error checking username existence: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean createUser(User user) {
        String sql = "INSERT INTO app_user (username, password, email) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());

            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    user.setUserId(rs.getInt(1));  
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error creating user: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            
            if (e.getSQLState() != null && e.getSQLState().equals("23505")) {
                System.err.println("Duplicate entry violation");
            }
        }
        return false;
    }
    
    public boolean emailExists(String email) {
        String sql = "SELECT userId FROM app_user WHERE email=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public void testConnection() throws Exception {
        System.out.println("=== Testing Database Connection ===");
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                throw new RuntimeException("Database connection is null");
            }
            System.out.println("Connection successful to: " + 
                conn.getMetaData().getURL());
            System.out.println("Table check: " + 
                conn.getMetaData().getTables(null, null, "APP_USER", null).next());
        }
    }
}
