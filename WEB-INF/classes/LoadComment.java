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

@WebServlet("/LoadComment")

public class LoadComment extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String blogId = request.getParameter("blogId");

        List<String> commentsJson = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/blogs", "postgres", "Rajdr039*")) {
            String sql = "SELECT comments FROM comments WHERE blogid = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, blogId);
                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    String commentText = resultSet.getString("comments");
                    String commentJson = String.format("{\"text\": \"%s\"}", commentText);
                    commentsJson.add(commentJson);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }

        String jsonArray = "[" + String.join(",", commentsJson) + "]";

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonArray);
    }
}
