<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Product Return System</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #eef2ff;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --warning: #f8961e;
            --danger: #f72585;
            --dark: #1a1a2e;
            --light: #f8f9fa;
            --gray: #6c757d;
            --light-gray: #e9ecef;
            --sidebar-width: 260px;
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

        /* Navbar */
        .navbar {
            background: linear-gradient(to right, #4b6cb7, #182848);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #fff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            font-family: 'Inter', sans-serif;
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 1.25rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: #fff;
            text-decoration: none;
        }

        .navbar-brand i {
            font-size: 1.1rem;
        }

        .navbar-nav {
            list-style: none;
            display: flex;
            gap: 1rem;
            margin: 0;
            padding: 0;
        }

        .navbar-nav .nav-item .nav-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #f1f1f1;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 0.75rem;
            border-radius: 6px;
            transition: background 0.3s ease;
        }

        .navbar-nav .nav-item .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.15);
            color: #fff;
        }

        .navbar-nav .logout-link {
            background: rgba(255, 255, 255, 0.1);
        }

        .navbar-nav .logout-link:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }
            .navbar-nav {
                flex-direction: column;
                width: 100%;
            }
            .navbar-nav .nav-item {
                width: 100%;
            }
            .navbar-nav .nav-item .nav-link {
                width: 100%;
            }
        }

        /* Main Layout */
        .main-container {
            display: flex;
            min-height: calc(100vh - 64px);
        }

        /* Sidebar */
        .sidebar {
            width: var(--sidebar-width);
            background: white;
            border-right: 1px solid var(--light-gray);
            padding: 1.5rem 0;
            position: sticky;
            top: 0;
            height: calc(100vh - 64px);
        }

        .sidebar-menu {
            list-style: none;
        }

        .menu-item {
            margin-bottom: 0.25rem;
        }

        .menu-link {
            display: flex;
            align-items: center;
            padding: 0.75rem 1.5rem;
            color: var(--gray);
            text-decoration: none;
            transition: var(--transition);
            gap: 0.75rem;
            font-weight: 500;
        }

        .menu-link:hover, .menu-link.active {
            background-color: var(--primary-light);
            color: var(--primary);
        }

        .menu-link.active {
            border-left: 3px solid var(--primary);
        }

        .menu-link i {
            width: 20px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 2rem;
        }

        /* Dashboard Cards */
        .welcome-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-bottom: 2rem;
            padding: 1.5rem;
        }

        .welcome-card h2 {
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .welcome-card p {
            color: var(--gray);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 1.5rem;
            transition: var(--transition);
            border-top: 4px solid transparent;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card.pending {
            border-top-color: var(--warning);
        }

        .stat-card.approved {
            border-top-color: var(--success);
        }

        .stat-card.refunds {
            border-top-color: var(--primary);
        }

        .stat-header {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            gap: 0.75rem;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .stat-icon.pending {
            background: var(--warning);
        }

        .stat-icon.approved {
            background: var(--success);
        }

        .stat-icon.refunds {
            background: var(--primary);
        }

        .stat-title {
            font-weight: 500;
            color: var(--gray);
            font-size: 0.9375rem;
        }

        .stat-value {
            font-size: 1.75rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .stat-description {
            color: var(--gray);
            font-size: 0.875rem;
        }

        /* Quick Actions */
        .quick-actions {
            margin-top: 2rem;
        }

        .section-title {
            font-weight: 600;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .action-btn {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 1.25rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            text-decoration: none;
            color: var(--dark);
            transition: var(--transition);
        }

        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .action-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            color: white;
            font-size: 1.25rem;
        }

        .action-icon.request {
            background: var(--primary);
        }

        .action-icon.view {
            background: var(--success);
        }

        .action-icon.refund {
            background: var(--warning);
        }

        .action-icon.products {
            background: var(--secondary);
        }

        .action-label {
            font-weight: 500;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
    <a class="navbar-brand" href="dashboard.jsp">
        <i class="fas fa-exchange-alt"></i> Product Return System
    </a>
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" href="dashboard.jsp">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link logout-link" href="LogoutServlet">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </li>
        </ul>
    </nav>

    <!-- Main Layout -->
    <div class="main-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <ul class="sidebar-menu">
                <li class="menu-item">
                    <a href="dashboard.jsp" class="menu-link active">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                </li>
                <li class="menu-item">
                    <a href="ReturnRequestServlet" class="menu-link">
                        <i class="fas fa-undo"></i> New Return Request
                    </a>
                </li>
                <li class="menu-item">
                    <a href="ViewReturnServlet" class="menu-link">
                        <i class="fas fa-list"></i> My Return Requests
                    </a>
                </li>
                <li class="menu-item">
                    <a href="ViewRefundServlet" class="menu-link">
                        <i class="fas fa-money-bill-wave"></i> My Refunds
                    </a>
                </li>
                <li class="menu-item">
                    <a href="ProductListServlet" class="menu-link">
                        <i class="fas fa-boxes"></i> Product List
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Welcome Card -->
            <div class="welcome-card">
                <h2>Welcome back, <c:out value="${user.username}" />!</h2>
                <p>Here's what's happening with your return requests today.</p>
            </div>


            <div class="stats-grid">
                <!-- Pending Returns -->
                <div class="stat-card pending">
                    <div class="stat-header">
                        <div class="stat-icon pending">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div>
                            <div class="stat-title">Pending Returns</div>
                            <div class="stat-value"><c:out value="${pendingReturnsCount}" default="0" /></div>
                        </div>
                    </div>
                    <div class="stat-description">Waiting for approval</div>
                </div>

                <!-- Approved Returns -->
                <div class="stat-card approved">
                    <div class="stat-header">
                        <div class="stat-icon approved">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div>
                            <div class="stat-title">Approved Returns</div>
                            <div class="stat-value"><c:out value="${approvedReturnsCount}" default="0" /></div>
                        </div>
                    </div>
                    <div class="stat-description">Successfully processed</div>
                </div>

                <!-- Total Refunds -->
                <div class="stat-card refunds">
                    <div class="stat-header">
                        <div class="stat-icon refunds">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div>
                            <div class="stat-title">Total Refunds</div>
                            <div class="stat-value">$<c:out value="${totalRefunds}" default="0.00" /></div>
                        </div>
                    </div>
                    <div class="stat-description">Amount refunded</div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h3 class="section-title">
                    <i class="fas fa-bolt"></i> Quick Actions
                </h3>
                <div class="action-buttons">
                    <a href="ReturnRequestServlet" class="action-btn">
                        <div class="action-icon request">
                            <i class="fas fa-undo"></i>
                        </div>
                        <span class="action-label">New Return Request</span>
                    </a>
                    <a href="ViewReturnServlet" class="action-btn">
                        <div class="action-icon view">
                            <i class="fas fa-list"></i>
                        </div>
                        <span class="action-label">View My Returns</span>
                    </a>
                    <a href="ViewRefundServlet" class="action-btn">
                        <div class="action-icon refund">
                            <i class="fas fa-money-bill-wave"></i>
                        </div>
                        <span class="action-label">Check Refunds</span>
                    </a>
                    <a href="ProductListServlet" class="action-btn">
                        <div class="action-icon products">
                            <i class="fas fa-boxes"></i>
                        </div>
                        <span class="action-label">Browse Products</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>