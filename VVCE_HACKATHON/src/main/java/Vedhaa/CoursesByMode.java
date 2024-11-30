package Vedhaa;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class CoursesByMode
 */
@WebServlet("/CoursesByMode")
public class CoursesByMode extends HttpServlet {
	private static final String DB_URL = "jdbc:mysql://localhost:3306/vedha2024";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "#Dhuvihegde26";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Fetch the mode parameter (e.g., "Video", "CheatSheet", etc.)
        String mode = request.getParameter("mode");
        
        if (mode == null || mode.isEmpty()) {
            mode = "Video"; // Default mode is Video if none is provided
        }

        // Start HTML output
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Query to fetch courses based on the mode
            String query = "SELECT c.CourseID, c.CourseName, c.Description, c.ThumbnailLink, " +
                           "r.ResourceType, r.Title, r.ResourceLink " +
                           "FROM Courses c " +
                           "JOIN LearningResources r ON c.CourseID = r.CourseID " +
                           "WHERE r.ResourceType = ?"; // Filter by resource type (mode)
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, mode); // Set the mode (Video, CheatSheet, etc.)
                ResultSet rs = stmt.executeQuery();

                // Start HTML response
                out.println("<html><head><title>Courses by Mode: " + mode + "</title>");
                out.println("<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css'>");
                out.println("<style>.course-card { border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); padding: 20px; text-align: center; transition: transform 0.3s ease, box-shadow 0.3s ease; }</style>");
                out.println("</head><body>");
                out.println("<div class='container'><h3>Courses - " + mode + " Resources</h3>");
                out.println("<div class='row'>");

                // Loop through the results and display each course
                while (rs.next()) {
                    int courseId = rs.getInt("CourseID");
                    String courseName = rs.getString("CourseName");
                    String description = rs.getString("Description");
                    String thumbnailLink = rs.getString("ThumbnailLink");
                    String resourceType = rs.getString("ResourceType");
                    String resourceTitle = rs.getString("Title");
                    String resourceLink = rs.getString("ResourceLink");

                    out.println("<div class='col-md-4 mb-4'>");
                    out.println("<div class='course-card'>");
                    out.println("<h5>" + courseName + "</h5>");
                    

                    // If the resource type is video, display it as an embedded YouTube video
                    if (resourceType.equals("Video")) {
                        String embedURL = resourceLink.replace("youtube.com/watch?v=", "youtube.com/embed/");
                        out.println("<iframe width='100%' height='315' src='" + embedURL + "' frameborder='0' allowfullscreen></iframe>");
                    } else {
                        // Display other resources (cheat sheet, document, etc.) as links
                        out.println("<a href='" + resourceLink + "' class='btn btn-primary mt-2' target='_blank'>" + resourceTitle + "</a>");
                    }
                    out.println("</div></div>");
                }

                out.println("</div></div>");
                out.println("</body></html>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error fetching data: " + e.getMessage());
        }
    }
}

