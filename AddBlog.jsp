<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <title>Add Blog</title>
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
a{
    text-decoration: none;
    color: #fff;
}

button:hover {
    background-color: #45a049;
}
input[type=submit] {
    width: 60%;
    padding: 10px;
    background-color: #4caf50;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

    </style>

</head>
<body>
    <%
    String email = (String) session.getAttribute("email");
    String username = (String) session.getAttribute("username");

    if (email == null || username == null) {
        response.sendRedirect("Login.html");
    }
%>
    <div class="user-container">
       <h2>Welcome, <span id="usernameDisplay"><%= username %></span>!</h2>
       <h2> Add Blog</h2>
        <div id="addBlogForm" style="display: block;">
            <center>
            <form method="post" action="AddBlog">
            <table>
                <tr>
                    <td><label for="AuthorName">Author Name:</label></td>
                    <td> <input type="text" name="authorname" id="AuthorName"  value=<%=username%>  readonly required></td>
                </tr>  
                <tr>
                    <td><label for="AuthorEmail">Author Email:</label></td>
                    <td> <input type="text" name="authoremail" id="AuthorEmail"  value=<%=email%> readonly required></td>
                </tr>  
                
            <tr>
                <td><label for="blogTitle">Title:</label></td>
                <td> <input type="text" id="blogTitle" name="blogtitle" required></td>
            </tr>
            <tr>
                <td><label for="blogContent">Content:</label> </td>
                <td> <textarea id="blogContent" rows="10" cols="30" name="blogcontent" required></textarea> </td>
            </tr>  
             
            </table>
            
                <input type="submit" value="Save Blog">
            </form>

            <button><a href="Viewblog.jsp"> Back </a></button>
            <div id="result"></div>
        </center>
        </div>
    </div>
</body>
</html>
