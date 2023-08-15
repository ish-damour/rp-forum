
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("loggedid") == null) {
        response.sendRedirect("login.jsp");
    } else {
//        String user_identity = (String) session.getAttribute("loggedid");
//        String username = (String) session.getAttribute("loggedname");
//        out.print("bbbbbbbbbbbbbbb");
}
%>