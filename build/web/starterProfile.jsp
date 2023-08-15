    <div class="col-lg-12">
        <div class="row gap-3 space-3 ">
            <div class=" d-flex gap-3 mt-3 mb-2">
                <div>
                    <img class="link-secondary" style="border-radius: 50%" src="img/rp-logo.jpg" width="60px" height="60px">

                </div>
                <div class="mt-1">
                    <div class="flex flex-column">
                        <div><% 
                            String mail=(String)session.getAttribute("loggedemail"); 
                            String name=(String)session.getAttribute("loggedname"); 
                            out.print(name);
                           %></div>
                        <div >
                            <a href="">Edit</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="d-flex gap-3 justify-content-around">
                
                <div>
                   0 Followers
                </div>
                 <div>
                  0 Following
                </div>
                 <div>
                  0 posts
                </div>
            </div> 
        </div>
            <hr><!-- comment -->
            <h5 class="link-body-emphasis mb-1">Suggested users</h5>
            
            <div class="d-flex flex-column gap-3 justify-content-start">
                 <%@ include file="userCard.jsp"%> 
                 <div class="flex-fill d-flex flex-row gap-3 mt-3 mb-2">
                    <div>
                        <img class="link-secondary" style="border-radius: 50%" src="img/rp-logo.jpg" width="40px" height="40px">

                    </div>
                    <div class="mt-1  flex-fill">
                        <div class="d-flex flex-row ">
                            <div class="flex-fill">Admin</div> 
                            <div><button class="btn btn-sm btn-secondary">Follow</button></div>  
                        </div>
                    </div>
                </div>
            </div>
            
            <%@ include file="footer.jsp" %>
       

    </div>