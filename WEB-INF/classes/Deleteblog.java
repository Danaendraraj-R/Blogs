import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBlog")
public class Deleteblog extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String blogId = request.getParameter("blogId");
        if (blogId != null && !blogId.isEmpty()) {
        try {
            Class.forName("org.postgresql.Driver");
            Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/blogs","postgres", "Rajdr039*");
            String sql = "DELETE FROM blogs WHERE blogid = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, blogId);
                statement.executeUpdate();
            }
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        }

        response.sendRedirect("Viewblog.jsp");
    }

}
