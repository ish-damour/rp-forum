<%@ include file= "header.jsp"%>
<%@ include file= "connections.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file= "nav.jsp"%>
 <%
                    int logid = (int) session.getAttribute("loggedid");
                String descrption = request.getParameter("content");
                String title = request.getParameter("title");  
        try{ 
 
                        PreparedStatement psInsert = conn.prepareStatement("insert into blogs "
                        + "(`user_id`,`title`,`content`)"
                        + "values(?,?,?)");
                        psInsert.setInt(1,logid);
                       psInsert.setString(2,title);
                       psInsert.setString(3,descrption);                      

                        psInsert.execute(); 
                        response.sendRedirect("index.jsp");
                        
        }catch(Exception e){
         message = "<p class='alert alert-danger text-center'>"+ e+title+"</p>";
         out.print(message);
        }    
       
     %>
