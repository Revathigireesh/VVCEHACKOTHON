package Vedhaa;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/FetchYourProjects")
public class FetchYourProjects extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/vedha2024";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "#Dhuvihegde26";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect("Login.html");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        List<Map<String, Object>> projects = new ArrayList<>();

        try {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Fetch the projects of the user based on email
            String sql ="SELECT p.ProjectID, p.Title, " +
                    "GROUP_CONCAT(DISTINCT t.TechStackName ORDER BY t.TechStackName SEPARATOR ', ') AS TechStacks " +
                    "FROM Projects p " +
                    "JOIN ProjectTechStacks pt ON p.ProjectID = pt.ProjectID " +
                    "JOIN TechStacks t ON pt.TechStackID = t.TechStackID " +
                    "JOIN Users u ON p.OwnerID = u.UserID " +
                    "WHERE u.Email = ? " +
                    "GROUP BY p.ProjectID, p.Title";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> project = new HashMap<>();
                project.put("projectID", rs.getInt("ProjectID"));
                project.put("title", rs.getString("Title"));
                project.put("techStacks", rs.getString("TechStacks"));
                projects.add(project);
            }

            request.setAttribute("projects", projects);
            request.getRequestDispatcher("userProjects.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("errorpro.html");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
