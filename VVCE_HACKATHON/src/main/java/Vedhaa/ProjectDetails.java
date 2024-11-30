package Vedhaa;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/ProjectDetails")
public class ProjectDetails extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/vedha2024";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "#Dhuvihegde26";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String projectIdStr = request.getParameter("projectId");
        if (projectIdStr == null || projectIdStr.isEmpty()) {
            response.sendRedirect("errorpro.html");
            return;
        }

        try {
            int projectId = Integer.parseInt(projectIdStr);

            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "SELECT Title, Description, AccessLink " +
                         "FROM Projects WHERE ProjectID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, projectId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                request.setAttribute("title", rs.getString("Title"));
                request.setAttribute("description", rs.getString("Description"));
                request.setAttribute("accessLink", rs.getString("AccessLink"));
            } else {
                request.setAttribute("error", "Project not found");
            }

            rs.close();
            stmt.close();
            conn.close();

            request.getRequestDispatcher("projectDetails.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorpro.html");
        }
    }
}
