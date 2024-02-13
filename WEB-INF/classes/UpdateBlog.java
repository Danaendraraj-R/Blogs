import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateBlog")
public class UpdateBlog extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String blogId = request.getParameter("blogId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        updateBlog(blogId, title, content);
        response.sendRedirect("ViewBlog");
    }

    private void updateBlog(String blogId, String title, String content) {
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/blogs",
                    "postgres", "Rajdr039*");

            String sql = "UPDATE blogs SET blogname = ?, blogcontent = ? WHERE blogid = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, title);
                statement.setString(2, content);
                statement.setString(3, blogId);
                statement.executeUpdate();
            }

            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            
        }
    }
}
