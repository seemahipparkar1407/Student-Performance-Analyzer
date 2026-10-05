package com.student.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.student1.DBConnection;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String user = request.getParameter("username");
		String pass = request.getParameter("password");

		// Ensure you have an 'admin' or 'users' table in your database setup
		String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, user);
			ps.setString(2, pass);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					// Login Success: Instantiate user session parameters
					HttpSession session = request.getSession();
					session.setAttribute("authenticatedUser", user);

					// Route user over to the functional dashboard
					response.sendRedirect("dashboard.jsp");
				} else {
					// Login Failure: Return user with inline warnings
					request.setAttribute("errorMessage", "Invalid Username or Password.");
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Database Connection Failure: " + e.getMessage());
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}
