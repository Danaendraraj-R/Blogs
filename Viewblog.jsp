<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Blogs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #beebfc;
        }

        .blog-container {
            margin-left: 50px;
            margin-right: 50px;
            margin-top: 50px;
        
        }

        .blog {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        h3 {
            color: #333;
        }

        p {
            color: #555;
        }

        .button-container {
            margin-top: 10px;
        }

        button {
            padding: 5px 10px;
            margin-right: 10px;
            cursor: pointer;
        }

        .update-button {
            background-color: #4caf50;
            color: #fff;
            border: none;
            border-radius: 4px;
        }

        .delete-button {
            background-color: #f44336;
            color: #fff;
            border: none;
            border-radius: 4px;
        }

        .mobile-container {
  max-width: 480px;
  margin: auto;
    background-color: #1d1c47; 
  height: 500px;
  color: white;
  border-radius: 10px;
}

.topnav {
  overflow: hidden;
  background-color: #1d1c47;
  position: relative;
}

.topnav #myLinks {
  display: none;
}

.topnav a , input[type=submit]{
  color: white;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  display: block;
}

input[type=submit]{
    background-color: #1d1c47; 
    color: white; 
    border: none;
    border-radius: 4px;
    cursor: pointer;
    width:100%;
    text-align: left;
}

.topnav a.icon {
  background: #1d1c47;
  display: block;
  position: absolute;
  right: 0;
  top: 0;
}


.active {
  background-color: #04AA6D;
  color: white;
}

.blog1 {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 20px;
    overflow-y: auto; /* Add scrollbar if the content exceeds the container height */
    max-height: 200px; /* Set a maximum height for the blog, adjust as needed */
}

.comment-section {
    margin-top: 20px;
    overflow-y: auto; /* Add scrollbar if the content exceeds the container height */
    max-height: 150px; /* Set a maximum height for the comment section, adjust as needed */
}

.comment-section textarea {
    resize: vertical; /* Allow vertical resizing of the textarea */
}

    </style>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
<div class="topnav">
    <a href="Viewblog.jsp" active">Welcome, <span id="usernameDisplay"><%= username %></span></a>
    <div id="myLinks">
      <a href="AddBlog.jsp">Add Blog</a>
      <a href="Events.html">View Events</a>
      <form action="Logout" method="post"> 
        <input type="submit" value="Logout">
      </form>
    </div>
    <a href="javascript:void(0);" class="icon" onclick="myFunction()">
      <i class="fa fa-bars"></i>
    </a>
  </div>
    <div id="blogContainer" class="blog-container"></div>

    <script>
        $(document).ready(function () {
            $.ajax({
                type: "GET",
                url: "ViewBlog", 
                dataType: "json",
                success: function (data) {
                    displayBlogData(data);
                },
                error: function (error) {
                    console.log("Error:", error);
                }
            });

            function displayBlogData(data) {
                var blogContainer = $("#blogContainer");

                blogContainer.empty();
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        var blog = data[i];
                        var blogEntry = $("<div class='blog'>" + "<div class='blog1'>" +
                            "<h3>" + blog.title + "</h3>" +
                            "<p><strong>Blog ID:</strong> " + blog.blogId + "<br>" +
                            "<strong>Author:</strong> " + blog.author + "<br>" +
                            "<strong>Email:</strong> " + blog.email + "<br>" +
                            "<strong>Content:</strong> " + blog.content + "</p>" + "</div>" +
                            "<div class='button-container'>" +
                            (blog.email === '<%= session.getAttribute("email") %>' ?
                                "<button class='update-button' onclick='updateBlog(" + blog.blogId + ")'>Update</button>" +
                                "<button class='delete-button' onclick='deleteBlog(" + blog.blogId + ")'>Delete</button>" : "") +
                            "</div>" +
                            "<div class='comment-section'>" +
                            "<h4>Comments:</h4>" +
                            "<div id='commentsForBlog" + blog.blogId + "'></div>" +
                            "<form id='commentForm" + blog.blogId + "' onsubmit='addComment(" + blog.blogId + ");'>" +

                            "<textarea rows='3' cols='50' id='commentText" + blog.blogId + "' required></textarea>" +
                            "<br>" +
                            "<button type='submit'>Add Comment</button>" +
                            "</form>" +
                            "</div>" +
                            "</div>");
                        blogContainer.append(blogEntry);

                        loadComments(blog.blogId);
                    }
                } else {
                    blogContainer.append("<p>No blogs found.</p>");
                }
            }






        });

        function updateBlog(blogId) {
            window.location.href = "EditBlog?blogId=" + blogId;
        }

        function deleteBlog(blogId) {

            var isConfirmed = confirm("Are you sure you want to delete this blog?");

            $.ajax({
                type: "GET",
                url: "DeleteBlog?blogId=" + blogId,
                success: function () {
                    location.reload();
                },
                error: function (error) {
                    console.log("Error:", error);
                }
            });

        }
 function loadComments(blogId) {
    $.ajax({
        type: "GET",
        url: "LoadComment?blogId=" + blogId,
        dataType: "json",
        success: function (comments) {
            var commentsContainer = $("#commentsForBlog" + blogId);
            commentsContainer.empty();

            if (comments.length > 0) {
                for (var j = 0; j < comments.length; j++) {
                    var comment = comments[j];
                    var commentEntry = $("<p>" + comment.text + "</p>");
                    commentsContainer.append(commentEntry);
                }
            } else {
                commentsContainer.append("<p>No comments yet.</p>");
            }
        },
        
        error: function (xhr, status, error) {
            console.log("Error loading comments:", xhr.responseText);
            console.log("Status:", status);
            console.log("Error:", error);
        }
    });
}


function addComment(blogId) {
    var commentText = $("#commentText" + blogId).val();
    var username = '<%= session.getAttribute("username") %>';

    $.ajax({
        type: "POST",
        url: "AddComment",
        data: { blogId: blogId, username: username, text: commentText },
        success: function () {
            loadComments(blogId);
        },
        error: function (error) {
            console.log(error);
        }
    });


    return false;
}


function myFunction() {
  var x = document.getElementById("myLinks");
  if (x.style.display === "block") {
    x.style.display = "none";
  } else {
    x.style.display = "block";
  }
}
        
    </script>
</body>
</html>

