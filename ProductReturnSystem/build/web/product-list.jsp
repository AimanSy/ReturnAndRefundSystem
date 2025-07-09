<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product List | Product Return System</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #eef2ff;
            --secondary: #3f37c9;
            --success: #4cc9f0;
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

        .price-cell {
            font-weight: 600;
            color: var(--primary);
        }

        .stock-cell {
            font-weight: 500;
        }

        .in-stock {
            color: #2e7d32;
        }

        .low-stock {
            color: #ed6c02;
        }

        .out-of-stock {
            color: #d32f2f;
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

        .search-bar {
            display: flex;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
        }

        .search-input {
            flex: 1;
            padding: 0.75rem 1rem;
            border: 1px solid var(--light-gray);
            border-radius: var(--border-radius);
            font-size: 0.9375rem;
            transition: var(--transition);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
        }

        .search-btn {
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            padding: 0 1.5rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
        }

        .search-btn:hover {
            background-color: var(--secondary);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1 class="page-title">
            <i class="fas fa-boxes"></i> Product Catalog
        </h1>
    </div>

    <div class="search-bar">
        <input type="text" class="search-input" placeholder="Search products...">
        <button class="search-btn">
            <i class="fas fa-search"></i>
        </button>
    </div>

    <div class="card">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Description</th>
                        <th>Price (RM)</th>
                        <th>Stock Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${productList}">
                        <tr>
                            <td>#${product.productId}</td>
                            <td><strong>${product.name}</strong></td>
                            <td>${product.description}</td>
                            <td class="price-cell">RM ${product.price}</td>
                            <td class="stock-cell 
                                <c:choose>
                                    <c:when test="${product.stock > 10}">in-stock</c:when>
                                    <c:when test="${product.stock > 0}">low-stock</c:when>
                                    <c:otherwise>out-of-stock</c:otherwise>
                                </c:choose>">
                                ${product.stock} units
                                <c:if test="${product.stock > 10}"><i class="fas fa-check-circle ml-2"></i></c:if>
                                <c:if test="${product.stock > 0 && product.stock <= 10}"><i class="fas fa-exclamation-circle ml-2"></i></c:if>
                                <c:if test="${product.stock == 0}"><i class="fas fa-times-circle ml-2"></i></c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <c:if test="${empty productList}">
            <div class="empty-state">
                <i class="fas fa-box-open"></i>
                <h4>No Products Found</h4>
                <p>There are currently no products available in the catalog.</p>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>