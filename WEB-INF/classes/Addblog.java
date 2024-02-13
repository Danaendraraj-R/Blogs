import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddBlog")
public class Addblog extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Class not found " + e);
        }
        try {
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/blogs", "postgres", "Rajdr039*");
            System.out.println("Connection successful");
            String blogId = generateRandomNumberAsString();
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());

            PreparedStatement st = conn.prepareStatement("INSERT INTO blogs(blogauthor, blogemail, blogid, blogname, blogcontent, timestamp) VALUES (?, ?, ?, ?, ?, ?)");
            st.setString(1, request.getParameter("authorname"));
            st.setString(2, request.getParameter("authoremail"));
            st.setString(3, blogId); 
            st.setString(4, request.getParameter("blogtitle"));
            st.setString(5, request.getParameter("blogcontent"));
            st.setTimestamp(6, timestamp); 

            st.executeUpdate();

            st.close();
            conn.close();

            response.sendRedirect("Viewblog.jsp");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

        private String generateRandomNumberAsString() {
        Random random = new Random();
        int randomNumber = 100000 + random.nextInt(900000);
        return String.valueOf(randomNumber);
    }
}
