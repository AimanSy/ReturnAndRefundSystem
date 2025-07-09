<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    :root {
      --primary: #4361ee;
      --primary-dark: #3a56d4;
      --secondary: #3f37c9;
      --success: #4cc9f0;
      --danger: #f72585;
      --light: #f8f9fa;
      --dark: #212529;
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
    
    .navbar {
        background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
        padding: 1rem 2rem;
        box-shadow: var(--box-shadow);
      }

      .navbar-brand {
        font-weight: 600;
        font-size: 1.5rem;
        color: #f8f9fa;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      .navbar-brand i {
        color: #4cc9f0;
      }

      .navbar-nav {
        list-style: none;
        display: flex;
        margin-left: auto;
      }

      .nav-item {
        margin-left: 1rem;
      }

      .nav-link {
        color: #e0e0e0;
        font-weight: 500;
        text-decoration: none;
        display: flex;
        align-items: center;
        transition: color 0.3s ease;
      }

    .nav-link i {
      margin-right: 8px;
    }

    .nav-link:hover {
      color: #4cc9f0;
    }
    
    .container {
      max-width: 1400px;
      margin: 2rem auto;
      padding: 0 1.5rem;
    }
    
    .dashboard-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 2rem;
    }
    
    .dashboard-title {
      font-weight: 600;
      color: var(--dark);
      font-size: 1.75rem;
    }
    
    .card {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--box-shadow);
      border: none;
      overflow: hidden;
      margin-bottom: 2rem;
    }
    
    .card-header {
      background: white;
      border-bottom: 1px solid var(--light-gray);
      padding: 1.25rem 1.5rem;
      font-weight: 600;
      color: var(--dark);
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    
    .badge-count {
      background: var(--primary);
      color: white;
      border-radius: 50px;
      padding: 0.25rem 0.75rem;
      font-size: 0.875rem;
      font-weight: 500;
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
    
    .btn {
      border-radius: 8px;
      padding: 0.5rem 1rem;
      font-weight: 500;
      font-size: 0.875rem;
      transition: var(--transition);
      display: inline-flex;
      align-items: center;
      justify-content: center;
    }
    
    .btn i {
      margin-right: 6px;
      font-size: 0.875rem;
    }
    
    .btn-sm {
      padding: 0.375rem 0.75rem;
      font-size: 0.8125rem;
    }
    
    .btn-success {
      background-color: var(--success);
      border-color: var(--success);
    }
    
    .btn-success:hover {
      background-color: #3ab7db;
      border-color: #3ab7db;
    }
    
    .btn-danger {
      background-color: var(--danger);
      border-color: var(--danger);
    }
    
    .btn-danger:hover {
      background-color: #e5177a;
      border-color: #e5177a;
    }
    
    .status-badge {
      display: inline-block;
      padding: 0.35rem 0.75rem;
      border-radius: 50px;
      font-size: 0.75rem;
      font-weight: 600;
    }
    
    .status-pending {
      background-color: #fff3cd;
      color: #856404;
    }
    
    .action-btns {
      display: flex;
      gap: 0.5rem;
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
  </style>
</head>
<body>
<nav class="navbar navbar-expand navbar-dark">
  <a class="navbar-brand" href="#">
    <i class="fas fa-shield-alt"></i> Admin Portal
  </a>
  <ul class="navbar-nav ml-auto">
    <li class="nav-item">
      <a class="nav-link" href="LogoutServlet?as=admin">
        <i class="fas fa-sign-out-alt"></i> Logout
      </a>
    </li>
  </ul>
</nav>

<div class="container">
  <div class="dashboard-header">
    <h1 class="dashboard-title">
      <i class="fas fa-exchange-alt"></i> Return Requests
    </h1>
    <div class="badge-count">
      ${pendingReturns.size()} Pending
    </div>
  </div>
  
  <div class="card">
    <div class="card-header">
      <span>Pending Return Requests</span>
      <span class="status-badge status-pending">
        <i class="fas fa-clock"></i> Needs Review
      </span>
    </div>
    
    <div class="card-body p-0">
      <c:choose>
        <c:when test="${not empty pendingReturns}">
          <table class="table">
            <thead>
              <tr>
                <th>Request ID</th>
                <th>User</th>
                <th>Product</th>
                <th>Qty</th>
                <th>Reason</th>
                <th>Date</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="r" items="${pendingReturns}">
                <tr>
                  <td>#${r.requestId}</td>
                  <td>User ${r.userId}</td>
                  <td>${r.productName}</td>
                  <td>${r.quantity}</td>
                  <td>${r.reason}</td>
                  <td>${r.requestDate}</td>
                  <td>
                    <div class="action-btns">
                      <a href="ApproveReturnServlet?requestId=${r.requestId}" class="btn btn-success btn-sm">
                        <i class="fas fa-check"></i> Approve
                      </a>
                      <a href="RejectReturnServlet?requestId=${r.requestId}" class="btn btn-danger btn-sm">
                        <i class="fas fa-times"></i> Reject
                      </a>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:when>
        <c:otherwise>
          <div class="empty-state">
            <i class="fas fa-inbox"></i>
            <h4>No Pending Returns</h4>
            <p>All return requests have been processed</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
</body>
</html>