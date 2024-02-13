<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Blog</title>
</head>
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
input[type=submit] {
    width: 60%;
    padding: 10px;
    background-color: #4caf50;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
input[type=text]
{
    width:380px;
}
a{
         text-decoration: none;
        color: #fff;
        }

</style>
<body>
    <h2>Edit Blog</h2>

    <form id="editBlogForm">
        <center>
        <table>
            <tr>
                <td> <label for="blogId">Blog ID:</label> </td>
                <td> <input type="text" id="blogId" name="blogId" readonly/> </td>
            </tr>
            <tr>
                <td> <label for="title">Title:</label> </td>
                <td> <input type="text" id="title" name="title" required /> </td>
            </tr>
            <tr>
                <td> <label for="content">Content:</label></td>
                <td>  <textarea id="content" name="content" rows="10" cols="50" required></textarea> </td>
            </tr>
        </table>
        <button type="button" onclick="update()">Update Blog</button>

        <button><a href="Viewblog.jsp"> Back </a></button>
        
    </center>

        
    </form>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
    <script>
        var blogData = <%= request.getAttribute("jsonBlog") %>;
        document.getElementById("blogId").value = blogData.blogId;
        document.getElementById("title").value = blogData.title;
        document.getElementById("content").value = blogData.content;
        function update() {
            var blogId = $("#blogId").val();
            var title = $("#title").val();
            var content = $("#content").val();
            var blogData = {
                blogId: blogId,
                title: title,
                content: content
            };
            $.ajax({
                type: "POST",
                url: "UpdateBlog",
                data: blogData,
                success: function () {
                    window.location.href = "Viewblog.jsp";
                },
                error: function (error) {
                 console.log(error);
                  alert("Error updating blog. Please try again.");
                }
            });
        }
    </script>
</body>
</html>
