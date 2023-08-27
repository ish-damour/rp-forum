import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.mail.*;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

@WebServlet(name = "Confirmemail", urlPatterns = {"/Confirmemail"})
public class Confirmemail extends HttpServlet {
 
    public String getRandom(){
     Random rnd=new Random();
    int number=rnd.nextInt(999999);
    return String.format("%06d", number);
    }  
    
@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
                String emailErrorMessage=null;
                HttpSession session=request.getSession();
                
                    
        try {
        out.print(getRandom());
            
            
                try {
                    String codes= getRandom();
                    String useremail=request.getParameter("useremail");
                    String userename=request.getParameter("userename");

                        sendApprovalEmail(useremail, userename, "RP-FORUM Security Team", "Confirm", codes, "+250781006107");
                        session.setAttribute("result", "OTP sent Successful on your email: ");
                        session.setAttribute("email", useremail);
                        session.setAttribute("codes",codes);
                        session.setAttribute("username",userename);
                        response.sendRedirect("codeform.jsp");

                }catch (EmailException ex) {
                    ex.printStackTrace();
                    // Email sending error
                    emailErrorMessage = "Email Sending Error: " + ex.getMessage(); // Set the emailErrorMessage
                }
        } catch (Exception ex) {
            ex.printStackTrace();
            // General error
            emailErrorMessage = "General Error: " + ex.getMessage();
        }

        // Set the emailErrorMessage attribute
        request.setAttribute("emailErrorMessage", emailErrorMessage);

        // Forward the request to the RentRequests.jsp page
        //request.getRequestDispatcher("RentRequests.jsp").forward(request, response);
//        response.sendRedirect("verify.jsp");
    }

    private void sendApprovalEmail(String tenant_email, String tenant_fname, String owner_names, String decision, String city, String mobile) throws EmailException {
        // Send email using JavaMail API and Apache Commons Email library
        Email email = new SimpleEmail();
        email.setHostName("smtp.gmail.com");
        email.setSmtpPort(465);

        email.setAuthenticator(new DefaultAuthenticator("ishimue250@gmail.com", "zcgujabitaxsxnjx"));

        email.setSSLOnConnect(true);
        email.setStartTLSEnabled(true);
        email.setFrom("ishimue250@gmail.com");
        email.setSubject("RP-FORUM Confirmation code");

String messageText = "Dear " + tenant_fname + ", "
                + "Confirm your Email Address to join "
        + "RP FORUM"
        + " platform Your Confirmation code is: "
        + "" + city + 
        "  Copy and paste to continue."
          + "RP_FORUM 2023\n";
        email.setMsg(messageText);
        email.addTo(tenant_email);
        email.send();
    }
}
