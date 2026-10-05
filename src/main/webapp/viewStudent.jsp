<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>View Students - Student Performance Analyzer</title>

    <!-- Link to your existing stylesheet -->
    <link rel="stylesheet" href="css/style.css">

    <!-- Embedded CSS to instantly apply spacing and professional design -->
    <style>
        /* Target the layout inside the Actions column cells */
        .actions-cell {
            text-align: center !important;
            white-space: nowrap !important;
            padding: 10px 4px !important;
        }

        /* Centered cell for student photo (Increased width for larger photo layout) */
        .photo-cell {
            text-align: center !important;
            vertical-align: middle !important;
            width: 80px !important;
            padding: 8px !important;
        }

        /* Professional LARGE Round Student Avatar Styling */
        .student-avatar {
            width: 55px !important;       /* Made profile size bigger */
            height: 55px !important;      /* Made profile size bigger */
            border-radius: 50% !important; /* Forces image into a perfect circle */
            object-fit: cover !important;  /* Prevents squishing/stretching of photos */
            border: 2px solid #e5e7eb !important; /* Clean gray premium border line */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important; /* Softer professional shadow */
            display: inline-block !important;
            vertical-align: middle !important;
        }

        /* Professional Action Button Container Base */
        .action-btn {
            text-decoration: none !important;
            font-size: 15px !important; 
            width: 36px !important;
            height: 36px !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            border-radius: 8px !important; 
            margin: 0 10px !important; /* Forces a wide clean gap between update and delete */
            transition: all 0.2s ease-in-out !important;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.06) !important; 
            border: 1px solid transparent !important;
            cursor: pointer;
        }

        /* Professional Update Button Layout Tint */
        .edit-btn {
            background-color: #e8f0fe !important; 
            border-color: #d2e3fc !important;
        }

        /* Smooth Blue Transition on Hover */
        .edit-btn:hover {
            background-color: #2563eb !important; 
            border-color: #2563eb !important;
            transform: translateY(-2px) !important;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3) !important;
        }

        /* Professional Delete Button Layout Tint */
        .delete-btn {
            background-color: #fce8e6 !important; 
            border-color: #fad2cf !important;
        }

        /* Smooth Red Transition on Hover */
        .delete-btn:hover {
            background-color: #dc2626 !important; 
            border-color: #dc2626 !important;
            transform: translateY(-2px) !important;
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3) !important;
        }
    </style>

    <!-- JavaScript for Safe Deletion Confirmation Pop-up -->
    <script>
        function confirmDeletion(studentId, studentName) {
            if (confirm("Are you sure you want to delete " + studentName + " (ID: " + studentId + ")?")) {
                window.location.href = "DeleteStudentServlet?id=" + studentId;
            }
        }
    </script>
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

    <div class="table-container">

        <div class="page-heading">
            <h1>Student Details</h1>
            <p>View all registered student performance details</p>
        </div>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th style="text-align: center; width: 80px;">Photo</th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Java</th>
                        <th>SQL</th>
                        <th>DBMS</th>
                        <th>Attendance</th>
                        <th style="text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    ResultSet rs = (ResultSet) request.getAttribute("studentResult");

                    while (rs != null && rs.next()) {
                        int currentId = rs.getInt("id");
                        String currentName = rs.getString("name");
                        
                        // Read the real path string out of the database column dynamically
                        String dbPhoto = rs.getString("photo_path");
                        String photoPath;
                        
                        // Fallback check logic to prevent broken images
                        if (dbPhoto == null || dbPhoto.trim().isEmpty() || dbPhoto.equals("default-avatar.png")) {
                            photoPath = "images/default-avatar.png";
                        } else {
                            photoPath = "uploads/" + dbPhoto;
                        }
                %>
                    <tr>
                        <!-- Render dynamic or fallback image path safely -->
                        <td class="photo-cell">
                            <img src="${pageContext.request.contextPath}/<%= photoPath %>" class="student-avatar" alt="Profile Layout">
                        </td>
                        <td>
                            <%= currentId %>
                        </td>
                        <td>
                            <%= currentName %>
                        </td>
                        <td>
                            <%= rs.getInt("java_marks") %>
                        </td>
                        <td>
                            <%= rs.getInt("sql_marks") %>
                        </td>
                        <td>
                            <%= rs.getInt("dbms_marks") %>
                        </td>
                        <td>
                            <%= rs.getInt("attendance") %>%
                        </td>
                        <td class="actions-cell">
                            <!-- Update/Edit Button Module -->
                            <a href="UpdateStudentServlet?id=<%= currentId %>" class="action-btn edit-btn" title="Edit Student">
                                ✏️
                            </a>
                            
                            <!-- Delete Button Module -->
                            <a href="javascript:void(0);" onclick="confirmDeletion('<%= currentId %>', '<%= currentName %>')" class="action-btn delete-btn" title="Delete Student">
                                🗑️
                            </a>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <div class="table-actions">
            <a href="addStudent.jsp" class="card-button">
                + Add Student
            </a>
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
