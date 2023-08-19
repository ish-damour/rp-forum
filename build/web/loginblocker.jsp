
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("loggedid") == null) {
        response.sendRedirect("login.jsp");
    } else {
    %>
<%

        
}
%>