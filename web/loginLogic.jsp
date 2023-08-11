
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%

String email = request.getParameter("email");
String password = request.getParameter("password");

try{
    %> 
    <%@ include file="connections.jsp" %>
    <%
        
  PreparedStatement psSelect = conn.prepareStatement("select * from user where email = ? and password = ? ");
 
  psSelect.setString(1, email);
  psSelect.setString(2, password);  
  
  ResultSet resultSet = psSelect.executeQuery();
  
  if(resultSet.next()){
  
   String loggedId = resultSet.getString("id");   
   String loggedname = resultSet.getString("names");

   session.setAttribute("loggedUser", loggedId);
    session.setAttribute("loggedId", loggedname);
   
   response.sendRedirect("dashboard.jsp");
    
    }
    else{
    out.println("failed to log in");
    }
    
    }catch(Exception e){
    out.print(e);
    }    
%>