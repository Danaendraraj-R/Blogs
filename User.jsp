<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>	
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>User Dashboard</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
    background-color: #f4f4f4;
}

.user-container {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    width: 500px;
    text-align: center;
}

h2 {
    color: #333;
}

#usernameDisplay {
    color: #4caf50;
}

.button-container {
    margin-top: 20px;
}

button {
    padding: 10px;
    margin: 5px;
    background-color: #4caf50;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button:hover {
    background-color: #45a049;
}
a {
    text-decoration: none;
    color: #fff;
}




    </style>
    
</head>
<body>
    <%
    // Retrieve values from the session
    String email = (String) session.getAttribute("email");
    String username = (String) session.getAttribute("username");

    if (email == null || username == null) {
        response.sendRedirect("Login.html");
    }
%>

    <div class="user-container">
        <h2>Welcome, <span id="usernameDisplay"><%= username %></span>!</h2>

        <div class="button-container">
            <button><a href="Viewblog.jsp">View Blog</a></button>
            <button><a href="AddBlog.jsp">Add Blog</a></button>
            <button><a href="Events.html">View Events</a></button>
            <form action="Logout" method="post" style="display:inline;">
                <button type="submit">Logout</button>
            </form>

        </div>
    </div>

    
</body>
</html>
