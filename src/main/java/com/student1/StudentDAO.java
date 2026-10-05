package com.student1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

public class StudentDAO {

	Connection con = DBConnection.getConnection();
	Scanner sc = new Scanner(System.in);

	// Add Student
	public void addStudent() {

		try {

			System.out.print("Enter ID: ");
			int id = sc.nextInt();
			sc.nextLine();

			System.out.print("Enter Name: ");
			String name = sc.nextLine();

			System.out.print("Enter Java Marks: ");
			int javaMarks = sc.nextInt();

			System.out.print("Enter SQL Marks: ");
			int sqlMarks = sc.nextInt();

			System.out.print("Enter DBMS Marks: ");
			int dbmsMarks = sc.nextInt();

			System.out.print("Enter Attendance: ");
			int attendance = sc.nextInt();

			String sql = "INSERT INTO student VALUES(?,?,?,?,?,?)";

			PreparedStatement ps = con.prepareStatement(sql);

			ps.setInt(1, id);
			ps.setString(2, name);
			ps.setInt(3, javaMarks);
			ps.setInt(4, sqlMarks);
			ps.setInt(5, dbmsMarks);
			ps.setInt(6, attendance);

			int rows = ps.executeUpdate();

			if (rows > 0) {
				System.out.println("Student Added Successfully!");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// View All Students
	public void viewStudents() {

		try {

			String sql = "SELECT * FROM student";

			PreparedStatement ps = con.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			System.out.println("\n===============================");
			System.out.println("      STUDENT DETAILS");
			System.out.println("===============================");

			while (rs.next()) {

				System.out.println("ID          : " + rs.getInt("id"));
				System.out.println("Name        : " + rs.getString("name"));
				System.out.println("Java Marks  : " + rs.getInt("java_marks"));
				System.out.println("SQL Marks   : " + rs.getInt("sql_marks"));
				System.out.println("DBMS Marks  : " + rs.getInt("dbms_marks"));
				System.out.println("Attendance  : " + rs.getInt("attendance"));
				System.out.println("-------------------------------");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// Method 3
	public void updateStudent() {

		try {

			System.out.print("Enter Student ID to Update: ");
			int id = sc.nextInt();

			System.out.print("Enter New Java Marks: ");
			int java = sc.nextInt();

			System.out.print("Enter New SQL Marks: ");
			int sql = sc.nextInt();

			System.out.print("Enter New DBMS Marks: ");
			int dbms = sc.nextInt();

			System.out.print("Enter New Attendance: ");
			int attendance = sc.nextInt();

			String query = "UPDATE student SET java_marks=?, sql_marks=?, dbms_marks=?, attendance=? WHERE id=?";

			PreparedStatement ps = con.prepareStatement(query);

			ps.setInt(1, java);
			ps.setInt(2, sql);
			ps.setInt(3, dbms);
			ps.setInt(4, attendance);
			ps.setInt(5, id);

			int result = ps.executeUpdate();

			if (result > 0) {
				System.out.println("Student Updated Successfully!");
			} else {
				System.out.println("Student ID Not Found!");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// Method 4
	public void deleteStudent() {

		try {

			System.out.print("Enter Student ID to Delete: ");
			int id = sc.nextInt();

			String query = "DELETE FROM student WHERE id=?";

			PreparedStatement ps = con.prepareStatement(query);

			ps.setInt(1, id);

			int result = ps.executeUpdate();

			if (result > 0) {
				System.out.println("Student Deleted Successfully!");
			} else {
				System.out.println("Student ID Not Found!");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// Method 5
	public void analyzePerformance() {

		try {

			System.out.print("Enter Student ID : ");
			int id = sc.nextInt();

			String query = "SELECT * FROM student WHERE id=?";

			PreparedStatement ps = con.prepareStatement(query);

			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {

				int java = rs.getInt("java_marks");
				int sql = rs.getInt("sql_marks");
				int dbms = rs.getInt("dbms_marks");
				int attendance = rs.getInt("attendance");

				int total = java + sql + dbms;
				double percentage = total / 3.0;

				String grade;

				if (percentage >= 90)
					grade = "A+";
				else if (percentage >= 80)
					grade = "A";
				else if (percentage >= 70)
					grade = "B";
				else if (percentage >= 60)
					grade = "C";
				else
					grade = "Fail";

				System.out.println("\n========== PERFORMANCE REPORT ==========");
				System.out.println("ID          : " + rs.getInt("id"));
				System.out.println("Name        : " + rs.getString("name"));
				System.out.println("Java Marks  : " + java);
				System.out.println("SQL Marks   : " + sql);
				System.out.println("DBMS Marks  : " + dbms);
				System.out.println("Attendance  : " + attendance + "%");
				System.out.println("Total Marks : " + total);
				System.out.println("Percentage  : " + percentage);
				System.out.println("Grade       : " + grade);

				int lowest = Math.min(java, Math.min(sql, dbms));

				if (lowest == java)
					System.out.println("Weak Subject : Java");
				else if (lowest == sql)
					System.out.println("Weak Subject : SQL");
				else
					System.out.println("Weak Subject : DBMS");

			} else {

				System.out.println("Student Not Found!");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
