import java.io.*;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;
import javax.servlet.http.Part;

@WebServlet("/UploadImage")
@MultipartConfig(maxFileSize = 20 * 1024 * 1024) // Max size set to 20MB
public class UploadImage extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        String jdbcUrl = "jdbc:mysql://localhost:3306/rpforum";
        String dbUser = "root";
        String dbPassword = "";
                HttpSession session = request.getSession();
                int logid = (int) session.getAttribute("loggedid");
                String descrption = request.getParameter("content");
                String title = request.getParameter("title");  
        try {
            
            out.print(logid+descrption+title);
     Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
       
            Part imagePart = request.getPart("imageFile");
            InputStream imageStream = imagePart.getInputStream();
            int like=0;
            PreparedStatement psInsert = conn.prepareStatement("INSERT INTO blogs (user_id,title,content,image_name, image_data,likeshas) VALUES (?,?,?,?,?,?)");
            psInsert.setInt(1, logid);
            psInsert.setString(2,title);
            psInsert.setString(3, descrption);           
            psInsert.setString(4, imagePart.getSubmittedFileName());
            psInsert.setBlob(5, imageStream);
            psInsert.setInt(6,0 );

            psInsert.executeUpdate();
            response.sendRedirect("index.jsp");

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
