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
                        <div class="btn">
                            <%=name %><i class="fas fa-heart"></i> <!-- Solid heart icon -->
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
<div class="row gap-1 space-3 ">
    <h5 class="link-body-emphasis mb-1 text-center">Suggested users</h5>
    <%
        try {
            int logid = (int) session.getAttribute("loggedid");
            PreparedStatement psSelect = conn.prepareStatement("SELECT * FROM users WHERE user_id != ? ");
            psSelect.setInt(1, logid);
            ResultSet resultSet = psSelect.executeQuery();
int counter=0;
            while (resultSet.next()) {
               if (counter >= 3) {
            break; // Stop displaying buttons after 3 rows
        } 
                String usernam = resultSet.getString("username");
                int followeduser = resultSet.getInt("user_id");

                PreparedStatement psSelectfollow = conn.prepareStatement("SELECT * FROM followers WHERE following_id = ? AND followedby_id = ?");
                psSelectfollow.setInt(1, followeduser);
                psSelectfollow.setInt(2, logid);
                ResultSet resultSetfollow = psSelectfollow.executeQuery();

                boolean isFollowed = resultSetfollow.next();
    %>
    <!--<form method="post" action="followlogic.jsp">-->
        <%
            PreparedStatement psSelectl = conn.prepareStatement("SELECT * FROM followers WHERE following_id = ? AND followedby_id = ? AND followed = ? ");
            psSelectl.setInt(1, followeduser);
            psSelectl.setInt(2, logid);  
            psSelectl.setInt(3, 1);  
            ResultSet resultSetl = psSelectl.executeQuery();

            if (resultSetl.next()) {
                int followed_id = resultSetl.getInt("following_id");
            } else {
        %>
        <div class="d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center ">
                <div  class="mx-3">
                    <img class="link-secondary" style="border-radius: 50%" src="img/rp-logo.jpg" width="30px" height="30px">
                </div>
                <div class="mr-3">
                    <%= usernam %> 
                </div>
            </div>
            <div class="flex-shrink-0">
                <input type="hidden" value="<%=followeduser%>" name="followingidi">
                <!--<button class="btn btn-sm btn-secondary" type="submit" name="follow">Follow</button>-->
             <button onclick="followuser(<%=followeduser  %>)"  class="btn btn-sm btn-outline-primary ">
                <span id="follow_<%= followeduser %>">Follow
                    <!--<i class='far fa-heart mr-1'> </i>-->
                    <%--<%=  %>--%>
                </span></button>
            </div>
        </div>
        <%
        counter ++;
            }
        %>
    <!--</form>-->
    <%
        resultSetfollow.close();
        
    }

    resultSet.close();
    psSelect.close();
    } catch (Exception e) {
        out.print(e);
    }
    %>                 
</div>

            <hr><!-- comment -->            

                        <script>
function followuser(followid) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
//            console.log("Response Text:", xhr.responseText); // Add this line for debugging
            var newfollow = xhr.responseText;
            document.getElementById("follow_" + followid).innerHTML =newfollow;
        }
    };
    xhr.open("POST", "follow_handler.jsp", true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.send("followid=" + followid);
}

    </script>   
            <%@ include file="footer.jsp" %>
       

    </div></div> 