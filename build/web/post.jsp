<%@ page import="java.io.*, java.sql.*" %>
<%@ include file="connections.jsp" %>
<div class="flex flex-column gap-4">
<%
        
                          String bloggetted = (String) session.getAttribute("blogliked");
                       %>   <%=bloggetted %>
  <%      try{
//            PreparedStatement psSelect = 
//            conn.prepareStatement("SELECT * FROM blogs,users where users.user_id=blogs.user_id");
//            ResultSet resultSet = psSelect.executeQuery();
         int loggedid = (int) session.getAttribute("loggedid");
         String query = "SELECT blogs.blog_id, blogs.title, blogs.content, blogs.created_at,blogs.image_name,blogs.image_data,blogs.likeshas,blogs.user_id,users.username,latest_modifiers.last_modified FROM blogs JOIN users ON blogs.user_id = users.user_id LEFT JOIN (SELECT blogid, MAX(last_modified)"
         + " AS last_modified FROM modifier GROUP BY blogid) AS latest_modifiers ON blogs.blog_id  = latest_modifiers.blogid ORDER BY COALESCE(latest_modifiers.last_modified, blogs.created_at) DESC";
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
          <div class=" d-flex gap-3">
              <div>
                  <img class="link-secondary" style="border-radius: 50%" src="img/rp-logo.jpg" width="30px" height="30px">
              </div>
              <div class="flex-fill">
                  <div class="flex flex-column">
                      <div><%= username%></div> 
                  </div>
              </div>
              <div>
                  <small><%=created_at%> </small>
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
            <form action="likelogic.jsp" method="post">
                <input type="text" value="<%=imageId%>" name="hiddenblogid" hidden>
          <div class="card-footer">
              <div class=" d-flex gap-3"> 
                  <%
             // Check if the user already liked the blog
            PreparedStatement psSelectl = conn.prepareStatement("SELECT * FROM likes WHERE blog_id = ? AND likedby_id = ? and liked=?");
            psSelectl.setInt(1, imageId);
            psSelectl.setInt(2,loggedid);  
            psSelectl.setInt(3,1);  
            ResultSet  resultSetl = psSelectl.executeQuery();            
                  
                  if(resultSetl.next()){
                %>
                  <div class="flex-fill">           
                      <input type="hidden" name="previousPage" value="<%= request.getRequestURI() %>#target-anchor"">
                      <button class="btn btn-default" name="like"><strong><%=resultlike%>
                        <i class="fas fa-heart"></i>
                        Liked</strong>
                      </button>
                  </div>                  
                  <%  
                      }else{
                  %>
                  <div class="flex-fill">            
                      <input type="hidden" name="previousPage" value="<%= request.getRequestURI() %>#target-anchor"">
                      <button class="btn btn-default" name="like"><%=resultlike%>
                   <i class="far fa-heart"></i>
                       Like</button>
                  </div>                  
                  <%    
                      }
                  %>
                  

                      
                      
                  <div class="flex-fill">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-left" viewBox="0 0 16 16">
                      <path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                    </svg>  Comment
                  </div>
                   <div class="flex-fill text-danger">
                     <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                      <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6Z"/>
                      <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1ZM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118ZM2.5 3h11V2h-11v1Z"/>
                    </svg> Delete
                  </div>
                   <div class="flex-fill">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-down" viewBox="0 0 16 16">
                          <path fill-rule="evenodd" d="M3.5 10a.5.5 0 0 1-.5-.5v-8a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 .5.5v8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 0 0 1h2A1.5 1.5 0 0 0 14 9.5v-8A1.5 1.5 0 0 0 12.5 0h-9A1.5 1.5 0 0 0 2 1.5v8A1.5 1.5 0 0 0 3.5 11h2a.5.5 0 0 0 0-1h-2z"/>
                          <path fill-rule="evenodd" d="M7.646 15.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 14.293V5.5a.5.5 0 0 0-1 0v8.793l-2.146-2.147a.5.5 0 0 0-.708.708l3 3z"/>
                        </svg>Save
                  </div>
              </div>
          </div></form>
      </div>          
                
 <%
                

       }
    
        }catch(Exception e){ 
         out.print(e.getMessage());
        } 
%>

</div>
<%@ include file="footer.jsp" %>