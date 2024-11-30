package Vedhaa;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class Signup
 */
@WebServlet("/Signup")
public class Signup extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Query to insert email and password
    private static final String INSERT_QUERY = "INSERT INTO users(Email, PasswordHash) VALUES(?, ?)";
    private static final String CHECK_USER_QUERY = "SELECT * FROM users WHERE Email = ?";

    public Signup() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        // Get form parameters (email, password, and confirm password)
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate password confirmation
        if (!password.equals(confirmPassword)) {
            pw.println("<h3 style='color:red;'>Passwords do not match. Please try again.</h3>");
            request.getRequestDispatcher("Signup.html").include(request, response);
            return;
        }

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vedha2024", "root", "#Dhuvihegde26");
                    PreparedStatement psCheck = con.prepareStatement(CHECK_USER_QUERY);
                    PreparedStatement psInsert = con.prepareStatement(INSERT_QUERY)) {

                // Check if the email is already registered
                psCheck.setString(1, email);
                ResultSet rs = psCheck.executeQuery();
                if (rs.next()) {
                    pw.println("<h3 style='color:red;'>User already registered with this email.</h3>");
                    request.getRequestDispatcher("Signup.html").include(request, response);
                    return;
                }

                // Hash the password before storing it
                String hashedPassword = hashPassword(password);

                // Set email and hashed password to the insert query
                psInsert.setString(1, email);
                psInsert.setString(2, hashedPassword);

                // Execute the insert query
                int rowsInserted = psInsert.executeUpdate();
                if (rowsInserted > 0) {
                    // Optional: Automatically log the user in by creating a session
                    HttpSession session = request.getSession();
                    session.setAttribute("email", email);
                    session.setMaxInactiveInterval(30 * 60); // Set session timeout (30 minutes)

                    pw.println("<h3 style='color:green;'>User registered successfully!</h3>");
                    response.sendRedirect("Profilesettings.html");
                } else {
                    pw.println("<h3 style='color:red;'>Error: Unable to register user.</h3>");
                }

            } catch (SQLException e) {
                e.printStackTrace();
                pw.println("<h3 style='color:red;'>Database error: " + e.getMessage() + "</h3>");
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            pw.println("<h3 style='color:red;'>JDBC Driver not found: " + e.getMessage() + "</h3>");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            pw.println("<h3 style='color:red;'>Error while hashing password: " + e.getMessage() + "</h3>");
        }
    }

    // Method to hash the password using SHA-256
    private String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(password.getBytes());
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            hexString.append(String.format("%02x", b));
        }
        return hexString.toString();
    }
}