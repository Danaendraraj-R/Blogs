import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
  
@WebServlet("/Register")
public class Register extends HttpServlet {
  
    private static final long serialVersionUID = 1L;
  
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Class not found " + e);
        }
        try {

            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/blogs","postgres", "Rajdr039*");
            System.out.println("connection successful");
              
            PreparedStatement st = conn.prepareStatement("insert into users(USERNAME,EMAIL,PASSWORD) values(?, ?, ?)");
            st.setString(1, request.getParameter("Username"));
            st.setString(2, request.getParameter("Email"));
            st.setString(3, request.getParameter("Password"));
            st.executeUpdate();
  
           
            st.close();
            conn.close();
        response.sendRedirect("index.html");
        } catch (Exception e) {
                System.out.println(e);
        }
    }
}