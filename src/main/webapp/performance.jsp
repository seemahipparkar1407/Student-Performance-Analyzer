<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Analyze Performance - Student Performance Analyzer</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=2.5">
</head>
<body>

    <!-- Header Navigation Bar -->
    <nav class="navbar">
        <div class="logo">
            <span>Student Performance Analyzer</span>
        </div>
        <div class="nav-links">
            <a href="dashboard.jsp">Dashboard</a>
        </div>
    </nav>

    <!-- Form Layout Wrappers -->
    <div class="form-container">
        <div class="form-card">
            
            <h1>Analyze Performance</h1>
            <p class="form-subtitle">Enter a student's ID to check grades and feedback</p>

            <!-- 1. FIXED ACTION PATH: Using contextPath ensures it points directly to the compiled Servlet -->
            <form action="${pageContext.request.contextPath}/AnalyzePerformanceServlet" method="POST">
                
                <div class="form-group">
                    <label for="studentId">Student ID:</label>
                    <!-- 2. CRITICAL NAME ATTRIBUTE: Must be exactly name="id" so the Servlet parameter reads it -->
                    <input type="number" id="studentId" name="id" placeholder="e.g. 110" required>
                </div>

                <button type="submit" class="submit-button">
                    Analyze Performance
                </button>

            </form>

            <a href="dashboard.jsp" class="back-link">
                ← Back to Dashboard
            </a>

        </div>
    </div>

    <!-- Sticky Footer -->
    <footer>
        <p>© 2026 Student Performance Analyzer</p>
    </footer>

</body>
</html>
