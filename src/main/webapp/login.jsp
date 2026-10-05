<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.student1.DBConnection" %>

<%
    String errorMsg = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, user);
            ps.setString(2, pass);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    session.setAttribute("authenticatedUser", user);

                    response.sendRedirect("dashboard.jsp");
                    return;

                } else {

                    errorMsg = "Invalid Username or Password. Please try again.";
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            errorMsg = "Database Connection Failure: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login</title>
    <style>
        /* ==========================================================================
           MATCHING GLASSMORPHISM THEME
           ========================================================================== */
        * { 
            box-sizing: border-box; 
            margin: 0; 
            padding: 0; 
        }
        
        body {
            min-height: 100vh;
            background: radial-gradient(circle at 10% 20%, rgb(4, 32, 66) 0%, rgb(12, 12, 14) 90%);
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
            padding: 20px;
            overflow: hidden;
            position: relative;
        }

        /* Tech Background Accents */
        body::before, body::after {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: linear-gradient(135deg, #0284c7, #0369a1);
            filter: blur(80px);
            z-index: 1;
            opacity: 0.4;
        }
        body::before { top: 15%; left: 20%; animation: floatGlow 8s ease-in-out infinite alternate; }
        body::after { bottom: 15%; right: 20%; animation: floatGlow 12s ease-in-out infinite alternate-reverse; }

        @keyframes floatGlow {
            0% { transform: translateY(0) scale(1); }
            100% { transform: translateY(-20px) scale(1.1); }
        }

        /* Glassmorphic Portal Container Layout */
        .login-container {
            width: 100%;
            max-width: 400px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(16px) saturate(120%);
            -webkit-backdrop-filter: blur(16px) saturate(120%);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 40px 35px 30px 35px;
            display: flex;
            flex-direction: column;
            align-items: center;
            border-radius: 16px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
            z-index: 2;
            animation: fadeInCard 0.6s ease-out;
        }

        @pragma { opacity: 1; }

        @keyframes fadeInCard {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .graduation-image {
            display: block;
            width: 110px;
            height: 90px;
            object-fit: contain;
            margin-bottom: 15px;
            filter: drop-shadow(0 4px 8px rgba(2, 132, 199, 0.3));
        }

        .login-title {
            font-size: 26px;
            font-weight: 700;
            color: #ffffff;
            text-align: center;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        .description-text {
            font-size: 13.5px;
            color: #94a3b8;
            text-align: center;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        .login-form { width: 100%; }

        .input-group {
            position: relative;
            margin-bottom: 16px;
        }

        .input-box {
            display: block;
            width: 100%;
            height: 48px;
            background: rgba(15, 23, 42, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            padding: 0 16px;
            font-size: 15px;
            color: #f8fafc;
            outline: none;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .input-box::placeholder {
            color: #64748b;
        }

        .input-box:focus {
            background: rgba(15, 23, 42, 0.8);
            border-color: #38bdf8;
            box-shadow: 0 0 0 3px rgba(56, 189, 248, 0.15);
        }

        .login-button {
            display: block;
            width: 100%;
            height: 46px;
            margin: 24px 0 20px 0;
            background: linear-gradient(135deg, #0ea5e9, #0284c7);
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 4px 12px rgba(2, 132, 199, 0.3);
        }

        .login-button:hover {
            background: linear-gradient(135deg, #38bdf8, #0ea5e9);
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(2, 132, 199, 0.4);
        }

        .forgot-password {
            text-align: center;
            margin-top: 10px;
        }

        .forgot-password a {
            color: #38bdf8;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .forgot-password a:hover {
            color: #7dd3fc;
        }

        .error-message {
            width: 100%;
            border-radius: 8px;
            padding: 12px;
            text-align: center;
            font-size: 13.5px;
            margin-bottom: 18px;
            font-weight: 500;
            background: rgba(239, 68, 68, 0.1);
            color: #fca5a5;
            border: 1px solid rgba(239, 68, 68, 0.2);
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .bottom-line {
            width: 60px;
            height: 3px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 2px;
            margin-top: 25px;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <img src="images/graduation_logo.png" alt="🎓" class="graduation-image">
        <h1 class="login-title">Login</h1>
        <p class="description-text">Welcome back! Sign in to access your student performance dashboard analyses profile tools.</p>

        <% if (errorMsg != null) { %>
            <div class="error-message"><%= errorMsg %></div>
        <% } %>

        <form action="" method="POST" class="login-form">
            <div class="input-group">
                <input type="text" name="username" placeholder="Username" class="input-box" required>
            </div>
            <div class="input-group">
                <input type="password" name="password" placeholder="Password" class="input-box" required>
            </div>
            
            <button type="submit" class="login-button">Log In</button>
        </form>

        <div class="forgot-password">
            <a href="forgotPassword.jsp">Forgot Password?</a>
        </div>
        <div class="bottom-line"></div>
    </div>

</body>
</html>
