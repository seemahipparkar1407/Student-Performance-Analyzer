<%
    // Intercept navigation requests if authentication context tracking session parameters do not exist
    if (session == null || session.getAttribute("authenticatedUser") == null) {
        response.sendRedirect("login.jsp");
        return; 
    }
%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Student Performance Analyzer</title>
    <!-- Absolute context path prevents layout breaking if accessed from nested servlet paths -->
    <!-- Changing the version number to ?v=55.0 forces the browser to discard the old cache -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=55.0">
    
    <!-- Forces remaining 3 cards to layout perfectly on a single horizontal row line -->
    <style>
        .card-container {
            display: flex !important;
            flex-wrap: wrap !important;
            justify-content: center !important;
            gap: 30px !important;
            max-width: 1200px !important;
            margin: 40px auto !important;
        }
        
        .dashboard-card {
            flex: 1 !important;
            min-width: 280px !important;
            max-width: 350px !important;
        }
    </style>
</head>
<body>

    <!-- Header Navigation Bar -->
    <nav class="navbar">
        <div class="logo">
            <!-- FIXED: Added contextPath to secure the absolute location path -->
            <img src="${pageContext.request.contextPath}/images/logo.jpg" alt="Logo">
            <span>Student Performance Analyzer</span>
        </div>
        <div class="nav-links">
            <span style="margin-right: 15px; color: white;">Welcome, <%= session.getAttribute("authenticatedUser") %></span>
            <a href="logoutServlet" style="color: #ef4444; text-decoration: none; font-weight: bold;">Logout</a>
        </div>
    </nav>

    <div class="dashboard-container">

        <div class="welcome-section">
            <h1>Welcome to Student Performance Analyzer</h1>
            <p>
                Manage, monitor and analyze student academic performance easily.
            </p>
        </div>

        <div class="card-container">

            <!-- 1. Add Student Card -->
            <div class="dashboard-card">
                <div class="card-icon">👤</div>
                <h2>Add Student</h2>
                <p>Add new student details and academic marks.</p>
                <a href="addStudent.jsp" class="card-button">Add Student</a>
            </div>

            <!-- 2. View Students Card (Now houses inline Update & Delete operations) -->
            <div class="dashboard-card">
                <div class="card-icon">📋</div>
                <h2>View Students</h2>
                <p>View all registered student details.</p>
                <a href="viewStudentServlet" class="card-button">View Students</a>
            </div>

            <!-- 3. Analyze Performance Card -->
            <div class="dashboard-card">
                <div class="card-icon">📊</div>
                <h2>Analyze Performance</h2>
                <p>Check percentage, grade and weak subjects.</p>
                <a href="performance.jsp" class="card-button">Analyze</a>
            </div>

        </div>
    </div>

    <footer>
        <p>© 2026 Student Performance Analyzer</p>
    </footer>

</body>
</html>
