<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #E8F5E9;
        }
        header {
            background-color: #29b313;
            color: #ecf0f1;
            padding: 1rem;
            text-align: center;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }
        body {
            padding-top: 70px;
        }
        .container {
            width: 60%;
            background-color: #ffffff;
            padding: 35px;
            border-radius: 10px;
            position: relative;
            top: 60px;
            left: 50%;
            transform: translateX(-50%);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 30px;
        }
        .detail-box {
            width: 90%;
            max-width: 500px;
            background-color: #E8F5E9;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-sizing: border-box;
            font-size: 16px;
            box-shadow: 4px 4px 6px rgba(0, 0, 0, 0.2);
        }
        .detail-box h3 {
            margin: 0 0 10px;
            color: #333;
        }
        .detail-box p {
            margin: 0;
            color: #555;
        }
        .button {
            background-color: #29b313;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            display: block;
            margin: 20px auto;
        }
        .button:hover {
            background-color: #248f11;
        }
        @media (max-width: 768px) {
            .container {
                width: 80%;
            }
            .detail-box {
                font-size: 14px;
            }
            .button {
                font-size: 14px;
                padding: 8px 16px;
            }
        }
        @media (max-width: 480px) {
            header {
                font-size: 18px;
                padding: 0.5rem;
            }
            .container {
                top: 20px;
                padding: 15px;
            }
            .detail-box {
                font-size: 12px;
            }
            .button {
                font-size: 12px;
                padding: 6px 12px;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>Project Details</h1>
    </header>
    <div class="container">
        <%
            String projectId = request.getParameter("projectId");
            if (projectId != null && !projectId.isEmpty()) {
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    String dbURL = "jdbc:mysql://localhost:3306/vedha2024";
                    String dbUser = "root";
                    String dbPassword = "#Dhuvihegde26";

                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                    String sql = "SELECT p.Title AS ProjectName, p.Description AS ProjectDescription, " +
                                 "p.AccessLink AS AccessLink, " +
                                 "GROUP_CONCAT(DISTINCT t.TechStackName ORDER BY t.TechStackName SEPARATOR ', ') AS TechnologiesUsed " +
                                 "FROM Projects p " +
                                 "LEFT JOIN ProjectTechStacks pt ON p.ProjectID = pt.ProjectID " +
                                 "LEFT JOIN TechStacks t ON pt.TechStackID = t.TechStackID " +
                                 "WHERE p.ProjectID = ? " +
                                 "GROUP BY p.ProjectID";

                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, projectId);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        String projectName = rs.getString("ProjectName");
                        String projectDescription = rs.getString("ProjectDescription");
                        String accessLink = rs.getString("AccessLink");
                        String technologiesUsed = rs.getString("TechnologiesUsed");
        %>
        <div class="detail-box">
            <h3>Project Name</h3>
            <p><%= projectName %></p>
        </div>
        <div class="detail-box">
            <h3>Description</h3>
            <p><%= projectDescription %></p>
        </div>
        <div class="detail-box">
            <h3>Technologies Used</h3>
            <p><%= technologiesUsed %></p>
        </div>
        <div class="detail-box">
            <h3>Access Link</h3>
            <a href="<%= accessLink %>" target="_blank"><%= accessLink %></a>
        </div>
        <%
                    } else {
        %>
        <h2 style="color: red;">Project not found.</h2>
        <%
                    }
                } catch (SQLException e) {
                    out.println("<h2 style='color: red;'>Error retrieving project details.</h2>");
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
        %>
        <h2 style="color: red;">Invalid Project ID.</h2>
        <%
            }
        %>
        <button class="button" onclick="window.location.href='projectcollaboration.html';">Back to Projects</button>
    </div>
</body>
</html>
