<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Add Student - Student Performance Analyzer</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <nav class="navbar">
        <div class="logo">
            Student Performance Analyzer
        </div>
        <div class="nav-links">
            <a href="dashboard.jsp">Dashboard</a>
        </div>
    </nav>

    <div class="form-container">
        <div class="form-card">

            <h1>Add New Student</h1>
            <p class="form-subtitle">Enter student academic details</p>

            <!-- CRITICAL CHANGE: Added enctype="multipart/form-data" to allow image file uploading -->
            <form action="AddStudentServlet" method="post" enctype="multipart/form-data">

                <div class="form-group">
                    <label>Student ID</label>
                    <input type="number" name="id" placeholder="Enter student ID" required>
                </div>

                <div class="form-group">
                    <label>Student Name</label>
                    <input type="text" name="name" placeholder="Enter student name" required>
                </div>

                <!-- NEW ADDITION: Student Profile Photo Upload Input Field -->
                <div class="form-group">
                    <label>Profile Photo</label>
                    <input type="file" name="studentPhoto" accept="image/*">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Java Marks</label>
                        <input type="number" name="javaMarks" min="0" max="100" placeholder="0 - 100" required>
                    </div>

                    <div class="form-group">
                        <label>SQL Marks</label>
                        <input type="number" name="sqlMarks" min="0" max="100" placeholder="0 - 100" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>DBMS Marks</label>
                        <input type="number" name="dbmsMarks" min="0" max="100" placeholder="0 - 100" required>
                    </div>

                    <div class="form-group">
                        <label>Attendance (%)</label>
                        <input type="number" name="attendance" min="0" max="100" placeholder="0 - 100" required>
                    </div>
                </div>

                <button type="submit" class="submit-button">
                    Add Student
                </button>

            </form>

            <a href="dashboard.jsp" class="back-link">
                ← Back to Dashboard
            </a>

        </div>
    </div>

    <footer>
        <p>© 2026 Student Performance Analyzer</p>
    </footer>

</body>
</html>
