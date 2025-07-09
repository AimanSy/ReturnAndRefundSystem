<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Refunds | Product Return System</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #eef2ff;
            --success: #4cc9f0;
            --warning: #f8961e;
            --danger: #f72585;
            --dark: #1a1a2e;
            --light: #f8f9fa;
            --gray: #6c757d;
            --light-gray: #e9ecef;
            --border-radius: 12px;
            --box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f5f7fb;
            color: var(--dark);
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-weight: 600;
            color: var(--dark);
            font-size: 1.75rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            border: none;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .alert {
            border-radius: var(--border-radius);
            padding: 1rem;
            margin-bottom: 1.5rem;
            border: none;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-danger {
            background-color: #fde8e8;
            color: var(--danger);
        }

        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .table thead th {
            background-color: #f8fafc;
            color: var(--gray);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            padding: 1rem 1.5rem;
            border: none;
            position: sticky;
            top: 0;
        }

        .table tbody td {
            padding: 1rem 1.5rem;
            border-top: 1px solid var(--light-gray);
            vertical-align: middle;
        }

        .table tbody tr:last-child td {
            border-bottom: 1px solid var(--light-gray);
        }

        .table tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            gap: 0.5rem;
        }

        .status-completed {
            background-color: #e6f7ee;
            color: #2e7d32;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-failed {
            background-color: #fde8e8;
            color: #d32f2f;
        }

        .amount-cell {
            font-weight: 600;
            color: var(--primary);
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--gray);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--light-gray);
        }

        .empty-state h4 {
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .method-icon {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background-color: var(--primary-light);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 0.5rem;
            color: var(--primary);
            font-size: 0.75rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 1rem;
            }
            
            .table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container">
    <div class="page-header">
        <h1 class="page-title">
            <i class="fas fa-money-bill-wave"></i> My Refunds
        </h1>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>

    <div class="card">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Refund ID</th>
                        <th>Request ID</th>
                        <th>Amount</th>
                        <th>Method</th>
                        <th>Account</th>
                        <th>Status</th>
                        <th>Processed Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${refundList}">
                        <tr>
                            <td>#${r.refundId}</td>
                            <td>#${r.requestId}</td>
                            <td class="amount-cell">RM ${r.amount}</td>
                            <td>
                                <div class="method-icon">
                                    <c:choose>
                                        <c:when test="${r.method == 'credit_card'}">
                                            <i class="fas fa-credit-card"></i>
                                        </c:when>
                                        <c:when test="${r.method == 'bank_transfer'}">
                                            <i class="fas fa-university"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-wallet"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                ${r.method}
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.method == 'credit_card'}">
                                        ****${r.accountDetails.substring(r.accountDetails.length() - 4)}
                                    </c:when>
                                    <c:otherwise>
                                        ${r.accountDetails}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <span class="status-badge 
                                    <c:choose>
                                        <c:when test="${r.status == 'Completed'}">status-completed</c:when>
                                        <c:when test="${r.status == 'Pending'}">status-pending</c:when>
                                        <c:otherwise>status-failed</c:otherwise>
                                    </c:choose>">
                                    <c:choose>
                                        <c:when test="${r.status == 'Completed'}">
                                            <i class="fas fa-check-circle"></i>
                                        </c:when>
                                        <c:when test="${r.status == 'Pending'}">
                                            <i class="fas fa-clock"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-times-circle"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    ${r.status}
                                </span>
                            </td>
                            <td>${r.processedDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <c:if test="${empty refundList}">
            <div class="empty-state">
                <i class="fas fa-money-bill-alt"></i>
                <h4>No Refunds Found</h4>
                <p>You don't have any refunds processed yet.</p>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>