<%@ include file= "header.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
  <div class="container">
    <div class="row mt-5">
      <div class="col-md-6 offset-md-3">
        <div class="card login-form">
          <div class="card-body">
            <h2 class="text-center mb-4">Login to RP-FORUM</h2>
            <form class="row p-3" method="POST">
			<span class="messagern text-danger"></span>
				<div class="col-lg-12 mt-3"> 
					<label class="">Username or email address</label>
					<input type="text" id="email_username" name="email" placeholder="Username / Email" class="form-control <?php echo $style ?>" autocomplete autofocus>
						</div>
						<div class="col-lg-12 mt-4">
							<div class="d-flex flex-row">
							<label class="flex-grow-1">Password</label>
							<a href="forgot.php" class="text-danger">Forgot password ?</a>
						</div> 
						<input type="Password" id="password" name="password" placeholder="Enter Password" class="form-control <?php echo $style ?>">
					</div>
				<div class="col-lg-12 logined  mt-3">
			<button type="submit" name="login" class="btn btn-primary form-control">Sign in</button>
                    </div>
		</form>
             <% 
                   if ("POST".equals(request.getMethod())) {
                   
                       String email = request.getParameter("email");
                      String password = request.getParameter("password");
                      try{
                          %> 
                          <%@ include file="connections.jsp" %>
                          <%
                         if (email!=null &&password !=null) {      
                            PreparedStatement psSelect = conn.prepareStatement("select * from users where email = ? and password = ? ");

                            psSelect.setString(1, email);
                            psSelect.setString(2, password);  

                            ResultSet resultSet = psSelect.executeQuery();

                            if(resultSet.next()){
                                int loggedid=resultSet.getInt("user_id");
                                String loggedemail = resultSet.getString("email");   
                                String loggedname = resultSet.getString("username");

                                session.setAttribute("loggedemail", loggedemail);
                                 session.setAttribute("loggedname", loggedname);
                                 session.setAttribute("loggedid", loggedid);

                                response.sendRedirect("index.jsp");

                          }
                          else{ 
                          message = "<p class='alert alert-danger text-center'><strong>Invalid username/email or password</strong></p>";
                          
                            
                                  }
                              }
                              
                             }catch(Exception e){
                                out.print(e);

                           }
                    }
            %>
            <div class="col-lg-12 mt-3 logined btn"><%= message %></div>

          </div>
        <div class="col-lg-12 mt-3 containered rounded shadow-sm text-center p-3 text-muted">
        Don't you have in RP-forum? <a href="verify.jsp" class="mr-1">Create an account </a>.
        </div>
        </div>
      </div>
    </div>
  </div>
<%@ include file="footer.jsp" %>