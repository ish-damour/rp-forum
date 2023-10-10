<%@ include file= "header.jsp"%>
  <div class="container">
    <div class="row mt-5">
      <div class="col-md-6 offset-md-3">
        <div class="card login-form">      
  <%@ include file="connections.jsp" %>    
  
   <%
 
        if ("POST".equals(request.getMethod())) {
            try{ 
            
                String email = request.getParameter("useremail");
                String username = request.getParameter("userename");   
            if(email != null  && username!=null){
            
        
              PreparedStatement psSelect = conn.prepareStatement("select * from users where email = ? or username= ? ");

              psSelect.setString(1, email); 
              psSelect.setString(2, username); 

              ResultSet resultSet = psSelect.executeQuery(); 

               if(resultSet.next()){ 
               if(resultSet.getString("email").equalsIgnoreCase(email)){
                message = "<p class='alert alert-danger text-center'><strong>Email is already used</strong></p>";
                 }else{
             message = "<p class='alert alert-danger text-center'><strong>Username is already used</strong></p>";
                         }
                    

                }
                else{
                session.setAttribute("username", username);
                session.setAttribute("email", email);
                session.setAttribute("confirmmail", "confirmmail");
                        request.getRequestDispatcher("Confirmemail").forward(request, response);
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
            <h2 class="text-center mb-4">Enter Your Email to Continue</h2>
            <form class="row gap-3" method="post"> 
                <%= message %>
                  <div class="mb-3">
                    <label for="location" class="form-label">Email</label>
                    <input type="Email" class="form-control" name="useremail" id="Email" placeholder="Your Email..">
                  </div>
                                <div class="mb-3">
                    <label for="location" class="form-label">Username</label>
                    <input type="text" class="form-control" name="userename" id="userename" placeholder="Enter Your @username..">
                  </div>
                <div class="mb-3">
                    <button type="submit" class="w-100 btn btn-block btn-secondary" name="confirmmail">Confirm</button>
                </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
<%@ include file="footer.jsp" %>