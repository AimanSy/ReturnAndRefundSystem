package com.models;

import java.sql.Timestamp;

public class Refund {
    private int refundId;
    private int requestId;
    private double amount;
    private String method;
    private String accountDetails; // Added field
    private Timestamp processedDate;
    private int processedBy;
    private String status; // Added field

    // Getters and Setters
    public int getRefundId() { return refundId; }
    public void setRefundId(int refundId) { this.refundId = refundId; }

    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }
     public void setReturnId(int returnId) {
        this.requestId = returnId;  // Simply map to requestId
    }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }

    public String getAccountDetails() { return accountDetails; }
    public void setAccountDetails(String accountDetails) { this.accountDetails = accountDetails; }

    public Timestamp getProcessedDate() { return processedDate; }
    public void setProcessedDate(Timestamp processedDate) { this.processedDate = processedDate; }

    public int getProcessedBy() { return processedBy; }
    public void setProcessedBy(int processedBy) { this.processedBy = processedBy; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}