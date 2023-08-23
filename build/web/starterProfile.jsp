<%@ include file="connections.jsp" %>  
<div class="row">
    <div class="col-lg-12 mb-2">
        <a href="createNewPost.jsp" class="btn block btn-secondary" style="width: 100%">
            create post
         </a> 
    </div>
<div class="col-lg-12">
        <div class="row gap-3 space-3 ">
            <div class=" d-flex gap-3 mt-3 mb-2">
                <div>
                    <img class="link-secondary" style="border-radius: 50%" src="img/rp-logo.jpg" width="60px" height="60px">

                </div>
                <div class="mt-1">
                    <div class="flex flex-column">
                        <div>
                               
                            <% 
                            String mail=(String)session.getAttribute("loggedemail"); 
                            String name=(String)session.getAttribute("loggedname"); 
                           %></div>
                        <div >
                            <a href=""><i class="fas fa-heart"></i> <!-- Solid heart icon -->

                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-flex gap-3 justify-content-around">
                            
             
                <div>
                     <%
//                     
////        String user_identity = (String) session.getAttribute("loggedid");
//        String username = (String) session.getAttribute("loggedname");
////        out.print(username);
     try{
   int logid = (int) session.getAttribute("loggedid");
        PreparedStatement psSelecto = conn.prepareStatement("SELECT sum(followed) as total FROM followers WHERE following_id = ? AND followed = 1");
            psSelecto.setInt(1, logid);
        ResultSet resultSet = psSelecto.executeQuery();
        if(resultSet.next()){
        int total=resultSet.getInt("total");
       %>
       <strong >  <%=total%> Followers</strong>              
         <% 
    }else{
    
    }
    }catch(Exception e){
    out.print(e);
    }
                     %>
                </div>
                 <div>
                     <%
                     
//        String user_identity = (String) session.getAttribute("loggedid");
        String username = (String) session.getAttribute("loggedname");
//        out.print(username);
     try{
   int logid = (int) session.getAttribute("loggedid");
        PreparedStatement psSelecto = conn.prepareStatement("SELECT sum(followed) as total FROM followers WHERE followedby_id = ? AND followed = 1");
            psSelecto.setInt(1, logid);
        ResultSet resultSet = psSelecto.executeQuery();
        if(resultSet.next()){
        int total=resultSet.getInt("total");
       %>
       <strong >  <%=total%> Following</strong>              
         <% 
    }else{
    
    }
    }catch(Exception e){
    out.print(e);
    }
                     %>
                     
                  
                </div>
                 <div>

                     <%
                     
////        String user_identity = (String) session.getAttribute("loggedid");
//        String username = (String) session.getAttribute("loggedname");
////        out.print(username);
     try{
   int logid = (int) session.getAttribute("loggedid");
        PreparedStatement psSelecto = conn.prepareStatement("SELECT count(blog_id) as total FROM blogs WHERE user_id = ?");
            psSelecto.setInt(1, logid);
        ResultSet resultSet = psSelecto.executeQuery();
        if(resultSet.next()){
        int total=resultSet.getInt("total");
       %>
       <strong >  <%=total%> Posts</strong>              
         <% 
    }else{
    
    }
    }catch(Exception e){
    out.print(e);
    }
                     %>                     
                     
                </div>
            </div> 
        </div>
            <hr><!-- comment -->
            <h5 class="link-body-emphasis mb-1">Suggested users</h5>
            
            <div class="d-flex flex-column gap-3 justify-content-start">
                 <%--<%@ include file="userCard.jsp"%>--%> 
     <div class="col-md-8">
        <div class="row justify-content-center"> 
            <div class="col-lg-12 "> 
               

               <%
               try {
                   int logid = (int) session.getAttribute("loggedid");
 PreparedStatement psSelect = conn.prepareStatement("SELECT users.*, followers.* FROM users LEFT JOIN (SELECT following_id FROM followers WHERE followedby_id = ? AND followed = 0) followers ON users.user_id = followers.following_id WHERE users.user_id != ? OR followers.following_id IS NULL Limit 3");

                   psSelect.setInt(1, logid);
                   psSelect.setInt(2, logid);
                   ResultSet resultSet = psSelect.executeQuery();

                   while (resultSet.next()) {
                       String usernam = resultSet.getString("username");
                       int followeduser = resultSet.getInt("user_id");
                       
                    %>
                    <%--<%@include file="userCard"%>--%>
<div class="d-flex flex-row justify-content-between align-items-center mt-3 mb-2">
    <div class="d-flex">
        <!-- Left side: User image and username -->
        <div class="mr-2">
            <!-- User image -->
            <img class="link-secondary" style="border-radius: 50%" src="img/rp-logo.jpg" width="40px" height="40px">
        </div>

        <div class="mr-3">
            <!-- Username -->
            
                <%= usernam %>                <%= followeduser %>
        </div>
    </div>
    <!-- Right side: Follow/Unfollow button -->
    <form method="post" action="followlogic.jsp">
            <div>
                <!-- Follow button -->
                <input type="hidden" value="<%=followeduser%>" name="followingidi">
                <button class="btn btn-sm btn-secondary" type="submit" name="follow">Follow</button>
            </div>

    </form>
</div>

                    <%
                        }

                        resultSet.close();
                        psSelect.close();
                    } catch (Exception e) {
                        out.print(e);
                    }
                    %>

        </div> 
        </div> 
    </div>                
                 
            
            </div>
            
            <%@ include file="footer.jsp" %>
       

    </div></div> 