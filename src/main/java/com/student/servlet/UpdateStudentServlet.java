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

import com.student1.DBConnection;

@WebServlet("/UpdateStudentServlet")
public class UpdateStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 1. HANDLES GET REQUEST (When you click the "Update" button in the table)
	 * Fetches current data from the DB and forwards it to the update page.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			int id = Integer.parseInt(request.getParameter("id"));
			Connection con = DBConnection.getConnection();

			String query = "SELECT * FROM student WHERE id = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				// Pass the existing student record details to the update form page
				request.setAttribute("studentId", rs.getInt("id"));
				request.setAttribute("studentName", rs.getString("name"));
				request.setAttribute("javaMarks", rs.getInt("java_marks"));
				request.setAttribute("sqlMarks", rs.getInt("sql_marks"));
				request.setAttribute("dbmsMarks", rs.getInt("dbms_marks"));
				request.setAttribute("attendance", rs.getInt("attendance"));

				// Forward the request over to your editing form page
				request.getRequestDispatcher("updateStudent.jsp").forward(request, response);
			} else {
				response.getWriter().println("Student Record with ID " + id + " not found!");
			}

			rs.close();
			ps.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error fetching student details: " + e.getMessage());
		}
	}

	/**
	 * 2. HANDLES POST REQUEST (When you click "Submit/Save" inside
	 * updateStudent.jsp) Saves the modified numbers directly back to the database.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			int id = Integer.parseInt(request.getParameter("id"));
			int javaMarks = Integer.parseInt(request.getParameter("javaMarks"));
			int sqlMarks = Integer.parseInt(request.getParameter("sqlMarks"));
			int dbmsMarks = Integer.parseInt(request.getParameter("dbmsMarks"));
			int attendance = Integer.parseInt(request.getParameter("attendance"));

			Connection con = DBConnection.getConnection();

			String query = "UPDATE student SET java_marks=?, sql_marks=?, dbms_marks=?, attendance=? WHERE id=?";
			PreparedStatement ps = con.prepareStatement(query);

			ps.setInt(1, javaMarks);
			ps.setInt(2, sqlMarks);
			ps.setInt(3, dbmsMarks);
			ps.setInt(4, attendance);
			ps.setInt(5, id);

			int result = ps.executeUpdate();

			ps.close();
			con.close();

			if (result > 0) {
				// Instead of dashboard, redirect to your view page setup
				// (Change this to ViewStudentServlet if you have a servlet that populates the
				// table)
				response.sendRedirect("dashboard.jsp");
			} else {
				response.getWriter().println("Student ID Not Found!");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error saving student data: " + e.getMessage());
		}
	}
}
