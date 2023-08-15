
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
       int likedby_id = (int) session.getAttribute("loggedid");
      String  followed_id=request.getParameter("followingidi"); 
    
try{
    %> <%=followed_id %>
    <%@ include file="connections.jsp" %>
    <%
        ResultSet resultSet;
             // Check if the user already liked the blog
            PreparedStatement psSelect = conn.prepareStatement("SELECT * FROM followers WHERE following_id = ? AND followedby_id = ?");
            psSelect.setString(1,followed_id);
            psSelect.setInt(2, likedby_id); 
            resultSet = psSelect.executeQuery();
  
            if (resultSet.next()) {
                int followed = resultSet.getInt("followed");
                
                if (followed == 0) {
                    // User hasn't liked before, so like the blog
                    PreparedStatement pupdate = conn.prepareStatement("UPDATE followers SET followed = ? WHERE following_id = ? AND followedby_id = ?");
                    pupdate.setInt(1, 1); // Set the value for "followed" column
                    pupdate.setString(2,followed_id ); // Set the value for "following_id"
                    pupdate.setInt(3, likedby_id); // Set the value for "followedby_id"
                    int rowaffected = pupdate.executeUpdate();

                    
                    if (rowaffected > 0) {
                        // Update likes in the blogs table
                        PreparedStatement psSelectLike = conn.prepareStatement("SELECT * FROM users WHERE user_id = ?");
                        psSelectLike.setString(1, followed_id);
                        resultSet = psSelectLike.executeQuery();
                        
                        if (resultSet.next()) {
                            int allLikes = resultSet.getInt("followers"); 
                            int addlike = allLikes + 1;
                            
                            PreparedStatement paddlike = conn.prepareStatement("UPDATE users SET  followers= ? WHERE  user_id= ?");
                            paddlike.setInt(1, addlike);
                            paddlike.setString(2, followed_id);
                            int rowaffect = paddlike.executeUpdate();
                            
                            if (rowaffect > 0) {
                                response.sendRedirect("UsersList.jsp");
                            } else {
                                out.print("Error while updating follows in the blogs table");
                            }
                        }
                    } else {
                        out.print("Error while liking - updating likes tablessssssssss"+likedby_id+followed_id);
                    }
                } else {
                    // User has already liked, so unlike the blog
                    PreparedStatement pupdate = conn.prepareStatement("UPDATE followers SET followed = 0 WHERE  following_id= ? AND followedby_id = ?");
                    pupdate.setString(1, followed_id);
                    pupdate.setInt(2, likedby_id);
                    int rowaffected = pupdate.executeUpdate();
                    
                    if (rowaffected > 0) {
                        // Update likes in the blogs table
                        PreparedStatement psSelectLike = conn.prepareStatement("SELECT * FROM users WHERE user_id = ?");
                        psSelectLike.setString(1, followed_id);
                        resultSet = psSelectLike.executeQuery();
                        
                        if (resultSet.next()) {
                            int allLikes = resultSet.getInt("followers"); 
                            int subtractlike = allLikes - 1;
                            
                            PreparedStatement paddlike = conn.prepareStatement("UPDATE users SET followers = ? WHERE user_id = ?");
                            paddlike.setInt(1, subtractlike);
                            paddlike.setString(2, followed_id);
                            int rowaffect = paddlike.executeUpdate();
                            
                            if (rowaffect > 0) {
                                response.sendRedirect("UsersList.jsp");
                            } else {
                                out.print("Error while updating likes in the blogs table");
                            }
                        }
                    } else {
                        out.print("Error while unliking - updating likes table");
                    }
                }
            }
    else{
            // Insert like into likes table
            PreparedStatement pupdate = conn.prepareStatement("INSERT INTO followers (following_id, followedby_id, followed) VALUES (?, ?, ?)");
            pupdate.setString(1, followed_id);
            pupdate.setInt(2, likedby_id);
            pupdate.setInt(3, 1);
            int rowAffected = pupdate.executeUpdate();

            if (rowAffected > 0) {
                // Select likes in blog table
                PreparedStatement psSelectLike = conn.prepareStatement("SELECT * FROM users WHERE user_id = ?");
                psSelectLike.setString(1, followed_id);
                resultSet = psSelectLike.executeQuery();
                
                if (resultSet.next()) {
                    int allLikes = resultSet.getInt("followers");
                    int addLike = allLikes + 1;
                    
                    // Update likes in blog table
                    PreparedStatement psUpdateLikes = conn.prepareStatement("UPDATE users SET followers = ? WHERE user_id = ?");
                    psUpdateLikes.setInt(1, addLike);
                    psUpdateLikes.setString(2, followed_id);
                    int rowsAffected = psUpdateLikes.executeUpdate();

                    if (rowsAffected > 0) {
                     response.sendRedirect("UsersList.jsp");
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
    out.print(e +followed_id);
    }    
%>