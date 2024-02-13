import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ViewBlog")
public class ViewBlog extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        List<Blog> blogs = new ArrayList<>();

        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/blogs",
                    "postgres", "Rajdr039*");
            String sql = "SELECT * FROM blogs ORDER BY timestamp DESC";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                String title = resultSet.getString("blogname");
                String blogId = resultSet.getString("blogid");
                String author = resultSet.getString("blogauthor");
                String email = resultSet.getString("blogemail");
                String content = resultSet.getString("blogcontent");

                Blog blog = new Blog(title, content, blogId, email, author);
                blogs.add(blog);
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        StringBuilder jsonBuilder = new StringBuilder("[");
        for (int i = 0; i < blogs.size(); i++) {
            Blog blog = blogs.get(i);
            jsonBuilder.append("{")
                    .append("\"title\":\"").append(blog.getTitle()).append("\",")
                    .append("\"content\":\"").append(blog.getContent()).append("\",")
                    .append("\"blogId\":\"").append(blog.getBlogId()).append("\",")
                    .append("\"email\":\"").append(blog.getEmail()).append("\",")
                    .append("\"author\":\"").append(blog.getAuthor()).append("\"")
                    .append("}");
            if (i < blogs.size() - 1) {
                jsonBuilder.append(",");
            }
        }
        jsonBuilder.append("]");
        String json = jsonBuilder.toString();

        out.println(json);
    }
    private static class Blog {
        private String title;
        private String content;
        private String author;
        private String email;
        private String blogId;

        public Blog(String title, String content, String blogId, String email, String author) {
            this.title = title;
            this.content = content;
            this.blogId = blogId;
            this.email = email;
            this.author = author;
        }

        public String getTitle() {
            return title;
        }

        public String getContent() {
            return content;
        }

        public String getBlogId() {
            return blogId;
        }

        public String getEmail() {
            return email;
        }

        public String getAuthor() {
            return author;
        }
    }
}
