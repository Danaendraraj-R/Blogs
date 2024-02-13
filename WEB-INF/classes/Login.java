import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.sql.*;
import java.util.ArrayList;
@WebServlet("/Login")
@SuppressWarnings("unchecked")
public class Login extends HttpServlet {
	public void doPost(HttpServletRequest req , HttpServletResponse response) throws IOException{
					PrintWriter out = response.getWriter();
					String username="username";
					String password="password";
					String email="email";
				
		try{
			
			String user = req.getParameter("Email");
			String pass = req.getParameter("Password");
			
			

		Class.forName("org.postgresql.Driver");
		Connection conn = null;
            Statement stmt = null;
         conn = DriverManager
            .getConnection("jdbc:postgresql://localhost:5432/blogs",
            "postgres", "Rajdr039*");
			int allow = 0;
			stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM USERS;");
            while(rs.next()){
                email = rs.getString("email");
				password = rs.getString("password");
                if(email.equals(user) && password.equals(pass)){
                    allow++;
				username = rs.getString("username");

                HttpSession httpSession = req.getSession(true);
                httpSession.setAttribute("email", email);
                httpSession.setAttribute("username", username);

				break;
                }
            }
            rs.close();
            stmt.close();
			conn.close();
			if(allow==0)
			{
			response.sendRedirect("Error.jsp");
			}
			else
			{
                System.out.println("Login Successful!");
               response.sendRedirect("Viewblog.jsp");
            }
			
		} catch(Exception e){
			out.println(e);
	    }
	}
}