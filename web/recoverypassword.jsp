<%@ include file= "header.jsp"%>
  <div class="container">
    <div class="row mt-5">
      <div class="col-md-6 offset-md-3">
        <div class="card login-form">      
  <%@ include file="connections.jsp" %>
    <%

 
        if ("POST".equals(request.getMethod())) {
            try{ 
            
                String username = request.getParameter("username");  
                String email =request.getParameter("email");
                String Password = request.getParameter("password");
                String C_Password = request.getParameter("cpassword");
 
            if(email != null && Password != null ){
                    if(Password.equals(C_Password)) {
                        PreparedStatement psInsert = conn.prepareStatement("update users  set password=? where email=? ");
                      
                       psInsert.setString(1,Password); 
                        psInsert.setString(2,email);
                        psInsert.execute(); 

                        response.sendRedirect("login.jsp");



           }else{  
           message = "<p class='alert alert-danger text-center'><strong> password does not match</strong></p>";

           }
        }else{
           message = "<p class='alert alert-danger text-center'> empty space found</p>";

        }
        }catch(Exception e){
         message = "<p class='alert alert-danger text-center'>"+ e +"</p>";
        }  }  
        
     %>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
          <div class="card-body">
            <h2 class="text-center mb-4">Create New Password</h2>
            <form class="row gap-3" method="post"> 
                <%= message %>
                  <div class="mb-3">
                    <label for="location" class="form-label">Email</label>
                    <input type="Email" value="<%=session.getAttribute("maile")%>" class="form-control" hidden="" name="email" id="Email" placeholder="Your Email..">
                    <input type="Email" value="<%=session.getAttribute("maile")%>" class="form-control" disabled id="Email" placeholder="Your Email..">
                  </div>
                                <div class="mb-3">
                    <label for="location" class="form-label">Username</label>
                    <input type="text" class="form-control" value="<%=session.getAttribute("namemail")%>"id="username" placeholder="Enter Your @username.." disabled="">
                    <input type="text" class="form-control" value="<%=session.getAttribute("namemail")%>" name="username" hidden id="username" placeholder="Enter Your @username..">
                  </div>
                        <div class="mb-3">
                    <label for="location" class="form-label">New Password</label>
                    <input type="password" class="form-control" name="password" placeholder="Enter your new password">
                  </div> 
                        <div class="mb-3">
                    <label for="password" class="form-label">Re-enter password</label>
                    <input type="password" class="form-control" name="cpassword" id="Re-enter password" placeholder="Re-enter password">
                  </div>
                <div class="mb-3">
                    <button type="submit" class="w-100 btn btn-block btn-secondary">Save</button>
                </div>
            </form>
          </div>
        <div class="col-lg-12 mt-3 containered rounded shadow-sm text-center p-3 text-muted">
        Already have an account in RP-forum? <a href="login.jsp" class="mr-1">Sign in </a>.
        </div>
        </div>
      </div>
    </div>
  </div>
<%@ include file="footer.jsp" %>

