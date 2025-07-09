<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Return Requests | Product Return System</title>
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

        .alert-success {
            background-color: #e6f7ee;
            color: #2e7d32;
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

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-approved {
            background-color: #e6f7ee;
            color: #2e7d32;
        }

        .status-rejected {
            background-color: #fde8e8;
            color: #d32f2f;
        }

        .status-completed {
            background-color: #e3f2fd;
            color: #1565c0;
        }

        .status-cancelled {
            background-color: #f3e5f5;
            color: #7b1fa2;
        }

        .action-btn {
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius);
            font-weight: 500;
            font-size: 0.875rem;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            border: none;
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background-color: #e5177a;
            transform: translateY(-2px);
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

        .reason-cell {
            max-width: 250px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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
            <i class="fas fa-undo"></i> My Return Requests
        </h1>
    </div>

    <!-- Flash messages -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
            <c:remove var="successMessage" scope="session"/>
        </div>
    </c:if>
    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
            <c:remove var="errorMessage" scope="session"/>
        </div>
    </c:if>

    <div class="card">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Request ID</th>
                        <th>Product</th>
                        <th>Qty</th>
                        <th>Reason</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${returnList}">
                        <tr>
                            <td>#${r.requestId}</td>
                            <td>#${r.productId}</td>
                            <td>${r.quantity}</td>
                            <td class="reason-cell" title="${r.reason}">${r.reason}</td>
                            <td>
                                <span class="status-badge 
                                    <c:choose>
                                        <c:when test="${r.status == 'pending'}">status-pending</c:when>
                                        <c:when test="${r.status == 'approved'}">status-approved</c:when>
                                        <c:when test="${r.status == 'rejected'}">status-rejected</c:when>
                                        <c:when test="${r.status == 'completed'}">status-completed</c:when>
                                        <c:when test="${r.status == 'cancelled'}">status-cancelled</c:when>
                                    </c:choose>">
                                    <c:choose>
                                        <c:when test="${r.status == 'pending'}">
                                            <i class="fas fa-clock"></i>
                                        </c:when>
                                        <c:when test="${r.status == 'approved'}">
                                            <i class="fas fa-check"></i>
                                        </c:when>
                                        <c:when test="${r.status == 'rejected'}">
                                            <i class="fas fa-times"></i>
                                        </c:when>
                                        <c:when test="${r.status == 'completed'}">
                                            <i class="fas fa-check-double"></i>
                                        </c:when>
                                        <c:when test="${r.status == 'cancelled'}">
                                            <i class="fas fa-ban"></i>
                                        </c:when>
                                    </c:choose>
                                    ${r.status}
                                </span>
                            </td>
                            <td>${r.requestDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.status == 'pending'}">
                                        <form action="CancelReturnServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="requestId" value="${r.requestId}" />
                                            <button type="submit" class="action-btn btn-danger">
                                                <i class="fas fa-times"></i> Cancel
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">No actions</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <c:if test="${empty returnList}">
            <div class="empty-state">
                <i class="fas fa-box-open"></i>
                <h4>No Return Requests</h4>
                <p>You haven't submitted any return requests yet.</p>
                <a href="${pageContext.request.contextPath}/return-request.jsp" class="action-btn" style="background-color: var(--primary); color: white; margin-top: 1rem;">
                    <i class="fas fa-undo"></i> Request a Return
                </a>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>