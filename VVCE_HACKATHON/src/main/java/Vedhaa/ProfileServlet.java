package Vedhaa;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;

	    private static final String DB_URL = "jdbc:mysql://localhost:3306/vedha2024";
	    private static final String DB_USER = "root";
	    private static final String DB_PASSWORD = "#Dhuvihegde26";

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	        
	        // Get email from session
	        HttpSession session = request.getSession();
	        String email = (String) session.getAttribute("email"); // Email from login session

	        // Get other form parameters
	        String firstName = request.getParameter("firstName");
	        String lastName = request.getParameter("lastName");
	        String phoneNumber = request.getParameter("phoneNumber");
	        String dob = request.getParameter("dob");
	        String bio = request.getParameter("bio");
	        String country = request.getParameter("country");

	        Connection conn = null;
	        PreparedStatement fetchStmt = null;
	        PreparedStatement updateStmt = null;

	        try {
	            // Load the MySQL driver
	            Class.forName("com.mysql.cj.jdbc.Driver");

	            // Connect to the database
	            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

	            // Step 1: Fetch UserID based on the email
	            String fetchSql = "SELECT UserID FROM users WHERE Email = ?";
	            fetchStmt = conn.prepareStatement(fetchSql);
	            fetchStmt.setString(1, email);

	            ResultSet rs = fetchStmt.executeQuery();

	            if (rs.next()) {
	                int userId = rs.getInt("UserID");

	                // Step 2: Update user details using the UserID
	                String updateSql = "UPDATE Users SET FirstName = ?, LastName = ?, PhoneNumber = ?, DOB = ?, City = ?, Bio = ? WHERE UserID = ?";
	                updateStmt = conn.prepareStatement(updateSql);
	                updateStmt.setString(1, firstName);
	                updateStmt.setString(2, lastName);
	                updateStmt.setString(3, phoneNumber);
	                updateStmt.setString(4, dob);
	                updateStmt.setString(5, country);
	                updateStmt.setString(6, bio);
	                updateStmt.setInt(7, userId);

	                int rowsUpdated = updateStmt.executeUpdate();

	                if (rowsUpdated > 0) {
	                    response.sendRedirect("Dashboard.jsp");
	                } else {
	                    response.getWriter().println("Failed to update profile.");
	                }
	            } else {
	                response.getWriter().println("User not found. Please login again.");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().println("An error occurred: " + e.getMessage());
	        } finally {
	            // Close resources
	            try {
	                if (fetchStmt != null) fetchStmt.close();
	                if (updateStmt != null) updateStmt.close();
	                if (conn != null) conn.close();
	            } catch (Exception ex) {
	                ex.printStackTrace();
	            }
	        }
	    }
	}

