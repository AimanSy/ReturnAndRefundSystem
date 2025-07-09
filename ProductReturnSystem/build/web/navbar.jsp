<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Bootstrap CSS (for responsiveness) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

<style>
    :root {
        --primary: #4b6cb7;
        --secondary: #182848;
        --light: #ffffff;
        --dark: #1a1a2e;
        --gray: #6c757d;
        --border-radius: 8px;
        --transition: all 0.3s ease;
    }

    body {
        font-family: 'Inter', sans-serif;
        margin: 0;
    }

    .navbar {
        background: linear-gradient(to right, var(--primary), var(--secondary));
        padding: 0.75rem 2rem;
        font-family: 'Inter', sans-serif;
    }

    .navbar-brand {
        font-weight: 600;
        font-size: 1.25rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
        color: var(--light);
    }

    .navbar-brand i {
        font-size: 1.1rem;
    }

    .navbar-nav .nav-link {
        color: #f1f1f1;
        padding: 0.6rem 1rem;
        margin-left: 0.25rem;
        font-weight: 500;
        transition: var(--transition);
        border-radius: var(--border-radius);
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .navbar-nav .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.15);
        color: #fff;
    }

    .logout-link {
        background: rgba(255, 255, 255, 0.1);
    }

    .logout-link:hover {
        background: rgba(255, 255, 255, 0.2);
    }

    .navbar-toggler {
        border: none;
    }

    .navbar-toggler:focus {
        box-shadow: none;
    }
</style>

<nav class="navbar navbar-expand-lg">
    <a class="navbar-brand" href="dashboard.jsp">
        <i class="fas fa-exchange-alt"></i> Product Return System
    </a>
    <button class="navbar-toggler text-white" type="button" data-toggle="collapse" data-target="#navbarNav">
        <i class="fas fa-bars"></i>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="dashboard.jsp">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="ReturnRequestServlet">
                    <i class="fas fa-undo"></i> New Return Request
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="ViewReturnServlet">
                    <i class="fas fa-list"></i> My Requests
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="ViewRefundServlet">
                    <i class="fas fa-money-bill-wave"></i> My Refunds
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link logout-link" href="LogoutServlet">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </li>
        </ul>
    </div>
</nav>

<!-- Bootstrap JS (for toggler) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
