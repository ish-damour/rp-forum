<%@ page import="java.io.*, java.sql.*" %>
<div class="flex flex-column gap-4">
 
    
    
<%
                          String bloggetted = (String) session.getAttribute("blogliked");
//                          int loggedidi = (int) session.getAttribute("loggedid");
                       %>
  <%      try{
//            PreparedStatement psSelect = 
//            conn.prepareStatement("SELECT * FROM blogs,users where users.user_id=blogs.user_id");
//            ResultSet resultSet = psSelect.executeQuery();
          int loggedid = (int) session.getAttribute("loggedid");
//         String query = "SELECT blogs.blog_id, blogs.title, blogs.content, blogs.created_at,blogs.image_name,blogs.image_data,blogs.likeshas,blogs.user_id,users.username,latest_modifiers.last_modified FROM blogs JOIN users ON blogs.user_id = users.user_id LEFT JOIN (SELECT blogid, MAX(last_modified)"
//         + " AS last_modified FROM modifier GROUP BY blogid) AS latest_modifiers ON blogs.blog_id  = latest_modifiers.blogid ORDER BY COALESCE(latest_modifiers.last_modified, blogs.created_at) DESC";
       
//String query = "SELECT blogs.blog_id, blogs.title, blogs.content, blogs.created_at, "
//    + "blogs.image_name, blogs.image_data, blogs.likeshas, blogs.user_id, users.username, "
//    + "latest_modifiers.last_modified FROM blogs "
//    + "JOIN users ON blogs.user_id = users.user_id "
//    + "LEFT JOIN (SELECT blogid, MAX(last_modified) AS last_modified "
//    + "FROM modifier GROUP BY blogid) AS latest_modifiers ON blogs.blog_id = latest_modifiers.blogid "
//    + "WHERE users.user_id IN (SELECT followers.following_id FROM followers WHERE followed != 0 and followedby_id='"+loggedid+"') "
//    + "ORDER BY COALESCE(latest_modifiers.last_modified, blogs.created_at) DESC";

//String query = "SELECT blogs.blog_id, blogs.title, blogs.content, blogs.created_at, "
//    + "blogs.image_name, blogs.image_data, blogs.likeshas, blogs.user_id, users.username, "
//    + "latest_modifiers.last_modified FROM blogs "
//    + "JOIN users ON blogs.user_id = users.user_id "
//    + "LEFT JOIN (SELECT blogid, MAX(last_modified) AS last_modified "
//    + "FROM modifier GROUP BY blogid) AS latest_modifiers ON blogs.blog_id = latest_modifiers.blogid "
//    + "WHERE users.user_id = '" + loggedid + "' "
//    + "OR users.user_id IN (SELECT followers.following_id FROM followers WHERE followed = 1 and followedby_id='"+loggedid+"') "
//    + "ORDER BY COALESCE(latest_modifiers.last_modified, blogs.created_at) DESC";


String queryi="SELECT * FROM notify,users where notify.owner_id='" + loggedid + "' and notify.reacter_id=users.user_id ORDER  BY notify.created_at DESC";
String query="SELECT f.notify_id, f.owner_id, f.reacter_id, f.action, f.seen, f.created_at, u.username AS reacter_username, u.email AS reacter_email FROM notify f INNER JOIN users u ON f.reacter_id = u.user_id WHERE f.owner_id = '" + loggedid + "'UNION SELECT l.notify_id, l.owner_id, l.reacter_id, l.action, l.seen, l.created_at,"
+ " u.username AS reacter_username, u.email AS reacter_email FROM notifyblog l"
+ " INNER JOIN users u ON l.reacter_id = u.user_id INNER JOIN blogs b "
+ "ON l.owner_id = b.blog_id"
+ " WHERE b.user_id ='" + loggedid + "' ORDER BY created_at DESC;";



//String query = "WITH LatestModifiers AS ("
//    + "SELECT blogid, MAX(last_modified) AS last_modified "
//    + "FROM modifier GROUP BY blogid"
//    + ")"
//    + "SELECT blogs.blog_id, blogs.title, blogs.content, blogs.created_at, "
//    + "blogs.image_name, blogs.image_data, blogs.likeshas, blogs.user_id, users.username, "
//    + "lm.last_modified "
//    + "FROM blogs "
//    + "JOIN users ON blogs.user_id = users.user_id "
//    + "LEFT JOIN LatestModifiers AS lm ON blogs.blog_id = lm.blogid "
//    + "WHERE users.user_id IN (SELECT followedby_id FROM followers WHERE followed = 1) "
//    + "UNION ALL " // Combine with blogs posted by user_id = 1
//    + "SELECT blogs.blog_id, blogs.title, blogs.content, blogs.created_at, "
//    + "blogs.image_name, blogs.image_data, blogs.likeshas, blogs.user_id, users.username, "
//    + "lm2.last_modified "
//    + "FROM blogs "
//    + "JOIN users ON blogs.user_id = users.user_id "
//    + "LEFT JOIN LatestModifiers AS lm2 ON blogs.blog_id = lm2.blogid "
//    + "WHERE users.user_id = 1 " // Select blogs posted by user_id = 1
//    + "UNION ALL " // Combine with blogs posted by other users (optional)
//    + "SELECT blogs.blog_id, blogs.title, blogs.content, blogs.created_at, "
//    + "blogs.image_name, blogs.image_data, blogs.likeshas, blogs.user_id, users.username, "
//    + "lm3.last_modified "
//    + "FROM blogs "
//    + "JOIN users ON blogs.user_id = users.user_id "
//    + "LEFT JOIN LatestModifiers AS lm3 ON blogs.blog_id = lm3.blogid "
//    + "WHERE users.user_id != 1 ";




        Statement statement = conn.createStatement();
      ResultSet  resultSet = statement.executeQuery(query);
        
        while (resultSet.next()) {
            String blogd=resultSet.getString("owner_id");
            int notify_id = resultSet.getInt("notify_id");
            String reacter_id = resultSet.getString("reacter_username");

            String action = resultSet.getString("action");
            int seen=resultSet.getInt("seen");
            String created_at=resultSet.getString("created_at");
//         if(resultSet.next()){
         
  
//            while (resultSet.next()) {
//                String username = resultSet.getString("username");                
//                String created_at = resultSet.getString("created_at");
//                String title = resultSet.getString("title");
//                String fullText = resultSet.getString("content");
//                String content = resultSet.getString("content");
//                String truncatedText = fullText.substring(0, Math.min(fullText.length(), 50));
//                request.setAttribute("truncatedText", truncatedText);
//                request.setAttribute("fullText", fullText);
//                int imageId = resultSet.getInt("blog_id");
//            String imageName = resultSet.getString("image_name");

//                int followingid = resultSet.getInt("user_id");
if(action.equalsIgnoreCase("following")&& seen==0){
   String ge = "<p class=' '><strong>"+reacter_id+" Started Following you!</strong></p>";
   String path1="seen.jsp?notify="+notify_id;
%>
<a href="<%=path1%>"  style="text-decoration: none"class="">
<div  class="alert  border-0 d-flex align-items-center py-0 my-1 rounded-0">
    <div class="mx-2">
        <img src="img/rp-logo.jpg" class="mr-3 rounded-5" alt="Profile Image" style="width: 50px; height: 50px;">
    </div>
    <div class="flex-grow-1 ">
        <span id="reacter_id"><strong> <%=reacter_id%></strong></span> Started following you!
        on 
        <!--<i class="fas fa-smile"></i>-->
    </div>
    <button type="submit" class="btn btn-outline-primary btn-sm ">Following</button>
</div></a>
 <% 
     }else if(action.equalsIgnoreCase("following")&& seen==1){
 String path1="seen.jsp?notify="+notify_id;
    String ge = "<p class='alert text-muted'><strong>"+reacter_id+"  Unfollowed you! ushaka wamwishyura!</strong><i class='fas fa-smile'></i   ></p>";
%>
<a href="#"  style="text-decoration: none"class=""><div class="alert text-muted d-flex align-items-center py-0 rounded-0">
    <div class="mx-2">
        <img src="img/rp-logo.jpg" class="mr-3 rounded-5" alt="Profile Image" style="width: 50px; height: 50px;">
    </div>
    <div class="flex-grow-1">
        <strong><span id="reacter_id"><%=reacter_id%></span> </strong>Started Following  you! 4hours ago
    </div><form method="post">
    <button class="btn btn-outline-primary btn-sm t">follow</button>
    </form>
    </div></a>
 <% 
      }else if(action.equalsIgnoreCase("unfollowed") && seen==1){
 String path1="seen.jsp?notify="+notify_id;
    String ge = "<p class='alert  text-muted'><strong>"+reacter_id+"  Unfollowed you! ushaka wamwishyura!</strong><i class='fas fa-smile'></i   ></p>";
%>
<a href="#"  style="text-decoration: none"class=""><div class="alert text-muted d-flex align-items-center py-0 rounded-0">
    <div class="mx-2">
        <!--<img src="getImage.jsp?id=" alt="" class="mg img-thumbnail border-0 border-none " style="min-width: 100%">-->        
    </div>
    <div class="flex-grow-1">
        <strong><span id="reacter_id"><%=reacter_id%></span> </strong>Unfollowed you! ushaka wamwishyura!
        <i class="fas fa-smile"></i>
    </div><form method="post">
    <button class="btn btn-outline-primary btn-sm t">follow</button>
    </form>
    </div></a>





 <%   
     }else if(action.equalsIgnoreCase("unfollowed") && seen==0){
   String path1="seen.jsp?notify="+notify_id;
//    String ge = "<p class='alert border-0 alert-secondary '><strong>"+reacter_id+"  Unfollowed you! ushaka wamwishyura!</strong><i class='fas fa-smile'></i   ></p>";
%>
<a href="<%=path1%>"  style="text-decoration: none"class="">
<div  class="alert border-0 d-flex align-items-center py-0 my-1 rounded-0">
    <div class="mx-2">
        <img src="img/rp-logo.jpg" class="mr-3 rounded-5" alt="Profile Image" style="width: 50px; height: 50px;">
    </div>
    <div class="flex-grow-1 ">
        <span id="reacter_id"><strong> <%=reacter_id%></strong></span> Unfollowed you!
        on 
        <!--<i class="fas fa-smile"></i>-->
    </div>
    <button type="submit" class="btn btn-outline-primary btn-sm ">Following</button>
</div></a>





 <%   
     }else if(action.equalsIgnoreCase("liked") && seen==0){
//    String path1="seenlike.jsp?notify="+notify_id;
//    String ge = "<p class='alert border-0 alert-secondary '><strong>"+reacter_id+"  Unfollowed you! ushaka wamwishyura!</strong><i class='fas fa-smile'></i   ></p>";

      PreparedStatement q = conn.prepareStatement("SELECT * FROM blogs WHERE blog_id = ?");
                        q.setString(1,blogd );
                        ResultSet resultSeto = q.executeQuery();
                        if(resultSeto.next()){
                        int imageId = resultSeto.getInt("blog_id");
            String imageName = resultSeto.getString("image_name");
            String imageDescription = resultSeto.getString("image_data");  
            int likeall=resultSeto.getInt("likeshas"); 
            int lef=likeall-1;
String path1="seenlike.jsp?notify="+notify_id+"&blogged=" +blogd;
 %>
<a href="<%=path1%>"  style="text-decoration: none"class="">
<div  class="alert  border-0 d-flex align-items-center py-0 my-1 rounded-0">
    <div class="mx-2">
        <img src="img/rp-logo.jpg" class="mr-3 rounded-5" alt="Profile Image" style="width: 50px; height: 50px;">
    </div>
    <div class="flex-grow-1 ">
        <span id="reacter_id"><strong> <%=reacter_id%></strong></span> and <%=lef%> others recently Liked your Post!
        on 
        <!--<i class="fas fa-smile"></i>-->
    </div>
       <%
            
if(!(imageName.equals(""))){
           %>
<!--<img src="getImage.jsp?id=" class="mg img-thumbnail border-0 border-none " style="min-width: 100%">-->           
            <div class="mx-2">
        <img src="getImage.jsp?id=<%= imageId %>" class="mr-3" alt="<%= imageName %>" style="width: 50px; height: 50px;">
    </div>            
   
          <% 
           }
           
                        
           }else{
           
 }
       %>        

</div></a>





 <%   
     }else if(action.equalsIgnoreCase("unlike") && seen==0){
 
//    String ge = "<p class='alert border-0 alert-secondary '><strong>"+reacter_id+"  Unfollowed you! ushaka wamwishyura!</strong><i class='fas fa-smile'></i   ></p>";

      PreparedStatement q = conn.prepareStatement("SELECT * FROM blogs WHERE blog_id = ?");
                        q.setString(1,blogd );
                        ResultSet resultSeto = q.executeQuery();
                        if(resultSeto.next()){
                        int imageId = resultSeto.getInt("blog_id");
            String imageName = resultSeto.getString("image_name");
            String imageDescription = resultSeto.getString("image_data");  
            int likeall=resultSeto.getInt("likeshas"); 
            int lef=likeall-1; 
String path1="seenlike.jsp?notify="+notify_id+"&blogged=" +blogd;
// String urled = "updateform.jsp?id=" + id + "&fname=" + fname+
//                 "&lname=" + lname+ "&email=" + email+ "&province=" + province+
//                 "&dob=" + dob+ "&gender=" + gender; 
 %>
<a href="<%=path1%>"  style="text-decoration: none"class="">
    <div class="alert  d-flex align-items-center py-0 rounded-0">
    <div class="mx-2">
        <img src="img/rp-logo.jpg" class="mr-3 rounded-5" alt="Profile Image" style="width: 50px; height: 50px;">
    </div>
    <div class="flex-grow-1">
        <strong><span id="reacter_id"><%=reacter_id%></span> </strong> unliked you post! <small>4hours ago</small>
    </div>
       <%
            
if(!(imageName.equals(""))){
           %>
<!--<img src="getImage.jsp?id=" class="mg img-thumbnail border-0 border-none " style="min-width: 100%">-->           
            <div class="mx-2">
        <img src="getImage.jsp?id=<%= imageId %>" class="mr-3" alt="<%= imageName %>" style="width: 50px; height: 50px;">
    </div>            
   
          <% 
           }
           
                        
           }else{
           
 }
       %>        

</div></a>





 <%   
      }else if(action.equalsIgnoreCase("unlike") && seen==1){
//   String path1="seenlike.jsp?notify="+notify_id;
//    String ge = "<p class='alert border-0 '><strong>"+reacter_id+"  Unfollowed you! ushaka wamwishyura!</strong><i class='fas fa-smile'></i   ></p>";

      PreparedStatement q = conn.prepareStatement("SELECT * FROM blogs WHERE blog_id = ?");
                        q.setString(1,blogd );
                        ResultSet resultSeto = q.executeQuery();
                        if(resultSeto.next()){
                        int imageId = resultSeto.getInt("blog_id");
            String imageName = resultSeto.getString("image_name");
            String imageDescription = resultSeto.getString("image_data");  
            int likeall=resultSeto.getInt("likeshas"); 
            int lef=likeall-1;
String path1="seenlike.jsp?notify="+notify_id+"&blogged=" +blogd;
 %>
<a href="<%=path1%>"  style="text-decoration: none;"class="">
<div  class="alert  text-muted border-0 d-flex align-items-center py-0 my-1 rounded-0">
    <div class="mx-2">
        <img src="img/rp-logo.jpg" class="mr-3 rounded-5" alt="Profile Image" style="width: 50px; height: 50px;">
    </div>
    <div class="flex-grow-1 ">
        <span id="reacter_id"><strong> <%=reacter_id%></strong></span> Recently unLiked your Post
        <small>4 days ago</small> 
        <!--<i class="fas fa-smile"></i>-->
    </div>
       <%
            
if(!(imageName.equals(""))){
           %>
<!--<img src="getImage.jsp?id=" class="mg img-thumbnail border-0 border-none " style="min-width: 100%">-->           
            <div class="mx-2">
        <img src="getImage.jsp?id=<%= imageId %>" class="mr-3 " alt="<%= imageName %>" style="width: 50px; height: 50px;">
    </div>            
   
          <% 
           }
           
                        
           }else{
           
 }
       %>        

</div></a>





 <%   
      }else if(action.equalsIgnoreCase("liked") && seen==1){
//    String path1="seenlike.jsp?notify="+notify_id;
//    String ge = "<p class='alert border-0 alert-secondary '><strong>"+reacter_id+"  Unfollowed you! ushaka wamwishyura!</strong><i class='fas fa-smile'></i   ></p>";

      PreparedStatement q = conn.prepareStatement("SELECT * FROM blogs WHERE blog_id = ?");
                        q.setString(1,blogd );
                        ResultSet resultSeto = q.executeQuery();
                        if(resultSeto.next()){
                        int imageId = resultSeto.getInt("blog_id");
            String imageName = resultSeto.getString("image_name");
            String imageDescription = resultSeto.getString("image_data");  
            int likeall=resultSeto.getInt("likeshas"); 
            int lef=likeall-1;
String path1="seenlike.jsp?notify="+notify_id+"&blogged=" +blogd;
 %>
<a href="<%=path1%>"  style="text-decoration: none"class="">
<div  class="alert  text-muted border-0 d-flex align-items-center py-0 my-1 rounded-0">
    <div class="mx-2">
        <img src="img/rp-logo.jpg" class="mr-3 rounded-5" alt="Profile Image" style="width: 50px; height: 50px;">
    </div>
    <div class="flex-grow-1 ">
        <span id="reacter_id"><strong> <%=reacter_id%></strong></span> and <%=lef%> others recently Liked your Post!
        on 
        <!--<i class="fas fa-smile"></i>-->
    </div>
       <%
            
if(!(imageName.equals(""))){
           %>
<!--<img src="getImage.jsp?id=" class="mg img-thumbnail border-0 border-none " style="min-width: 100%">-->           
            <div class="mx-2">
        <img src="getImage.jsp?id=<%= imageId %>" class="mr-3" alt="<%= imageName %>" style="width: 50px; height: 50px;">
    </div>            
   
          <% 
           }
           
                        
           }else{
           
 }
       %>        

</div></a>





 <%   
     }
             
%>
            
                     
                
 <%
                

       }
//if(resultSet.next()){
//
//}else{
// String ge = "<p class='alert border-0 alert-secondary text-center'><strong>Continue by Following your intrested in expole and post your blogs to enjoy!!</strong></p>";
//out.print(ge);
//}
    
        }catch(Exception e){ 
         out.print(e.getMessage());
        } 
%>

</div>
<script>
    
    
</script>

<div hidden=""><%@ include file="footer.jsp" %></div>