package com.models;
import java.sql.Timestamp;

public class ReturnRequest {
    private int requestId;
    private int userId;
    private int productId;
    private int quantity;
    private String reason;
    private String status;
    private Timestamp requestDate;
    private String productName;
    

    // Constructors
    public ReturnRequest() {
    }

    public ReturnRequest(int userId, int productId, int quantity, String reason, String status) {
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.reason = reason;
        this.status = status;
        this.requestDate = new Timestamp(System.currentTimeMillis());
    }

    // Getters
    public int getRequestId() {
        return requestId;
    }

    public int getUserId() {
        return userId;
    }

    public int getProductId() {
        return productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getReason() {
        return reason;
    }

    public String getStatus() {
        return status;
    }

    public Timestamp getRequestDate() {
        return requestDate;
    }

    // Setters
    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setRequestDate(Timestamp requestDate) {
        this.requestDate = requestDate;
    }
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
    @Override
    public String toString() {
        return "ReturnRequest{" +
                "requestId=" + requestId +
                ", userId=" + userId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", reason='" + reason + '\'' +
                ", status='" + status + '\'' +
                ", requestDate=" + requestDate +
                '}';
    }
}