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
            <h2 class="text-center mb-4">Enter Recover code You received</h2>
            <form class="row gap-3" action="verifyrecoverycode.jsp" method="post"> 
                <%= message %>
                <input type="text" class="form-control"  value="<%=imel%>" id="Email" disabled="" >
                <input type="text" class="form-control"  value="<%=inam%>" id="Email" disabled="" >               
                
                <input type="text" class="form-control" name="emailgot" value="<%=imel%>" id="Email" hidden >
                <input type="text" class="form-control" name="namegot" value="<%=inam%>" id="Email" hidden >
                    <input type="text" class="form-control" name="codegot" value="<%=icodes%>" id="Email" hidden>
                                <div class="mb-3">
                    <label for="location" class="form-label">Codes</label>
                    <input type="text" class="form-control" name="authcode" id="username" placeholder="Enter Confirmation code">
                  </div>
                <div class="mb-3">
                    <button type="submit" class="w-100 btn btn-block btn-secondary">Recovery</button>
                </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
<%@ include file="footer.jsp" %>