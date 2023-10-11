<%-- 
    Document   : nav
    Created on : Aug 11, 2023, 7:32:16 PM
    Author     : Shallom
--%>
<%@ include file="connections.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="container position-sticky top-0 bg-body-tertiary " style="z-index:99" >
  <header class="border-bottom lh-1 py-3">
    <div class="row flex-wrap justify-content-between align-items-center">
      <div class="col-4 pt-1">
          <img class="link-secondary" src="img/rp-logo.jpg" width="40px" height="40px">
      </div>
      <div class="col-4 text-center">
        <a class="blog-header-logo text-body-emphasis text-decoration-none" href="#">RP FORUM </a>
      </div>
      <div class="col-4 d-flex flex-wrap justify-content-end align-items-center gap-2">
          
          <a href=""  class="link-secondary">
   
          </a>
        <a class="link-secondary" href="#" aria-label="Search">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="mx-3" role="img" viewBox="0 0 24 24"><title>Search</title><circle cx="10.5" cy="10.5" r="7.5"/><path d="M21 21l-5.2-5.2"/></svg>
        </a>
          
   <form method="POST" action="logout.jsp">          
          <%  
            String nameDisplay=(String)session.getAttribute("loggedname");
            if(nameDisplay == null){
            %>
            <button class="btn btn-sm" name="out" type="submit"><strong>
             <img class="link-secondary mr-1" style="border-radius: 50%" src="img/rp-logo.jpg" width="30px" height="30px"> 
                 <%= nameDisplay %></strong></button><i class="fas fa-users" ></i>
          <%
              }else{
            %>   
        <div class="d-flex align-items-center">
            

                <button class="btn btn-sm " name="out" type="submit"><strong>
                        <img class="link-secondary mr-1" style="border-radius: 50%" src="img/rp-logo.jpg" width="30px" height="30px"> 
                        <%= nameDisplay %> <i class="fas fa-sign-out-alt text-danger"></i></strong></button>
            </form>


             <%

                }
            %>        

      </div>
    </div>
  </header>

 <div class="nav-scroller py-1 mb-3">
    <nav class="nav nav-underline flex flex-row justify-content-around ">
      <a class="nav-item nav-link link-body-emphasis active " href="index.jsp"><i class="fas fa-home"></i></a>
      <a class="nav-item nav-link link-body-emphasis" href="users.jsp"><i class="fas fa-users"></i>
</a>
      <a class="nav-item nav-link link-body-emphasis" href="trending.jsp"><i class="fas fa-compass"></i>
</a>
      <a class="nav-item nav-link link-body-emphasis" href="savedpage.jsp"><i class="fas fa-star-half-alt"></i>
</a> 
  
      
  <%      try{

          int loggedid = (int) session.getAttribute("loggedid");

//String query="SELECT f.notify_id, f.owner_id, f.reacter_id, f.action, f.seen, f.created_at, u.username AS reacter_username, u.email AS reacter_email FROM notify f INNER JOIN users u ON f.reacter_id = u.user_id WHERE f.owner_id = '" + loggedid + "'UNION SELECT l.notify_id, l.owner_id, l.reacter_id, l.action, l.seen, l.created_at,"
//+ " u.username AS reacter_username, u.email AS reacter_email FROM notifyblog l"
//+ " INNER JOIN users u ON l.reacter_id = u.user_id INNER JOIN blogs b "
//+ "ON l.owner_id = b.blog_id"
//+ " WHERE b.user_id ='" + loggedid + "'";          
          
String query = "SELECT (SELECT COUNT(*) FROM notify WHERE owner_id = '" + loggedid + "' AND seen = 0) as notify_count, (SELECT COUNT(*) FROM notifyblog nb JOIN blogs b ON nb.owner_id = b.blog_id WHERE b.user_id = '" + loggedid + "' AND nb.seen = 0) as notifyblog_count;";


// Execute this query and fetch the result

        Statement statement = conn.createStatement();
      ResultSet  resulSet = statement.executeQuery(query);

        if (resulSet.next()) {
        
      
            int countseen = resulSet.getInt("notifyblog_count");
            int countnotfyseen = resulSet.getInt("notify_count");
            int allseen =countseen+countnotfyseen ;
              if(allseen>0){
                %>
<a class="nav-item nav-link link-body-emphasis position-relative" href="notification.jsp">
    <i class="fas fa-bell"></i>
    <strong class="translate-middle badge rounded-pill bg-danger">
        <%=allseen%>
        <!--<sup>+</sup>-->
        <span class="visually-hidden">unread messages</span>
    </strong>
</a>

      <%               
      }else{
              %>
        <a class="nav-item nav-link link-body-emphasis" href="notification.jsp"><i class="far fa-bell"></i></a> 
      <% 
      
      }
   

}else{
              %>
        <a class="nav-item nav-link link-body-emphasis" href="notification.jsp"><i class="far fa-bell"></i></a> 
      <% 

      }
    
        }catch(Exception e){ 
         out.print(e.getMessage());
        } 
%>     
      

      

         
      
      
      
      
      
    </nav>
  </div>
</div>
       