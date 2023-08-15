<%-- 
    Document   : nav
    Created on : Aug 11, 2023, 7:32:16 PM
    Author     : Shallom
--%>

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
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
            <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
          </svg>
          </a>
        <a class="link-secondary" href="#" aria-label="Search">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="mx-3" role="img" viewBox="0 0 24 24"><title>Search</title><circle cx="10.5" cy="10.5" r="7.5"/><path d="M21 21l-5.2-5.2"/></svg>
        </a>
          
          <%  
            String nameDisplay=(String)session.getAttribute("loggedname");
            if(nameDisplay == null){
            %>
             <a class="btn btn-sm text-decoration-underline " href="login.jsp">Login</a>
            <%
              }else{
              %>
              <a class="btn btn-sm text-decoration-underline " href="login.jsp"> <%= nameDisplay %></a>
             <%

                }
            %>        
       

      </div>
    </div>
  </header>

  <div class="nav-scroller py-1 mb-3">
    <nav class="nav nav-underline flex flex-row justify-content-around ">
      <a class="nav-item nav-link link-body-emphasis active " href="index.jsp">Home</a>
      <a class="nav-item nav-link link-body-emphasis" href="UsersList.jsp">Explore</a>
      <a class="nav-item nav-link link-body-emphasis" href="#">Trends</a>
      <a class="nav-item nav-link link-body-emphasis" href="#">Saved</a> 
    </nav>
  </div>
</div>
       