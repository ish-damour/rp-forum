
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
       int likedby_id = (int) session.getAttribute("loggedid");
      String blog_id =request.getParameter("hiddenblogid"); 
      String commenttext=request.getParameter("commenttext");
    
try{
    %> <%=blog_id %>
    <%@ include file="connections.jsp" %>
    <%

            // Insert like into likes table
            PreparedStatement pupdate = conn.prepareStatement("INSERT INTO comment (commentedbyid,blogid,comment) VALUES (?, ?, ?)");
            pupdate.setInt(1, likedby_id);
            pupdate.setString(2, blog_id);
            pupdate.setString(3,commenttext);
            int rowAffected = pupdate.executeUpdate();

            if (rowAffected > 0) {
//                // Select likes in blog table
//                PreparedStatement psSelectLike = conn.prepareStatement("SELECT * FROM comment WHERE blog_id = ?");
//                psSelectLike.setString(1, blog_id);
//                resultSet = psSelectLike.executeQuery();
//                
//                if (resultSet.next()) {
//                    int allLikes = resultSet.getInt("likeshas");
//                    int addLike = allLikes + 1;
//                    
//                    // Update likes in blog table
//                    PreparedStatement psUpdateLikes = conn.prepareStatement("UPDATE blogs SET likeshas = ? WHERE blog_id = ?");
//                    psUpdateLikes.setInt(1, addLike);
//                    psUpdateLikes.setString(2, blog_id);
//                    int rowsAffected = psUpdateLikes.executeUpdate();
//
//                    if (rowsAffected > 0) {
//                      String previousPage = request.getParameter("previousPage");
//                                if (previousPage != null) {
//                     PreparedStatement mofierlike = conn.prepareStatement("INSERT INTO modifier (`blogid`) values (?) ");
//                                    mofierlike.setString(1,blog_id);
//                            int affectedmodi = mofierlike.executeUpdate();
//                            session.setAttribute("blogliked",blog_id);
//                                   response.sendRedirect("modifier.jsp");
//                                }
////                        response.sendRedirect("index.jsp");
//                    } else {
//                        out.print("Failed to update likes in blog table");
//                    }
//                } else {
//                    out.print("Blog not found");
//                }
//            } else {
//                out.print("Error while inserting like into likes table");
//            }

 response.sendRedirect("getblogid.jsp?id="+blog_id);
        
        }else{
     out.print("blog_id");       
        }}catch(Exception e){
    out.print(e +blog_id);
    }    
%>