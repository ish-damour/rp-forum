<%@ include file= "header.jsp"%>
  <div class="container">
    <div class="row mt-5">
      <div class="col-md-6 offset-md-3">
        <div class="card login-form">
          <div class="card-body">
            <h2 class="text-center mb-4">Login to RP-FORUM</h2>
            <form class="row p-3" method="POST" action="loginLogic.jsp">
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
          </div>
        </div>
      </div>
    </div>
  </div>
<%@ include file="footer.jsp" %>