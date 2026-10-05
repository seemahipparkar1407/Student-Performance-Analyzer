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

@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 1. HANDLES GET REQUESTS This runs when you click the trash icon link in your
	 * viewStudents table.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// 1. Get the student ID parameter
			String idParam = request.getParameter("id");
			if (idParam == null || idParam.trim().isEmpty()) {
				response.getWriter().println("Error: Student ID is missing!");
				return;
			}

			int id = Integer.parseInt(idParam.trim());

			// 2. Establish connection to your SQL database
			Connection con = DBConnection.getConnection();

			// 3. Prepare the DELETE SQL query
			String query = "DELETE FROM student WHERE id = ?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);

			// 4. Execute the deletion query
			int result = ps.executeUpdate();

			ps.close();
			con.close();

			if (result > 0) {
				// SUCCESS: Redirect back to your student list view servlet to refresh the table
				// instantly
				response.sendRedirect("viewStudentServlet");
			} else {
				response.getWriter().println("Student Record with ID " + id + " was not found in the database!");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error executing deletion operation: " + e.getMessage());
		}
	}

	/**
	 * 2. HANDLES POST REQUESTS This automatically runs when someone submits the
	 * form inside deleteStudent.jsp. It safely routes the request to doGet to use
	 * the exact same database deletion logic.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
