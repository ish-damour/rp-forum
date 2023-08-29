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

              PreparedStatement psSelect = conn.prepareStatement("select * from users where email = ?");

              psSelect.setString(1, email);  

              ResultSet resultSet = psSelect.executeQuery(); 

               if(resultSet.next()){ 
               String username=resultSet.getString("username");
               session.setAttribute("usernam",username);
                session.setAttribute("email", email);
                session.setAttribute("forgetpass","forgetpass");

                request.getRequestDispatcher("Confirmemail").forward(request, response);
       }else{
       message = "<p class='alert alert-danger text-center'> Email not Found </p>"+email;
       }
        }catch(Exception e){
         message = "<p class='alert alert-danger text-center'>"+ e +"</p>";
        }    
        
    }
     %>

  
  
  
  
          <div class="card-body">
            <h2 class="text-center mb-4">Enter Your Email to Recover Password</h2>
            <form class="row gap-3" method="post"> 
                <%= message %>
                  <div class="mb-3">
                    <label for="location" class="form-label">Email</label>
                    <input type="Email" class="form-control" name="useremail" id="Email" placeholder="Your Email.." required>
                  </div>
                <div class="mb-3">
                    <button type="submit" class="w-100 btn btn-block btn-secondary">Confirm</button>
                </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
<%@ include file="footer.jsp" %>

