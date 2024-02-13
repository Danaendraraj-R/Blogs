import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/EditBlog")
public class Editblog extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String blogId = request.getParameter("blogId");
        Blog blog = getBlogDetails(blogId);
        String jsonBlog = "{\"blogId\":\"" + blog.blogId + "\",\"title\":\"" + blog.title + "\",\"content\":\"" + blog.content + "\"}";
        request.setAttribute("jsonBlog", jsonBlog);
        RequestDispatcher dispatcher = request.getRequestDispatcher("EditBlog.jsp");
        dispatcher.forward(request, response);
    }

    private Blog getBlogDetails(String blogId) {
        Blog blog = new Blog();
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/blogs",
                    "postgres", "Rajdr039*");

            String sql = "SELECT * FROM blogs WHERE blogid = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, blogId);
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    blog.blogId = resultSet.getString("blogid");
                    blog.title = resultSet.getString("blogname");
                    blog.content = resultSet.getString("blogcontent");
                }

                resultSet.close();
            }

            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return blog;
    }

    private static class Blog {
        private String blogId;
        private String title;
        private String content;
    }
}
