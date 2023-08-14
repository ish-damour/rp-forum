<%@ include file= "header.jsp"%>
<%@ include file= "connections.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file= "nav.jsp"%>
 <%
            try{ 
            int logid = (int) session.getAttribute("loggedid");
                String descrption = request.getParameter("descrption");
                String title = request.getParameter("title");   
                        PreparedStatement psInsert = conn.prepareStatement("insert into blogs "
                        + "(`user_id`,`title`,`content`) "
                        + "values(?,?,?)");
                        psInsert.setInt(2,logid);
                       psInsert.setString(3,title);
                       psInsert.setString(4,descrption);                      

                        psInsert.execute(); 

                        response.sendRedirect("index.jsp");
        }catch(Exception e){
         message = "<p class='alert alert-danger text-center'>"+ e +"</p>";
        }    
       
     %>
