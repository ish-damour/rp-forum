  <div class="flex-fill d-flex flex-row gap-3 mt-3 mb-2">
        <div>
            <img class="link-secondary" style="border-radius: 50%" src="img/rp-logo.jpg" width="40px" height="40px">
        </div>
        <div class="mt-1  flex-fill">
            <div class="d-flex flex-row ">
                <%
                    String loggednam=(String)session.getAttribute("loggedname"); %>
                <div class="flex-fill"><%=loggednam %></div> 
                <div><button class="btn btn-sm btn-secondary">Follow</button></div>  
            </div>
        </div>
    </div>