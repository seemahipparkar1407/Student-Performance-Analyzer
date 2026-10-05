<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Student - Student Performance Analyzer</title>
    <!-- Using contextPath ensures your stylesheet always binds correctly across Tomcat servlets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=5.0">
</head>
<body>

    <!-- 1. Header Navigation Bar (Matches Dashboard Theme) -->
    <nav class="navbar">
        <div class="logo">
            <span>Student Performance Analyzer</span>
        </div>
        <div class="nav-links">
            <a href="dashboard.jsp">Dashboard</a>
        </div>
    </nav>

    <!-- 2. Warning Centered Delete Card Layout Workspace -->
    <div class="form-container">
        <div class="form-card">
            
            <h1>Delete Student</h1>
            <p class="form-subtitle" style="color: #b91c1c; font-weight: 600; margin-bottom: 25px;">
                ⚠️ Warning: Removing a student record is permanent and cannot be undone.
            </p>

            <!-- Action maps exactly to your verified DeleteStudentServlet backend -->
            <form action="DeleteStudentServlet" method="POST">
                
                <!-- Student ID Target Row -->
                <div class="form-group">
                    <label for="studentId">Student ID:</label>
                    <!-- Using name="id" to match your servlet parameter exactly -->
                    <input type="text" id="studentId" name="id" placeholder="Enter Student ID to remove (e.g., 101)" required>
                </div>

                <!-- Main Action Submission Button (Uses your red CSS delete theme) -->
                <button type="submit" class="submit-button delete-button">
                    Delete Student Record
                </button>

            </form>

            <!-- Navigation Redirect Link -->
            <a href="dashboard.jsp" class="back-link">
                ← Back to Dashboard
            </a>

        </div>
    </div>

    <!-- 3. Sticky Dashboard Footer Layout -->
    <footer>
        <p>© 2026 Student Performance Analyzer</p>
    </footer>

</body>
</html>
