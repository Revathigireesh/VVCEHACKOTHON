package Vedhaa;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/Feedback")
public class Feedback extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database configuration
    private static final String DB_URL = "jdbc:mysql://localhost:3306/vedha2024";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "#Dhuvihegde26";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get session and retrieve the logged-in email
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            out.println("<div class='error'>You must be logged in to submit feedback!</div>");
            return;
        }

        // Get feedback details from the request
        String feedbackText = request.getParameter("feedback");
        String ratingStr = request.getParameter("rating");

        if (feedbackText == null || ratingStr == null) {
            out.println("<div class='error'>All fields are required!</div>");
            return;
        }

        try {
            int rating = Integer.parseInt(ratingStr);

            // Fetch UserID from the database using the email
            int userId = getUserIdByEmail(email);

            if (userId == -1) {
                out.println("<div class='error'>User not found!</div>");
                return;
            }

            // Insert feedback into the database
            String sql = "INSERT INTO Feedback (UserID, FeedbackText, Rating) VALUES (?, ?, ?)";
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

                preparedStatement.setInt(1, userId);
                preparedStatement.setString(2, feedbackText);
                preparedStatement.setInt(3, rating);

                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<div class='success'>Feedback submitted successfully!</div>");
                } else {
                    out.println("<div class='error'>Failed to submit feedback. Please try again.</div>");
                }
            }
        } catch (NumberFormatException e) {
            out.println("<div class='error'>Invalid input. Please ensure all fields are filled correctly.</div>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<div class='error'>Database error: " + e.getMessage() + "</div>");
        }
    }

    // Method to fetch UserID from the database using email
    private int getUserIdByEmail(String email) {
        String sql = "SELECT UserID FROM Users WHERE Email = ?";
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, email);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt("UserID");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if UserID is not found
    }
}
