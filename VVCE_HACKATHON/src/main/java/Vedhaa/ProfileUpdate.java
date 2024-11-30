package Vedhaa;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class ProfileUpdate
 */
@WebServlet("/ProfileUpdatee")
public class ProfileUpdate extends HttpServlet {
	 private static final long serialVersionUID = 1L;

	    private static final String DB_URL = "jdbc:mysql://localhost:3306/vedha2024";
	    private static final String DB_USER = "root";
	    private static final String DB_PASSWORD = "#Dhuvihegde26";

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	        
	        // Get email from session
	        HttpSession session = request.getSession();
	        String email = (String) session.getAttribute("email"); // Email from login session

	        if (email == null) {
	            response.getWriter().println("Error: Please login again.");
	            return;
	        }

	        // Get updated profile details from the form
	        String firstName = request.getParameter("firstName");
	        String lastName = request.getParameter("lastName");
	        String phoneNumber = request.getParameter("phoneNumber");
	        String dob = request.getParameter("dob");
	        String bio = request.getParameter("bio");
	        String country = request.getParameter("country");

	        Connection conn = null;
	        PreparedStatement stmt = null;

	        try {
	            // Load MySQL driver
	            Class.forName("com.mysql.cj.jdbc.Driver");

	            // Connect to the database
	            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

	            // Prepare the SQL query to update the user's profile
	            String sql = "UPDATE Users SET FirstName = ?, LastName = ?, PhoneNumber = ?, DOB = ?, City = ?, Bio = ? WHERE Email = ?";
	            stmt = conn.prepareStatement(sql);
	            stmt.setString(1, firstName);
	            stmt.setString(2, lastName);
	            stmt.setString(3, phoneNumber);
	            stmt.setString(4, dob);
	            stmt.setString(5, country);
	            stmt.setString(6, bio);
	            stmt.setString(7, email);

	            // Execute the update query
	            int rowsUpdated = stmt.executeUpdate();

	            if (rowsUpdated > 0) {
	                response.getWriter().println("Profile updated successfully!");
	            } else {
	                response.getWriter().println("Failed to update profile. Please try again.");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().println("An error occurred: " + e.getMessage());
	        } finally {
	            // Close resources
	            try {
	                if (stmt != null) stmt.close();
	                if (conn != null) conn.close();
	            } catch (Exception ex) {
	                ex.printStackTrace();
	            }
	        }
	    }
	}
