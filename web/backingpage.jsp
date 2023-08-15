
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
 
  PreparedStatement psSelect = conn.prepareStatement("select * from likes   where blog_id  = ? and likedby_id = ? ");
 
  psSelect.setString(1, blog_id);
  psSelect.setInt(2,likedby_id);  
  
resultSet = psSelect.executeQuery();
  
  if(resultSet.next()){
   String liked = resultSet.getString("liked");   
  if(liked.equals(0)){
  PreparedStatement pupdate = conn.prepareStatement("update likes  set liked= 1 where blog_id  = ? and likedby_id = ? ");
 
  pupdate.setString(1, blog_id);
  pupdate.setInt(2, likedby_id);  
   int rowaffected=pupdate.executeUpdate();  
   if(rowaffected>0){
   //select likes in blog table
   PreparedStatement psSelectlike = conn.prepareStatement("select * from blogs  where blog_id  = ? ");
   psSelectlike.setString(1,blog_id);  
   resultSet = psSelectlike.executeQuery();
   int alllike=resultSet.getInt("likeshas"); 
   int addlike=alllike+1;
   //update likes in blog table
  PreparedStatement paddlike = conn.prepareStatement("update blogs  set likeshas= ? where blog_id  = ?");
    paddlike.setInt(1,addlike);
        }else{
        out.print("error while liking updating likes table");
        }
        }else{
  //igihe he already like make unlike    

  PreparedStatement pupdate = conn.prepareStatement("update likes  set liked= 0 where blog_id  = ? and likedby_id = ? ");
 
  pupdate.setString(1, blog_id);
  pupdate.setInt(2, likedby_id);  
   int rowaffected=pupdate.executeUpdate();  
   if(rowaffected>0){
   //select likes in blog table
   PreparedStatement psSelectlike = conn.prepareStatement("select * from blogs  where blog_id  = ? ");
   psSelectlike.setString(1,blog_id);  
   resultSet = psSelectlike.executeQuery();
   int alllike=resultSet.getInt("likeshas"); 
   int addlike=alllike-1;
   //update likes in blog table
  PreparedStatement paddlike = conn.prepareStatement("update blogs  set likeshas= ? where blog_id  = ?");
    paddlike.setInt(1,addlike);
    paddlike.setString(1,blog_id);
   int rowaffect =paddlike.executeUpdate();
   if(rowaffect>0){
      response.sendRedirect("index.jsp");
        }
        }else{
        out.print("error while unlike updating likes table");
        }  
        
        }
  
    
    }
    else{
            // Insert like into likes table
            PreparedStatement pupdate = conn.prepareStatement("INSERT INTO likes (likedby_id, blog_id, liked) VALUES (?, ?, ?)");
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
                    int allLikes = resultSet.getInt("likeshas");
                    int addLike = allLikes + 1;
                    
                    // Update likes in blog table
                    PreparedStatement psUpdateLikes = conn.prepareStatement("UPDATE blogs SET likeshas = ? WHERE blog_id = ?");
                    psUpdateLikes.setInt(1, addLike);
                    psUpdateLikes.setString(2, blog_id);
                    int rowsAffected = psUpdateLikes.executeUpdate();

                    if (rowsAffected > 0) {
                        out.print("Liked successfully!");
                    } else {
                        out.print("Failed to update likes in blog table");
                    }
                } else {
                    out.print("Blog not found");
                }
            } else {
                out.print("Error while inserting like into likes table");
            }
    }
    
    }catch(Exception e){
    out.print(e +blog_id);
    }    
%>