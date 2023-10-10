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
      <a class="nav-item nav-link link-body-emphasis" href="UsersList.jsp"><i class="fas fa-compass"></i>
Explore</a>
      <a class="nav-item nav-link link-body-emphasis" href="trending.jsp"><i class="fas fa-binoculars"></i>
Trends</a>
      <a class="nav-item nav-link link-body-emphasis" href="savedpage.jsp"><i class="fas fa-star-half-alt"></i>
Saved</a> 
      
      
  <%      try{

          int loggedid = (int) session.getAttribute("loggedid");

String query="SELECT count(seen) as seen FROM notify where owner_id='" + loggedid + "' and notify.seen=0";
        Statement statement = conn.createStatement();
      ResultSet  resulSet = statement.executeQuery(query);

        if (resulSet.next()) {
        
      
            int countseen = resulSet.getInt("seen");
              if(countseen>0){
                %>
<a class="nav-item nav-link link-body-emphasis position-relative" href="notification.jsp">
    <i class="fas fa-bell"></i>
    <strong class="translate-middle badge rounded-pill bg-danger">
        <%=countseen%>
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
       