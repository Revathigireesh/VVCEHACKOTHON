<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List, java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Projects</title>
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ccc;
        }
        th {
            background-color: #f4f4f4;
        }
        a {
            text-decoration: none;
            color: #fff;
        }
        button {
            background-color: #007bff;
            border: none;
            padding: 8px 12px;
            color: white;
            cursor: pointer;
            border-radius: 4px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1 style="text-align:center;">Your Projects</h1>
    <table>
        <thead>
            <tr>
                <th>Project Name</th>
                <th>Tech Stacks</th>
                <th>Details</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Map<String, Object>> projects = (List<Map<String, Object>>) request.getAttribute("projects");
                if (projects != null && !projects.isEmpty()) {
                    for (Map<String, Object> project : projects) {
                        String title = (String) project.get("title");
                        String techStacks = (String) project.get("techStacks");
                        int projectID = (Integer) project.get("projectID");
            %>
                        <tr>
                            <td><%= title %></td>
                            <td><%= techStacks %></td>
                            <td>
                                <a href="ProjectDetails?projectId=<%= projectID %>">
                                    <button>View Details</button>
                                </a>
                            </td>
                        </tr>
            <% 
                    }
                } else {
            %>
                    <tr>
                        <td colspan="3" style="text-align:center;">No projects found</td>
                    </tr>
            <% 
                }
            %>
        </tbody>
    </table>
</body>
</html>
