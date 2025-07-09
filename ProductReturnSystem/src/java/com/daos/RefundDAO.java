package com.daos;

import com.models.Refund;
import com.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RefundDAO {

    public List<Refund> getRefundsByUserId(int userId) {
        List<Refund> refundList = new ArrayList<>();
        String sql = "SELECT r.* FROM refund r " +
                     "JOIN returnrequest rr ON r.requestId = rr.requestId " +
                     "WHERE rr.userId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Refund refund = new Refund();
                refund.setRefundId(rs.getInt("refundId"));
                refund.setRequestId(rs.getInt("requestId"));
                refund.setAmount(rs.getDouble("amount"));
                refund.setMethod(rs.getString("method"));
                refund.setProcessedDate(rs.getTimestamp("processedDate"));
                refund.setProcessedBy(rs.getInt("processedBy"));
                refundList.add(refund);
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving refund list: " + e.getMessage());
            e.printStackTrace();
        }

        return refundList;
    }

    public boolean createRefund(Refund refund) {
        String sql = "INSERT INTO refund (requestId, amount, method, accountDetails, processedDate, processedBy, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, refund.getRequestId());
            ps.setDouble(2, refund.getAmount());
            ps.setString(3, refund.getMethod());
            ps.setString(4, refund.getAccountDetails());
            ps.setTimestamp(5, refund.getProcessedDate());
            ps.setInt(6, refund.getProcessedBy());
            ps.setString(7, refund.getStatus());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    refund.setRefundId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Refund> getRefundsByUser(int userId) {
        List<Refund> refunds = new ArrayList<>();
        String sql = "SELECT r.* FROM refund r " +
                     "JOIN returnrequest req ON r.requestId = req.requestId " +
                     "WHERE req.userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Refund refund = new Refund();
                refund.setRefundId(rs.getInt("refundId"));
                refund.setRequestId(rs.getInt("requestId"));
                refund.setAmount(rs.getDouble("amount"));
                refund.setMethod(rs.getString("method"));
                refund.setAccountDetails(rs.getString("accountDetails"));
                refund.setProcessedDate(rs.getTimestamp("processedDate"));
                refund.setProcessedBy(rs.getInt("processedBy"));
                refund.setStatus(rs.getString("status"));
                refunds.add(refund);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return refunds;
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
