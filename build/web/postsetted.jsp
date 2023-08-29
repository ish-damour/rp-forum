<%@ page import="java.io.*, java.sql.*" %>
<%@ include file="connections.jsp" %>
<div class="flex flex-column gap-4">
    <%
        try{
//            PreparedStatement psSelect = 
//            conn.prepareStatement("SELECT * FROM blogs,users where users.user_id=blogs.user_id");
//            ResultSet resultSet = psSelect.executeQuery();
            int idi=(int)session.getAttribute("idgetted");
            int loggedid = (int) session.getAttribute("loggedid");
            
            String query = "SELECT blogs.*,users.* FROM blogs,users where users.user_id=blogs.user_id and blogs.blog_id="+idi;
            String querycomment = "SELECT  * FROM comment,blogs,users where"
                                    + " users.user_id=comment.commentedbyid "
                                    + "and comment.blogid=blogs.blog_id "
                                    + "and blogs.blog_id="+idi+""
                                    + " order by comment.created_at desc";
            Statement statement = conn.createStatement();
            ResultSet  resultSet = statement.executeQuery(query);
            if(resultSet.next()){
            
                int imageId = resultSet.getInt("blog_id");
                String imageName = resultSet.getString("image_name");
                String imageDescription = resultSet.getString("image_data");
                String likehas = resultSet.getString("likeshas");
                String commenthas=resultSet.getString("likeshas"); 
             
                String username = resultSet.getString("username");                
                String created_at = resultSet.getString("created_at");
                String title = resultSet.getString("title");
                String fullText = resultSet.getString("content");
                String content = resultSet.getString("content");
                String truncatedText = fullText.substring(0, Math.min(fullText.length(), 50));
                request.setAttribute("truncatedText", truncatedText);
                request.setAttribute("fullText", fullText); 
                int followingid = resultSet.getInt("user_id");
            %>
            
            <div class="card mb-3">
                <div class="card-header">
                    <a href="profile.jsp?id=<%= followingid %>" class=" d-flex gap-3">
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
                  </a>
                </div>
                <div class="card-body"> 
                    <h3><%=title%></h3> 
                    <p><%= fullText %> </p>

 <img src="getImage.jsp?id=<%= imageId %>" alt="<%= imageName %>" class="mg img-thumbnail border-0 border-none " style="min-width: 100%">
                </div>
                <div class="card-footer">
                    <div class="d-flex gap-3"> 
                    <input type="text" value="<%=imageId%>" name="hiddenblogid" hidden> 
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
                      <form action="likelogic.jsp" method="post" ">           
                    <input type="text" value="<%=imageId%>" name="hiddenblogid" hidden>
            <input type="hidden" name="previousPage" value="<%= request.getRequestURI() %>#target-anchor"">
                      <button class="btn btn-default" name="like"><strong><%=likehas%>
                        <i class="fas fa-heart"></i>
                        Liked</strong>
            </button></form>
        </div>                  
                  <%  
                      }else{
                  %>
        <div class="flex-fill">
                    <form method="post" action="likelogic.jsp" >       
                    <input type="text" value="<%=imageId%>" name="hiddenblogid" hidden>
            <input type="hidden" name="previousPage" value="<%= request.getRequestURI() %>#target-anchor"">
                      <button class="btn btn-default" name="like"><%=likehas%>
                   <i class="far fa-heart"></i>
                       Like           
                      </button>
                    </form>
                     </div>               
                  <%    
                      }
                  %>
                    <div> 
                  <%    
       PreparedStatement    psSelectcomment = conn.prepareStatement("SELECT count(blogid) as totalcomment FROM comment WHERE blogid =?");
            psSelectcomment.setInt(1, idi);
            ResultSet  resultSetlcomment= psSelectcomment.executeQuery();  
if(resultSetlcomment.next()){
String totalcomment=resultSetlcomment.getString("totalcomment");
    %>
                         
                  <div class="flex-fill">
                      <strong><%=totalcomment %> <i class="far fa-comment"></i>
                      Comment
                      </strong> </div>
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
           
                  
           <!--comment--> 
           <%
                ResultSet  resultSetcomment = statement.executeQuery(querycomment);               
                %>
                <div class="row gap-3 p-4">
                    <form action="commentlogic.jsp" method="post" class="d-flex">
                        <input type="text" value="<%=imageId%>" name="hiddenblogid" hidden> 
                        <textarea class="form-control rounded-0" name="commenttext"></textarea>
                        <button class="btn btn-primary rounded-0" type="submit" name="addcomment"><i class="fas fa-paper-plane"></i></button>
                    </form>
                    <hr class="m-1 p-2">
                    Recent comments
                   <% while(resultSetcomment.next()){
                     String commentedby=resultSetcomment.getString("username");
                      String contentcomm=resultSetcomment.getString("comment"); 
                    String created_at_comment=resultSetcomment.getString("created_at"); 
                   %>
                     <div class="d-flex flex-column ">
                         <div class="d-flex flex-row text-muted">
                             <div class="flex-fill">
                                 <small> <%= commentedby %></small>
                             </div>
                              <div class="">
                                  <small> <%= created_at_comment %></small>
                             </div> 
                         </div> 
                            <p style="overflow-wrap: break-word;">
                        
                            <%= contentcomm%> 
                            </p>
                        </div>
                     <% }%>
                </div> 
               
            <% 
            
        }else{
            out.print("no results");
        }
        %>
         </div>
         <%
        }catch(Exception e){ 
         out.print(e.getMessage());
        } 
    %>
</div>
<%@ include file="footer.jsp" %>