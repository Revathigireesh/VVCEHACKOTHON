package Vedhaa;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;

@WebServlet("/MyProgressGraph")
public class MyProgressGraph extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/vedha2024";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "#Dhuvihegde26";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement fetchStmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Fetch UserID based on the email
            String fetchUserSql = "SELECT UserID FROM users WHERE Email = ?";
            fetchStmt = conn.prepareStatement(fetchUserSql);
            fetchStmt.setString(1, email);
            ResultSet rsUser = fetchStmt.executeQuery();

            if (rsUser.next()) {
                int userId = rsUser.getInt("UserID");

                // Fetch quiz scores for the user
                String fetchScoresSql = "SELECT Score, AttemptTime FROM quizscore WHERE UserID = ? ORDER BY AttemptTime ASC";
                fetchStmt = conn.prepareStatement(fetchScoresSql);
                fetchStmt.setInt(1, userId);
                ResultSet rsScores = fetchStmt.executeQuery();

                // Prepare JSON response
                StringBuilder json = new StringBuilder("[");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                while (rsScores.next()) {
                    int score = rsScores.getInt("Score");
                    String date = sdf.format(rsScores.getTimestamp("AttemptTime"));
                    json.append(String.format("{\"date\":\"%s\",\"score\":%d},", date, score));
                }
                if (json.charAt(json.length() - 1) == ',') {
                    json.setLength(json.length() - 1); // Remove trailing comma
                }
                json.append("]");
                out.print(json.toString());
            } else {
                out.print("[]");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
        } finally {
            try {
                if (fetchStmt != null) fetchStmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}