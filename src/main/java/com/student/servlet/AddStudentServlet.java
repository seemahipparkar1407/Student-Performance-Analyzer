package com.student.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import com.student1.DBConnection;

@WebServlet("/AddStudentServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB cache boundary
		maxFileSize = 1024 * 1024 * 10, // 10MB maximum single file limit
		maxRequestSize = 1024 * 1024 * 50 // 50MB maximum total request size limit
)
public class AddStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// 1. Gather all individual parameters from the HTML form elements
			int id = Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			int javaMarks = Integer.parseInt(request.getParameter("javaMarks"));
			int sqlMarks = Integer.parseInt(request.getParameter("sqlMarks"));
			int dbmsMarks = Integer.parseInt(request.getParameter("dbmsMarks"));
			int attendance = Integer.parseInt(request.getParameter("attendance"));

			// 2. Fetch the multi-part file bytes from the file choice box
			Part filePart = request.getPart("studentPhoto");
			String fileName = "default-avatar.png"; // Fallback name if no file is selected

			if (filePart != null && filePart.getSize() > 0) {
				String submittedFileName = filePart.getSubmittedFileName();

				// Extract file extension safely (e.g., john.jpg -> .jpg)
				String fileExtension = "";
				if (submittedFileName.contains(".")) {
					fileExtension = submittedFileName.substring(submittedFileName.lastIndexOf("."));
				} else {
					fileExtension = ".jpg";
				}

				// Create a clean filename using the unique student ID to prevent matching file
				// collisions
				fileName = "student_" + id + fileExtension;

				// Dynamically look up your deployed app runtime target directory inside Tomcat
				String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

				// Create the 'uploads' directory folder on disk storage if missing
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdir();
				}

				// Permanently write the uploaded data to your disk
				filePart.write(uploadPath + File.separator + fileName);
			}

			// 3. Database connection and explicit column insertion query configuration
			Connection con = DBConnection.getConnection();

			// Explicitly mentioning your DB column targets ensures query security and
			// stability
			String query = "INSERT INTO student (id, name, java_marks, sql_marks, dbms_marks, attendance, photo_path) VALUES (?, ?, ?, ?, ?, ?, ?)";

			PreparedStatement ps = con.prepareStatement(query);

			ps.setInt(1, id);
			ps.setString(2, name);
			ps.setInt(3, javaMarks);
			ps.setInt(4, sqlMarks);
			ps.setInt(5, dbmsMarks);
			ps.setInt(6, attendance);
			ps.setString(7, fileName); // Stores file mapping identifier string safely

			int result = ps.executeUpdate();

			ps.close();
			con.close();

			if (result > 0) {
				// Redirect back to your servlet to display the clean view student table
				response.sendRedirect("viewStudentServlet");
			} else {
				response.getWriter().println("Failed to insert student record.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error inside AddStudentServlet: " + e.getMessage());
		}
	}
}
