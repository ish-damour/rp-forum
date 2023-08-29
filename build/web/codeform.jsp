<%@ include file= "header.jsp"%>
  <div class="container">
    <div class="row mt-5">
      <div class="col-md-6 offset-md-3">
        <div class="card login-form">      
  <%@ include file="connections.jsp" %>            
          <div class="card-body">
                      <span><%
            String imes=(String)session.getAttribute("result");
            String imel=(String)session.getAttribute("email");
            String icodes=(String)session.getAttribute("codes");
            String inam=(String)session.getAttribute("username");
            %><%=imes%> <%=imel%></span>
            <h2 class="text-center mb-4">Enter Confirm code You received</h2>
            <form class="row gap-3" action="verifycode.jsp" method="post"> 
                <%= message %>
                <input type="text" class="form-control"  value="<%=imel%>" id="Email"  disabled="">
                <input type="text" class="form-control"  value="<%=inam%>" id="Email" disabled>
          <input type="text" class="form-control" name="emailgot"  value="<%=imel%>" id="Email" hidden>
          <input type="text" class="form-control" name="namegot" value="<%=inam%>" id="Email" hidden >
                <input type="text" class="form-control" name="codegot" value="<%=icodes%>" id="Email" hidden >
                                <div class="mb-3">
                    <label for="location" class="form-label">Codes</label>
                    <input type="text" class="form-control" name="authcode" id="username" placeholder="Enter Confirmation code">
                  </div>
                <div class="mb-3">
                    <button type="submit" class="w-100 btn btn-block btn-secondary">Confirm</button>
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

