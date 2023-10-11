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
          String gid=request.getParameter("id");
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

String query = "SELECT blogs.blog_id, blogs.title, blogs.content, blogs.created_at, "
    + "blogs.image_name, blogs.image_data, blogs.likeshas, blogs.user_id, users.username, "
    + "latest_modifiers.last_modified FROM blogs "
    + "JOIN users ON blogs.user_id = users.user_id "
    + "LEFT JOIN (SELECT blogid, MAX(last_modified) AS last_modified "
    + "FROM modifier GROUP BY blogid) AS latest_modifiers ON blogs.blog_id = latest_modifiers.blogid "
    + "WHERE users.user_id = '" + gid + "' "
    + "ORDER BY COALESCE(latest_modifiers.last_modified, blogs.created_at) DESC";







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
            int imageId = resultSet.getInt("blog_id");
            String imageName = resultSet.getString("image_name");
            String imageDescription = resultSet.getString("image_data");
            int resultlike=resultSet.getInt("likeshas");
//         if(resultSet.next()){
         
  
//            while (resultSet.next()) {
                String username = resultSet.getString("username");                
                String created_at = resultSet.getString("created_at");
                String title = resultSet.getString("title");
                String fullText = resultSet.getString("content");
                String content = resultSet.getString("content");
                String truncatedText = fullText.substring(0, Math.min(fullText.length(), 50));
                request.setAttribute("truncatedText", truncatedText);
                request.setAttribute("fullText", fullText);
//                int imageId = resultSet.getInt("blog_id");
//            String imageName = resultSet.getString("image_name");

                int followingid = resultSet.getInt("user_id");
                
%>
    <div class="card mb-3">
<div class="card-header">
    <div class="row align-items-center">
        <div class="col-auto">
            <img class="link-secondary" style="border-radius: 50%" src="img/rp-logo.jpg" width="30px" height="30px">
        </div>
        <div class="col">
            <div class="flex flex-column">
                <div><%= username %></div>
            </div>
        </div>
        <div class="col">
            <div><small><%@include file="foll.jsp" %></small></div>
        </div>
        <div class="col">
            <div><small><%= created_at %></small></div>
        </div>
    </div>
</div>

                  <%
        String url = "getblogid.jsp?id=" + imageId;
    %>
        <div class="card-body"> 
           <a href="<%= url %>" class="nav-link "> <h3><%=title%></h3>
            <p id="truncatedContent">
                    <%
                    if(fullText.length()>50){
                        %>
                        
                       <%= truncatedText+"  <strong>...Seemore</strong>" %> 
                       
                       <%
                        }else{
                        %>
                        
                       <%= truncatedText %> 
                       
                       <% 
                           }
                    %>   
                    
                
                </p>
<img src="getImage.jsp?id=<%= imageId %>" alt="<%= imageName %>" class="mg img-thumbnail border-0 border-none " style="min-width: 100%">

        </a> </div>
<!--            <form action="likelogic.jsp" method="post">-->
        
               
<div class="card-footer">
    <div class="d-flex gap-3"> 
        <input type="text" value="<%=imageId%>" name="hiddenblogid" hidden>
        <%
        // Check if the user already liked the blog
        PreparedStatement psSelectl = conn.prepareStatement("SELECT * FROM likes WHERE blog_id = ? AND likedby_id = ? and liked=?");
        psSelectl.setInt(1, imageId);
        psSelectl.setInt(2, loggedid);
        psSelectl.setInt(3, 1);
        ResultSet resultSetl = psSelectl.executeQuery();

        if (resultSetl.next()) {
        %>

            <div class="flex-fill">
                <form method="post" action="likelogic.jsp" >
                    <input type="text" value="<%=imageId%>" name="hiddenblogid" hidden>
            <input type="hidden" name="previousPage" value="<%= request.getRequestURI() %>#target-anchor"">
            <button class="btn btn-default" name="like"><strong><%= resultlike %>
                <i class="fas fa-heart"></i>
                Liked</strong>
            </button></form>
        </div>
        <%
        } else {
        %>
        <div class="flex-fill">
                    <form method="post" action="likelogic.jsp" >
                    <input type="text" value="<%=imageId%>" name="hiddenblogid" hidden>
            <input type="hidden" name="previousPage" value="<%= request.getRequestURI() %>#target-anchor"">
            <button class="btn btn-default" name="like"><%= resultlike %>
                <i class="far fa-heart"></i>
                Like
            </button></form>
        </div>
        <%
        }

        PreparedStatement psSelectcomment = conn.prepareStatement("SELECT count(blogid) as totalcomment FROM comment WHERE blogid =?");
        psSelectcomment.setInt(1, imageId);
        ResultSet resultSetlcomment = psSelectcomment.executeQuery();
        if (resultSetlcomment.next()) {
            String totalcomment = resultSetlcomment.getString("totalcomment");
        %>
        <a href="<%= url %>" class="nav-link ">
            <div class="flex-fill">
                <strong><%= totalcomment %> <i class="far fa-comment"></i>
                    Comment
                </strong>
            </div>
        </a>
        <%
        }
        PreparedStatement psdeletebtn = conn.prepareStatement("SELECT * FROM blogs WHERE user_id =? and blog_id=?");
        psdeletebtn.setInt(2, imageId);
        psdeletebtn.setInt(1, loggedid);
        ResultSet resultSetdeletebtn = psdeletebtn.executeQuery();
        if (resultSetdeletebtn.next()) {
        %>
        <div class="flex-fill text-danger">
            <%@include file="deleteconfir.jsp" %>
        </div>
        <%
        }

        // Check if the user already saved the blog
        PreparedStatement psSelects = conn.prepareStatement("SELECT * FROM saved WHERE blogid = ? AND savedby = ? and saved=?");
        psSelects.setInt(1, imageId);
        psSelects.setInt(2, loggedid);
        psSelects.setInt(3, 1);
        ResultSet resultSetsavedbtn = psSelects.executeQuery();
        
        if (resultSetsavedbtn.next()) {
        String blogsave=resultSetsavedbtn.getString("blogid");
        %>
        
        <div class="flex-fill">
            <form method="post" action="savelogic.jsp">
            <input type="hidden" name="previousPage" value="<%=imageId %>"">
            <input type="hidden" name="hiddenblogid" value="<%=imageId %>"">
            <button class="btn btn-default" name="unsave" type="submit"><strong>
                    <i class="fas fa-star-half-alt"></i>
                    Saved
                </strong>
            </button>      
        </div>
        <%
        } else {
        %>
        <div class="flex-fill">
             <form method="post" action="savelogic.jsp">
            <input type="hidden" name="previousPage" value="<%=imageId %>">
            <input type="hidden" name="hiddenblogid" value="<%=imageId %>"">
            <button class="btn btn-default" name="saving" type="submit">
                <i class="fas fa-download"></i>
                Save
            </button></form>
            
        </div>
  
        <%
        }
        %>
    </div>
</div>

            <!--</form>-->
      </div>          
                
 <%
                

       }
if(resultSet.next()){

}else{
 String ge = "<p class='alert alert-secondary text-center'><strong>Continue by Following your intrested in expole and post your blogs to enjoy!!</strong></p>";
out.print(ge);
}
    
        }catch(Exception e){ 
         out.print(e.getMessage());
        } 
%>

</div>
<div hidden=""><%@ include file="footer.jsp" %></div>