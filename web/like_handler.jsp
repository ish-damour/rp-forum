<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%
    int likedby_id = (int) session.getAttribute("loggedid");
    String blog_id = request.getParameter("hiddenblogid");

    String url = "jdbc:mysql://localhost:3306/rpforum";
    String username = "root";
    String password = "";
    Connection conn = null;
    Statement statement = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        statement = conn.createStatement();

        String postId = request.getParameter("postId");
        int postIdInt = Integer.parseInt(postId);
        blog_id=postId; 

        // Perform the database update
//        statement.executeUpdate("UPDATE blogs SET likeshas = likeshas + 1 WHERE blog_id = " + postIdInt);



%>


<%
        ResultSet resultSet;
             // Check if the user already liked the blog
            PreparedStatement psSelect = conn.prepareStatement("SELECT * FROM likes WHERE blog_id = ? AND likedby_id = ?");
            psSelect.setString(1, blog_id);
            psSelect.setInt(2, likedby_id);  
            resultSet = psSelect.executeQuery();
  
            if (resultSet.next()) {
                int liked = resultSet.getInt("liked");
                if (liked == 0) {
                session.setAttribute("action","like");
                    // User hasn't liked before, so like the blog
                    PreparedStatement pupdate = conn.prepareStatement("UPDATE likes SET liked = 1 WHERE blog_id = ? AND likedby_id = ?");
                    pupdate.setString(1, blog_id);
                    pupdate.setInt(2, likedby_id);
                    int rowaffected = pupdate.executeUpdate();
                    
                    if (rowaffected > 0) {
                        // Update likes in the blogs table
                        PreparedStatement psSelectLike = conn.prepareStatement("SELECT * FROM blogs WHERE blog_id = ?");
                        psSelectLike.setString(1, blog_id);
                        resultSet = psSelectLike.executeQuery();
                        
                        if (resultSet.next()) {
                            int allLikes = resultSet.getInt("likeshas"); 
                            int addlike = allLikes + 1;
                            
                            PreparedStatement paddlike = conn.prepareStatement("UPDATE blogs SET likeshas = ? WHERE blog_id = ?");
                            paddlike.setInt(1, addlike);
                            paddlike.setString(2, blog_id);
                            int rowaffect = paddlike.executeUpdate();
                            
                            if (rowaffect > 0) {
                   PreparedStatement mofierlike = conn.prepareStatement("INSERT INTO modifier (`blogid`) values (?) ");
                                    mofierlike.setString(1,blog_id);
                            int affectedmodi = mofierlike.executeUpdate();
                            session.setAttribute("blogliked",blog_id);
//                                response.sendRedirect("modifier.jsp");
                            } else {
                                out.print("Error while updating likes in the blogs table");
                            }
                        }
                    } else {
                        out.print("Error while liking - updating likes table");
                    }
                } else {
                    // User has already liked, so unlike the blog
               session.setAttribute("action","liked");
                    
                    PreparedStatement pupdate = conn.prepareStatement("UPDATE likes SET liked = 0 WHERE blog_id = ? AND likedby_id = ?");
                    pupdate.setString(1, blog_id);
                    pupdate.setInt(2, likedby_id);
                    int rowaffected = pupdate.executeUpdate();
                    
                    if (rowaffected > 0) {
                        // Update likes in the blogs table
                        PreparedStatement psSelectLike = conn.prepareStatement("SELECT * FROM blogs WHERE blog_id = ?");
                        psSelectLike.setString(1, blog_id);
                        resultSet = psSelectLike.executeQuery();
                        
                        if (resultSet.next()) {
                            int allLikes = resultSet.getInt("likeshas"); 
                            int subtractlike = allLikes - 1;
                            
                            PreparedStatement paddlike = conn.prepareStatement("UPDATE blogs SET likeshas = ? WHERE blog_id = ?");
                            paddlike.setInt(1, subtractlike);
                            paddlike.setString(2, blog_id);
                            int rowaffect = paddlike.executeUpdate();
                            
                            if (rowaffect > 0) {
                                String previousPage = request.getParameter("previousPage");
                                if (previousPage != null) {
                     PreparedStatement mofierlike = conn.prepareStatement("INSERT INTO modifier (`blogid`) values (?) ");
                        mofierlike.setString(1,blog_id);
                            int affectedmodi = mofierlike.executeUpdate();
                            session.setAttribute("blogliked",blog_id);
//                                   response.sendRedirect("modifier.jsp");
                                }
//                                response.sendRedirect("index.jsp");
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
            session.setAttribute("action","like");
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
                      String previousPage = request.getParameter("previousPage");
                                if (previousPage != null) {
                     PreparedStatement mofierlike = conn.prepareStatement("INSERT INTO modifier (`blogid`) values (?) ");
                                    mofierlike.setString(1,blog_id);
                            int affectedmodi = mofierlike.executeUpdate();
                            session.setAttribute("blogliked",blog_id);
                                   response.sendRedirect("modifier.jsp");
                                }
//                        response.sendRedirect("index.jsp");
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
%>


<%
        // Get the updated like count
        ResultSet rs = statement.executeQuery("SELECT likeshas FROM blogs WHERE blog_id = " + postIdInt);
        rs.next();
        
String actionlike=(String)session.getAttribute("action");
if(actionlike.equalsIgnoreCase("liked")){
        int newLikeCount = rs.getInt("likeshas");
        rs.close();

        out.print("<i class='far fa-heart'></i> "+newLikeCount);
    }else{
            
            int newLikeCount = rs.getInt("likeshas");
        rs.close();

        out.print("<i class='fas fa-heart'></i> "+newLikeCount);
    }

    } catch (Exception e) {
        e.printStackTrace();
        out.print(e.getMessage());
    } finally {
        try {
            if (statement != null) {
                statement.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
