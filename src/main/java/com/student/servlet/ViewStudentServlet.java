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

@WebServlet("/viewStudentServlet")
public class ViewStudentServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			Connection con = DBConnection.getConnection();

			String query = "SELECT * FROM student";

			PreparedStatement ps = con.prepareStatement(query);

			ResultSet rs = ps.executeQuery();

			request.setAttribute("studentResult", rs);

			request.getRequestDispatcher("viewStudent.jsp").forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();
			response.getWriter().println("Error: " + e.getMessage());

		}
	}
}