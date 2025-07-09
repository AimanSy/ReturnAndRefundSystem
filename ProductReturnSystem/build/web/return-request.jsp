<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Return Request | Product Return System</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #eef2ff;
            --danger: #f72585;
            --success: #4cc9f0;
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
            padding: 2rem;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2.5rem;
        }

        h1 {
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .error-message {
            background-color: #fde8e8;
            color: var(--danger);
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark);
        }

        select, input, textarea {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 1px solid var(--light-gray);
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
            background-color: #f8fafc;
        }

        select:focus, input:focus, textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            background-color: white;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .btn {
            padding: 0.875rem 1.75rem;
            border-radius: var(--border-radius);
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            border: none;
            font-size: 1rem;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: #3a56d4;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.2);
        }

        .product-option {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
        }

        .product-details {
            color: var(--gray);
            font-size: 0.875rem;
        }

        .form-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--light-gray);
        }

        .form-note {
            font-size: 0.875rem;
            color: var(--gray);
        }

        @media (max-width: 768px) {
            .container {
                padding: 1.5rem;
            }
            
            body {
                padding: 1rem;
            }
            
            .form-footer {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>
            <i class="fas fa-undo"></i> Create Return Request
        </h1>

        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/SubmitReturnServlet" method="post">
            <div class="form-group">
                <label for="productId">Select Product</label>
                <select id="productId" name="productId" required>
                    <option value="">-- Select a product to return --</option>
                    <c:forEach items="${productList}" var="product">
                        <option value="${product.productId}">
                            <span class="product-option">
                                <span>${product.name}</span>
                                <span class="product-details">ID: ${product.productId}</span>
                            </span>
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="quantity">Quantity to Return</label>
                <input type="number" id="quantity" name="quantity" min="1" 
                       placeholder="Enter quantity" required>
            </div>

            <div class="form-group">
                <label for="reason">Reason for Return</label>
                <textarea id="reason" name="reason" 
                          placeholder="Please describe why you're returning this item" required></textarea>
            </div>

            <<div class="form-footer">
                <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                    <a href="${pageContext.request.contextPath}/DashboardServlet" class="btn btn-secondary" style="
                        background-color: var(--gray);
                        color: white;
                    ">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>

                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane"></i> Submit Return Request
                    </button>
                </div>

                <p class="form-note">
                    <i class="fas fa-info-circle"></i> Returns are typically processed within 3-5 business days after we receive your item.
                </p>
            </div>

        </form> 
    </div>

    <script>
        // Enhance the form with dynamic product details
        document.getElementById('productId').addEventListener('change', function() {
            // You could add logic here to show product details when selected
            // For example, fetch and display product image or description
        });
    </script>
</body>
</html>