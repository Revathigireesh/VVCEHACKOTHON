package Vedhaa;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.*;
import java.sql.*;
import java.util.*;

@WebServlet("/ProjectUpload")
public class ProjectUpload extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Step 1: Get form data
        String projectName = request.getParameter("projectName");
        String projectDescription = request.getParameter("projectDescription");
        String technologiesUsed = request.getParameter("technologiesUsed");
        String accessLink = request.getParameter("accessLink");

        // Assume owner email is stored in session (logged-in user)
        HttpSession session = request.getSession();
        String ownerEmail = (String) session.getAttribute("email"); // Retrieve email from session

        if (ownerEmail == null) {
            // If the email is null, redirect to login page
            response.sendRedirect("Login.html");
            return;
        }

        // Step 2: Get the UserID from the database using the email
        int ownerID = -1;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        // Database connection variables (update these based on your DB credentials)
        String jdbcURL = "jdbc:mysql://localhost:3306/vedha2024";
        String dbUser = "root";
        String dbPassword = "#Dhuvihegde26";

        try {
            // Step 2.1: Establish DB connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Step 2.2: Get the UserID associated with the email
            String sqlGetUserID = "SELECT UserID FROM users WHERE Email = ?";
            stmt = conn.prepareStatement(sqlGetUserID);
            stmt.setString(1, ownerEmail);
            rs = stmt.executeQuery();

            if (rs.next()) {
                ownerID = rs.getInt("UserID");
            } else {
                // If user does not exist in the database, redirect to login
                response.sendRedirect("Login.html");
                return;
            }

            // Step 2.3: Insert project details into the Projects table
            String sql = "INSERT INTO Projects (Title, Description, AccessLink, OwnerID) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, projectName);
            stmt.setString(2, projectDescription);
            stmt.setString(3, accessLink);
            stmt.setInt(4, ownerID);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Step 3: Get the ProjectID generated for the newly inserted project
                rs = stmt.getGeneratedKeys();
                rs.next();
                int projectID = rs.getInt(1);

                // Step 4: Process the tech stacks
                String[] techStacks = technologiesUsed.split(","); // Split comma-separated list of tech stacks

                // Step 4.1: Insert tech stacks into the ProjectTechStacks table
                for (String tech : techStacks) {
                    tech = tech.trim(); // Remove any leading/trailing spaces
                    insertTechStack(conn, projectID, tech);
                }

                // Step 5: Redirect to a success page
                response.sendRedirect("projectSuccess.html"); // Redirect to a success page (create this page)

            } else {
                // If project insertion fails, show an error page
                response.sendRedirect("errorpro.html");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("errorpro.html");
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
                if (rs != null) rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Helper function to insert tech stack into the ProjectTechStacks table
    private void insertTechStack(Connection conn, int projectID, String techStackName) throws SQLException {
        // First, check if the tech stack exists in the TechStacks table
        String sqlCheckTechStack = "SELECT TechStackID FROM TechStacks WHERE TechStackName = ?";
        PreparedStatement stmtCheck = conn.prepareStatement(sqlCheckTechStack);
        stmtCheck.setString(1, techStackName);
        ResultSet rs = stmtCheck.executeQuery();

        int techStackID = -1;
        if (rs.next()) {
            techStackID = rs.getInt("TechStackID"); // Tech stack already exists
        } else {
            // Tech stack doesn't exist, insert it
            String sqlInsertTechStack = "INSERT INTO TechStacks (TechStackName) VALUES (?)";
            PreparedStatement stmtInsert = conn.prepareStatement(sqlInsertTechStack, Statement.RETURN_GENERATED_KEYS);
            stmtInsert.setString(1, techStackName);
            stmtInsert.executeUpdate();
            rs = stmtInsert.getGeneratedKeys();
            if (rs.next()) {
                techStackID = rs.getInt(1);
            }
        }

        // Insert into the ProjectTechStacks table
        String sqlInsertProjectTechStack = "INSERT INTO ProjectTechStacks (ProjectID, TechStackID) VALUES (?, ?)";
        PreparedStatement stmtInsertProjectTechStack = conn.prepareStatement(sqlInsertProjectTechStack);
        stmtInsertProjectTechStack.setInt(1, projectID);
        stmtInsertProjectTechStack.setInt(2, techStackID);
        stmtInsertProjectTechStack.executeUpdate();
    }
}
