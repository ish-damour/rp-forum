<%@ include file= "header.jsp"%>
  <div class="container">
    <div class="row mt-5">
      <div class="col-md-6 offset-md-3">
        <div class="card login-form">      
  <%@ include file="connections.jsp" %>
    <%
 
        if ("POST".equals(request.getMethod())) {
            try{ 
            
                String email = request.getParameter("email");
                String Password = request.getParameter("password");
                String C_Password = request.getParameter("cpassword");
                String fname = request.getParameter("fname");       
                String lname = request.getParameter("lname");
                String college = request.getParameter("college");
                String username = request.getParameter("username");   
            if(email != null && Password != null && fname != null && lname!=null && college != null && username!=null){
            
        
              PreparedStatement psSelect = conn.prepareStatement("select * from users where email = ? ");

              psSelect.setString(1, email); 

              ResultSet resultSet = psSelect.executeQuery(); 

               if(resultSet.next()){  
                     message = "<p class='alert alert-danger text-center'><strong>Email is already used</strong></p>";

                }
                else{
                    if(Password.equals(C_Password)) {
                        PreparedStatement psInsert = conn.prepareStatement("insert into users "
                        + "(`lname`,`fname`,`college`,`username`,`email`,`password`) "
                        + "values(?,?,?,?,?,?)");

                       psInsert.setString(1,lname);
                       psInsert.setString(2,fname);                      
                       psInsert.setString(3,college);                        
                       psInsert.setString(4,username);      
;                      psInsert.setString(5,email);   
                       psInsert.setString(6,Password); 

                        psInsert.execute(); 

                        response.sendRedirect("login.jsp");



           }else{  
           message = "<p class='alert alert-danger text-center'><strong>confirm password</strong></p>";

           }
        }
        }else{
           message = "<p class='alert alert-danger text-center'> empty space found</p>";

        }
        }catch(Exception e){
         message = "<p class='alert alert-danger text-center'>"+ e +"</p>";
        }    
        
    }
     %>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
          <div class="card-body">
            <h2 class="text-center mb-4">SignUp to RP-FORUM</h2>
            <form class="row gap-3" method="post"> 
                <%= message %>
                <div class="mb-3">
                    <label for="First_Name" class="form-label">First_Name</label>
                    <input type="text" class="form-control" name="fname" id="First_Name" placeholder="Your First_Name..">
                  </div>
                  <div class="mb-3">
                    <label for="Last_Name" class="form-label ">Last_Name</label>
                    <input type="text" class="form-control" name="lname" id="Last_Name" placeholder="Your Last_Name..">
                  </div>
                  <div class="mb-3">
                    <label for="location" class="form-label">Email</label>
                    <input type="Email" class="form-control" name="email" id="Email" placeholder="Your Email..">
                  </div>
                                <div class="mb-3">
                    <label for="location" class="form-label">Username</label>
                    <input type="text" class="form-control" name="username" id="username" placeholder="Enter Your @username..">
                  </div>
                        <div class="mb-3">
                    <label for="college" class="form-label">College</label>
                    <input type="text" class="form-control" name="college" id="college" placeholder="Your college">
                  </div>
                        <div class="mb-3">
                    <label for="location" class="form-label">Password</label>
                    <input type="password" class="form-control" name="password" placeholder="Enter your password">
                  </div> 
                        <div class="mb-3">
                    <label for="password" class="form-label">Re-enter password</label>
                    <input type="password" class="form-control" name="cpassword" id="Re-enter password" placeholder="Re-enter password">
                  </div>
                <div class="mb-3">
                    <button type="submit" class="w-100 btn btn-block btn-secondary">Create</button>
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

