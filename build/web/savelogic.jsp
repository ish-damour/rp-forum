
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
       int likedby_id = (int) session.getAttribute("loggedid");
      String blog_id =request.getParameter("hiddenblogid"); 
    
try{
    %> <%=blog_id %>
    <%@ include file="connections.jsp" %>
    <%
        ResultSet resultSet;
             // Check if the user already liked the blog
            PreparedStatement psSelect = conn.prepareStatement("SELECT * FROM saved WHERE blogid = ? AND savedby = ?");
            psSelect.setString(1, blog_id);
            psSelect.setInt(2, likedby_id);  
            resultSet = psSelect.executeQuery();
  
            if (resultSet.next()) {
                int saved = resultSet.getInt("saved");
                
                if (saved == 0) {
                    // User hasn't liked before, so like the blog
                    PreparedStatement pupdate = conn.prepareStatement("UPDATE saved SET saved = 1 WHERE blogid = ? AND savedby = ?");
                    pupdate.setString(1, blog_id);
                    pupdate.setInt(2, likedby_id);
                    int rowaffected = pupdate.executeUpdate();
                    
                    if (rowaffected > 0) {
                        // Update likes in the blogs table
                        PreparedStatement psSelectLike = conn.prepareStatement("SELECT * FROM blogs WHERE blog_id = ?");
                        psSelectLike.setString(1, blog_id);
                        resultSet = psSelectLike.executeQuery();
                        
                        if (resultSet.next()) {
                   PreparedStatement mofierlike = conn.prepareStatement("INSERT INTO modifier (`blogid`) values (?) ");
                                    mofierlike.setString(1,blog_id);
                            int affectedmodi = mofierlike.executeUpdate();
                            session.setAttribute("blogliked",blog_id);
                                response.sendRedirect("savedpage.jsp");
                            } else {
                                out.print("Error while updating saves in the blogs table");
                            }
                        }
                } else {
                    // User has already liked, so unlike the blog
                    PreparedStatement pupdate = conn.prepareStatement("UPDATE saved SET saved = 0 WHERE blogid = ? AND savedby = ?");
                    pupdate.setString(1, blog_id);
                    pupdate.setInt(2, likedby_id);
                    int rowaffected = pupdate.executeUpdate();
                    
                    if (rowaffected > 0) {
                        // Update likes in the blogs table
                        PreparedStatement psSelectLike = conn.prepareStatement("SELECT * FROM blogs WHERE blog_id = ?");
                        psSelectLike.setString(1, blog_id);
                        resultSet = psSelectLike.executeQuery();
                        
                                String previousPage = request.getParameter("previousPage");
                                if (previousPage != null) {
                     PreparedStatement mofierlike = conn.prepareStatement("INSERT INTO modifier (`blogid`) values (?) ");
                        mofierlike.setString(1,blog_id);
                            int affectedmodi = mofierlike.executeUpdate();
                            session.setAttribute("blogliked",blog_id);
                                   response.sendRedirect("savedpage.jsp");
                                }
//                                response.sendRedirect("index.jsp");
                    } else {
                        out.print("Error while unlsaving - updating saves table");
                    }
                }
            }
    else{
            // Insert like into likes table
            PreparedStatement pupdate = conn.prepareStatement("INSERT INTO saved (savedby, blogid, saved) VALUES (?, ?, ?)");
            pupdate.setInt(1, likedby_id);
            pupdate.setString(2, blog_id);
            pupdate.setInt(3, 1);
            int rowAffected = pupdate.executeUpdate();

            if (rowAffected > 0) {
                // Select likes in blog table
                PreparedStatement psSelectLike = conn.prepareStatement("SELECT * FROM blogs WHERE blog_id = ?");
                psSelectLike.setString(1, blog_id);
                resultSet = psSelectLike.executeQuery();
                
                if (resultSet.next()) {
                      String previousPage = request.getParameter("previousPage");
                                if (previousPage != null) {
                     PreparedStatement mofierlike = conn.prepareStatement("INSERT INTO modifier (`blogid`) values (?) ");
                                    mofierlike.setString(1,blog_id);
                            int affectedmodi = mofierlike.executeUpdate();
                            session.setAttribute("blogliked",blog_id);
                                   response.sendRedirect("savedpage.jsp");
                                }
//                        response.sendRedirect("index.jsp");
                    } else {
                        out.print("Failed to update likes in blog table");
                    }
            } else {
                out.print("Error while inserting saving into saved table");
            }
    }
    
    }catch(Exception e){
    out.print(e +blog_id);
    }    
%>