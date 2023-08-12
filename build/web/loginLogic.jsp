
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");
try{
    %> 
    <%@ include file="connections.jsp" %>
    <%
        
  PreparedStatement psSelect = conn.prepareStatement("select * from users where email = ? and password = ? ");
 
  psSelect.setString(1, email);
  psSelect.setString(2, password);  
  
  ResultSet resultSet = psSelect.executeQuery();
  
  if(resultSet.next()){
  
   String loggedemail = resultSet.getString("email");   
   String loggedname = resultSet.getString("username");

   session.setAttribute("loggedemail", loggedemail);
    session.setAttribute("loggedname", loggedname);
   
   response.sendRedirect("index.jsp");
    
    }
    else{
    %>
<%
    }
    
    }catch(Exception e){
    out.print(e);
    }    
%>