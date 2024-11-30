<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project List</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: rgb(230, 230, 250);
        }
        .container {
            margin-top: 30px;
        }
        .table {
            background-color: #ffffff;
        }
        th, td {
            padding: 10px;
        }
        th {
            background-color: #343a40;
            color: white;
        }
        .btn-link {
            color: #007bff;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" id="searchInput" placeholder="Search by Title" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="button" onclick="searchTable()">Search</button>
            </form>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="card">
        <table class="table table-bordered align-middle mb-0 bg-white" id="projectsTable">
            <thead class="bg-light">
            <tr>
                <th>Project ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Access Link</th>
                <th>Owner Name</th>
            </tr>
            </thead>
            <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/vedha2024", "root", "#Dhuvihegde26");
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery(
                        "SELECT p.ProjectID, p.Title, p.Description, p.AccessLink, " +
                        "CONCAT(u.FirstName, ' ', u.LastName) AS OwnerName " +
                        "FROM Projects p " +
                        "LEFT JOIN Users u ON p.OwnerID = u.UserID");

                    while (rs.next()) { 
            %>
            <tr>
                <td><%= rs.getInt("ProjectID") %></td>
                <td><%= rs.getString("Title") %></td>
                <td><%= rs.getString("Description") %></td>
                <td>
                    <a href="<%= rs.getString("AccessLink") %>" target="_blank">View</a>
                </td>
                <td><%= rs.getString("OwnerName") != null ? rs.getString("OwnerName") : "Unknown" %></td>
            </tr>
            <% 
                    }
                    rs.close();
                    st.close();
                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function searchTable() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("projectsTable");
        tr = table.getElementsByTagName("tr");

        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[1]; // Index 1 corresponds to the Title column
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }

        if (filter === "") {
            for (i = 0; i < tr.length; i++) {
                tr[i].style.display = "";
            }
        }
    }
    document.getElementById("searchInput").addEventListener("input", searchTable);
</script>
</body>
</html>
