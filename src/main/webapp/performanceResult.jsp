<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.student1.DBConnection" %>

<%
    // Extract parameters or default to testing ID if request attributes break down
    String idParam = request.getParameter("id");
    int id = 110; 
    if (idParam != null && !idParam.trim().isEmpty()) {
        try { id = Integer.parseInt(idParam.trim()); } catch(Exception e){}
    }

    // Capture attributes passed directly from your servlet
    String name = (String) request.getAttribute("name");
    Object javaObj = request.getAttribute("javaMarks");
    Object sqlObj = request.getAttribute("sqlMarks");
    Object dbmsObj = request.getAttribute("dbmsMarks");
    Object attObj = request.getAttribute("attendance");
    Object totalObj = request.getAttribute("total");
    Object pctObj = request.getAttribute("percentage");
    String grade = (String) request.getAttribute("grade");
    String weakSubject = (String) request.getAttribute("weakSubject");
    String photoPath = (String) request.getAttribute("photoPath");

    // UNBREAKABLE FALLBACK ENGINE: If data drops out or fails to pass down, fetch directly from DB inside the view
    if (name == null || name.isEmpty()) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM student WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
                javaObj = rs.getInt("java_marks");
                sqlObj = rs.getInt("sql_marks");
                dbmsObj = rs.getInt("dbms_marks");
                attObj = rs.getInt("attendance");
                String dbPhoto = rs.getString("photo_path");
                photoPath = (dbPhoto != null && !dbPhoto.trim().isEmpty() && !dbPhoto.equals("default-avatar.png")) 
                            ? "uploads/" + dbPhoto : "images/default-avatar.png";
                
                int total = (Integer)javaObj + (Integer)sqlObj + (Integer)dbmsObj;
                totalObj = total;
                double percentage = total / 3.0;
                pctObj = percentage;
                
                if (percentage >= 90) grade = "A+";
                else if (percentage >= 80) grade = "A";
                else if (percentage >= 70) grade = "B";
                else if (percentage >= 60) grade = "C";
                else grade = "Fail";
                
                int lowest = Math.min((Integer)javaObj, Math.min((Integer)sqlObj, (Integer)dbmsObj));
                if (lowest == (Integer)javaObj) weakSubject = "Java";
                else if (lowest == (Integer)sqlObj) weakSubject = "SQL";
                else weakSubject = "DBMS";
            }
            rs.close(); ps.close(); con.close();
        } catch(Exception e) { e.printStackTrace(); }
    }

    // Absolute fallback check for placeholder profile graphics
    if (photoPath == null || photoPath.trim().isEmpty()) {
        photoPath = "images/default-avatar.png";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Analysis Result - Student Performance Analyzer</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=9.5">
    
    <!-- Permanent Embedded Sizing styles to force image structure rendering -->
    <style>
        .analysis-profile-container {
            text-align: center !important;
            margin-bottom: 20px !important;
            margin-top: 15px !important;
            display: block !important;
        }
        
        .analysis-student-photo {
            width: 95px !important;
            height: 95px !important;
            border-radius: 50% !important;
            object-fit: cover !important;
            border: 3px solid #3b82f6 !important;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.12) !important;
            display: inline-block !important;
        }
        
        .student-info {
            text-align: center !important;
        }
    </style>
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

    <!-- Main Results Grid Workspace -->
    <div class="result-container">
        
        <div class="result-header">
            <h1>Performance Analysis</h1>
            <p>Comprehensive academic breakdown and performance insights</p>
        </div>

        <div class="student-info">
            <!-- Dynamic profile image block row layer -->
            <div class="analysis-profile-container">
                <img src="${pageContext.request.contextPath}/<%= photoPath %>" class="analysis-student-photo" alt="Student Profile View Target">
            </div>
            
            <h2><%= name != null ? name : "Loading..." %></h2>
            <p>Student ID Reference: <strong>#<%= id %></strong></p>
        </div>

        <!-- Grade-wise Performance Summary Cards Grid Block -->
        <div class="result-cards">
            <div class="result-card">
                <span>Java Programming</span>
                <strong><%= javaObj != null ? javaObj : "0" %></strong>
                <small>/ 100 Marks</small>
            </div>

            <div class="result-card">
                <span>SQL Database</span>
                <strong><%= sqlObj != null ? sqlObj : "0" %></strong>
                <small>/ 100 Marks</small>
            </div>

            <div class="result-card">
                <span>DBMS Systems</span>
                <strong><%= dbmsObj != null ? dbmsObj : "0" %></strong>
                <small>/ 100 Marks</small>
            </div>

            <div class="result-card">
                <span>Total Calculated</span>
                <strong><%= totalObj != null ? totalObj : "0" %></strong>
                <small>/ 300 Max</small>
            </div>
        </div>

        <!-- Aggregated Performance Metrics Row -->
        <div class="performance-summary">
            <div>
                <span>Percentage Score</span>
                <strong><%= pctObj != null ? String.format("%.2f", ((Number)pctObj).doubleValue()) : "0.00" %>%</strong>
            </div>

            <div>
                <span>Final Academic Grade</span>
                <strong style="color: #16a34a;"><%= grade != null ? grade : "N/A" %></strong>
            </div>

            <div>
                <span>Class Attendance</span>
                <strong><%= attObj != null ? attObj : "0" %>%</strong>
            </div>

            <div>
                <span>Subject Focus Needed</span>
                <strong style="color: #d97706;"><%= weakSubject != null ? weakSubject : "None" %></strong>
            </div>
        </div>

        <!-- Interactive Core Layout Actions Footer Row -->
        <div class="result-actions">
            <a href="performance.jsp" class="card-button">Analyze Another Student</a>
            <a href="dashboard.jsp" class="back-link">← Return to Dashboard</a>
        </div>

    </div>

    <footer>
        <p>© 2026 Student Performance Analyzer</p>
    </footer>

</body>
</html>
