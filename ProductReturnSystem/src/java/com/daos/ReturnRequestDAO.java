package com.daos;

import com.models.ReturnRequest;
import com.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReturnRequestDAO {

    // Create a new return request
    public boolean createReturnRequest(ReturnRequest returnRequest) throws SQLException {
        String sql = "INSERT INTO returnrequest (userId, productId, quantity, reason, status, requestDate) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        System.out.println("Creating return request:");
        System.out.println("- userId: " + returnRequest.getUserId());
        System.out.println("- productId: " + returnRequest.getProductId());
        System.out.println("- quantity: " + returnRequest.getQuantity());
        System.out.println("- reason: " + returnRequest.getReason());
        System.out.println("- status: " + returnRequest.getStatus());
        System.out.println("- requestDate: " + returnRequest.getRequestDate());

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, returnRequest.getUserId());
            ps.setInt(2, returnRequest.getProductId());
            ps.setInt(3, returnRequest.getQuantity());
            ps.setString(4, returnRequest.getReason());
            ps.setString(5, returnRequest.getStatus());
            ps.setTimestamp(6, returnRequest.getRequestDate());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        returnRequest.setRequestId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    // Get returns by user ID and status
    public List<ReturnRequest> getReturnsByStatus(int userId, String status) throws SQLException {
        String sql = "SELECT * FROM returnrequest WHERE userId = ? AND status = ?";
        List<ReturnRequest> returns = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, status);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReturnRequest returnReq = mapResultSetToReturnRequest(rs);
                    returns.add(returnReq);
                }
            }
        }
        return returns;
    }

    // Get returns by user ID and status, including product name
    public List<ReturnRequest> getApprovedReturnsWithProductName(int userId) throws SQLException {
        String sql = "SELECT r.*, p.name AS productName FROM returnrequest r " +
                     "JOIN product p ON r.productId = p.productId " +
                     "WHERE r.userId = ? AND r.status = 'approved'";
        List<ReturnRequest> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReturnRequest req = mapResultSetToReturnRequest(rs);
                    req.setProductName(rs.getString("productName"));  // Requires field in model
                    list.add(req);
                }
            }
        }
        return list;
    }

    // Get single return by ID
    public ReturnRequest getReturnRequestById(int requestId) throws SQLException {
        String sql = "SELECT * FROM returnrequest WHERE requestId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, requestId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToReturnRequest(rs);
                }
            }
        }
        return null;
    }

    // Update return status
    public boolean updateReturnStatus(int requestId, String newStatus) throws SQLException {
        String sql = "UPDATE returnrequest SET status = ? WHERE requestId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, requestId);

            return ps.executeUpdate() > 0;
        }
    }

    // Optional: Get all returns for a user
    public List<ReturnRequest> getReturnsByUser(int userId) throws SQLException {
        String sql = "SELECT * FROM returnrequest WHERE userId = ?";
        List<ReturnRequest> returns = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    returns.add(mapResultSetToReturnRequest(rs));
                }
            }
        }
        return returns;
    }

    // Helper to convert ResultSet to ReturnRequest
    private ReturnRequest mapResultSetToReturnRequest(ResultSet rs) throws SQLException {
        ReturnRequest returnReq = new ReturnRequest();
        returnReq.setRequestId(rs.getInt("requestId"));
        returnReq.setUserId(rs.getInt("userId"));
        returnReq.setProductId(rs.getInt("productId"));
        returnReq.setQuantity(rs.getInt("quantity"));
        returnReq.setReason(rs.getString("reason"));
        returnReq.setStatus(rs.getString("status"));
        returnReq.setRequestDate(rs.getTimestamp("requestDate"));
        return returnReq;
    }
    
    public double getTotalRefundAmountByUser(int userId) throws SQLException {
        String sql = "SELECT SUM(r.amount) FROM refund r " +
                     "JOIN returnrequest rr ON r.requestId = rr.requestId " +
                     "WHERE rr.userId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble(1);
            }
        }
        return 0.0;
    }

}
