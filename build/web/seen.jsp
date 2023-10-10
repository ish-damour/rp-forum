
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
       int likedby_id = (int) session.getAttribute("loggedid");
      String  notifyid=request.getParameter("notify"); 
    
try{
    %> <%=notifyid %>
    <%@ include file="connections.jsp" %>
    <%
        ResultSet resultSet;
             // Check if the user already liked the blog
            PreparedStatement psSelect = conn.prepareStatement("UPDATE notify SET seen=1 WHERE notify_id = ?");
            psSelect.setString(1,notifyid); 
            int affect= psSelect.executeUpdate();
  
            if (affect>0) {
                %>
<script type="text/javascript">
window.location.href="notification.jsp";	
</script>
<%
            }else{
            
        }
    
    }catch(Exception e){
    out.print(e +notifyid);
    }    
%>