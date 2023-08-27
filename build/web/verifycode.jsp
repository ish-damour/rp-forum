<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
    try{
 String code=request.getParameter("codegot"); 
  String check=request.getParameter("authcode"); 
   String name=request.getParameter("namegot"); 
  String mai=request.getParameter("emailgot"); 
 if(code.equalsIgnoreCase(check)){
 session.setAttribute("namemail",name);
  session.setAttribute("maile",mai);
 response.sendRedirect("signup.jsp");
    }else{
 out.print("byanze wishe code "+code);    
    }
    }catch(Exception e){
    out.print(e);
    }

    
%>
