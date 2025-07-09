<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Refund Confirmation | Product Return System</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #eef2ff;
            --success: #4cc9f0;
            --success-light: #e8f5e9;
            --success-dark: #2e7d32;
            --dark: #1a1a2e;
            --light: #f8f9fa;
            --gray: #6c757d;
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 2rem;
        }

        .confirmation-container {
            max-width: 600px;
            width: 100%;
            text-align: center;
        }

        .confirmation-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2.5rem;
            margin-bottom: 2rem;
        }

        .confirmation-icon {
            width: 80px;
            height: 80px;
            background-color: var(--success-light);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            color: var(--success-dark);
            font-size: 2.5rem;
        }

        h1 {
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--dark);
        }

        .confirmation-message {
            background: var(--success-light);
            color: var(--success-dark);
            padding: 1.25rem;
            border-radius: var(--border-radius);
            margin-bottom: 2rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .next-steps {
            text-align: left;
            margin: 2rem 0;
            padding: 0 1rem;
        }

        .next-steps h3 {
            font-weight: 600;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .next-steps ol {
            padding-left: 1.5rem;
        }

        .next-steps li {
            margin-bottom: 0.75rem;
            padding-left: 0.5rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.875rem 1.75rem;
            border-radius: var(--border-radius);
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
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

        .btn-outline {
            border: 1px solid var(--primary);
            color: var(--primary);
            background: white;
        }

        .btn-outline:hover {
            background-color: var(--primary-light);
            transform: translateY(-2px);
        }

        @media (max-width: 576px) {
            .confirmation-card {
                padding: 1.5rem;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 0.75rem;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <div class="confirmation-card">
            <div class="confirmation-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            
            <h1>Refund Request Received</h1>
            
            <c:if test="${not empty successMessage}">
                <div class="confirmation-message">
                    <i class="fas fa-check-circle"></i> ${successMessage}
                </div>
            </c:if>
            
            <div class="next-steps">
                <h3><i class="fas fa-list-ol"></i> Next Steps</h3>
                <ol>
                    <li>Your refund will be processed within <strong>3-5 business days</strong></li>
                    <li>You'll receive email confirmation when the refund is completed</li>
                    <li>Contact our support team if you have any questions</li>
                </ol>
            </div>
            
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/refund-request" class="btn btn-primary">
                    <i class="fas fa-undo"></i> Request Another Refund
                </a>
                <a href="order-history.jsp" class="btn btn-outline">
                    <i class="fas fa-history"></i> View Order History
                </a>
            </div>
        </div>
    </div>
</body>
</html>