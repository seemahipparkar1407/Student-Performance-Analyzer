<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Student - Student Performance Analyzer</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1.5">
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

    <!-- Professional Form Layout Workspace -->
    <div class="form-container">
        <div class="form-card">
            
            <h1>Update Student</h1>
            <p class="form-subtitle">Modify student marks and attendance records below</p>

            <form action="UpdateStudentServlet" method="POST">
                
                <!-- Hidden input field to pass the core ID back to your Servlet's doPost -->
                <input type="hidden" name="id" value="${studentId}">

                <!-- Read-Only Student Name Row so the user knows who they are updating -->
                <div class="form-group">
                    <label for="studentName">Student Name:</label>
                    <input type="text" id="studentName" value="${studentName}" style="background-color: #f3f4f6; color: #4b5563; cursor: not-allowed;" readonly>
                </div>

                <!-- Marks Row -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="javaMarks">New Java Marks:</label>
                        <input type="number" id="javaMarks" name="javaMarks" min="0" max="100" placeholder="0-100" value="${javaMarks}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="sqlMarks">New SQL Marks:</label>
                        <input type="number" id="sqlMarks" name="sqlMarks" min="0" max="100" placeholder="0-100" value="${sqlMarks}" required>
                    </div>
                </div>

                <!-- DBMS & Attendance Row -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="dbmsMarks">New DBMS Marks:</label>
                        <input type="number" id="dbmsMarks" name="dbmsMarks" min="0" max="100" placeholder="0-100" value="${dbmsMarks}" required>
                    </div>

                    <div class="form-group">
                        <label for="attendance">New Attendance (%):</label>
                        <input type="number" id="attendance" name="attendance" min="0" max="100" placeholder="0-100" value="${attendance}" required>
                    </div>
                </div>

                <!-- Main Action Submission Button -->
                <button type="submit" class="submit-button">
                    Update Student Records
                </button>

            </form>

            <!-- Navigation Redirect Link -->
            <a href="dashboard.jsp" class="back-link">
                ← Back to Dashboard
            </a>

        </div>
    </div>

    <!-- Sticky Dashboard Footer Layout -->
    <footer>
        <p>© 2026 Student Performance Analyzer</p>
    </footer>

</body>
</html>
