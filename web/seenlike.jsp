
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
       int likedby_id = (int) session.getAttribute("loggedid");
      String  notifyid=request.getParameter("notify"); 
    String  bloged=request.getParameter("blogged"); 
try{
    %> <%=notifyid %><%=bloged %>
    <%@ include file="connections.jsp" %>
    <%
        ResultSet resultSet;
             // Check if the user already liked the blog
            PreparedStatement psSelect = conn.prepareStatement("UPDATE notifyblog SET seen=1 WHERE notify_id = ?");
            psSelect.setString(1,notifyid); 
            int affect= psSelect.executeUpdate();
            String wher="getblogid.jsp?id="+bloged;
            response.sendRedirect(wher);
                %>
<%
    
    }catch(Exception e){
    out.print(e +notifyid);
    }    
%>