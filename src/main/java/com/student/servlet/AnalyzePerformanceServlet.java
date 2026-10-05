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

@WebServlet("/AnalyzePerformanceServlet")
public class AnalyzePerformanceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			int id = Integer.parseInt(request.getParameter("id"));

			Connection con = DBConnection.getConnection();
			String query = "SELECT * FROM student WHERE id=?";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				String name = rs.getString("name");
				int javaMarks = rs.getInt("java_marks");
				int sqlMarks = rs.getInt("sql_marks");
				int dbmsMarks = rs.getInt("dbms_marks");
				int attendance = rs.getInt("attendance");

				// Pull photo string token directly from table
				String dbPhoto = rs.getString("photo_path");
				String photoPath;

				if (dbPhoto == null || dbPhoto.trim().isEmpty() || dbPhoto.equals("default-avatar.png")) {
					photoPath = "images/default-avatar.png";
				} else {
					photoPath = "uploads/" + dbPhoto;
				}

				int total = javaMarks + sqlMarks + dbmsMarks;
				double percentage = total / 3.0;

				String grade;
				if (percentage >= 90) {
					grade = "A+";
				} else if (percentage >= 80) {
					grade = "A";
				} else if (percentage >= 70) {
					grade = "B";
				} else if (percentage >= 60) {
					grade = "C";
				} else {
					grade = "Fail";
				}

				String weakSubject;
				int lowest = Math.min(javaMarks, Math.min(sqlMarks, dbmsMarks));

				if (lowest == javaMarks) {
					weakSubject = "Java";
				} else if (lowest == sqlMarks) {
					weakSubject = "SQL";
				} else {
					weakSubject = "DBMS";
				}

				// Injecting variables into the request state wrapper scope maps
				request.setAttribute("id", id);
				request.setAttribute("name", name);
				request.setAttribute("javaMarks", javaMarks);
				request.setAttribute("sqlMarks", sqlMarks);
				request.setAttribute("dbmsMarks", dbmsMarks);
				request.setAttribute("attendance", attendance);
				request.setAttribute("total", total);
				request.setAttribute("percentage", percentage);
				request.setAttribute("grade", grade);
				request.setAttribute("weakSubject", weakSubject);
				request.setAttribute("photoPath", photoPath);

				// FORCING REDIRECTION TO THE NEW FILENAME TO BYPASS CACHE GLITCHES
				request.getRequestDispatcher("performanceResult.jsp").forward(request, response);

			} else {
				response.getWriter().println("Student Not Found!");
			}

			rs.close();
			ps.close();
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Server Execution Fault: " + e.getMessage());
		}
	}
}
