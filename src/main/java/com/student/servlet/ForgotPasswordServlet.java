package com.student.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.student1.DBConnection;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Gathers parameter elements from your HTML page form layout fields
		String username = request.getParameter("username");
		String cityInput = request.getParameter("city");
		String newPass = request.getParameter("newPassword");

		// MATCHED PROPERLY: Compares user input string values directly with your
		// 'security_answer' table column
		String sql = "UPDATE users SET password = ? WHERE username = ? AND LOWER(security_answer) = LOWER(?)";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, newPass);
			ps.setString(2, username);

			if (cityInput != null) {
				ps.setString(3, cityInput.trim());
			} else {
				ps.setString(3, "");
			}

			int rowsUpdated = ps.executeUpdate();

			if (rowsUpdated > 0) {
				// Successful query execution and modification commit
				request.setAttribute("success", "Password updated successfully! You can now log in.");
			} else {
				// Query executed safely, but input parameters did not match any table records
				request.setAttribute("error", "Incorrect username or city location credential matches.");
			}

			request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Database operation failure: " + e.getMessage());
			request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
		}
	}
}
