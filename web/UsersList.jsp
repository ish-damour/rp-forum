<%@ include file= "header.jsp"%>
<%@ include file= "nav.jsp"%>
  <main class="container"> 
  <div class="row g-5 justify-content-center">  
    <div class="col-md-8">
        <div class="row justify-content-center"> 
            <div class="col-lg-8"> 
               
 <%@ include file="connections.jsp" %>
<%
try {
    int logid = (int) session.getAttribute("loggedid");
    PreparedStatement psSelect = conn.prepareStatement("SELECT * FROM users WHERE user_id != ?");
    psSelect.setInt(1, logid);
    ResultSet resultSet = psSelect.executeQuery();

    while (resultSet.next()) {
        String usernam = resultSet.getString("username");
        int followingid = resultSet.getInt("user_id");

        PreparedStatement psSelectfollow = conn.prepareStatement("SELECT * FROM follow WHERE follower_id = ? AND following_id = ?");
        psSelectfollow.setInt(1, logid);
        psSelectfollow.setInt(2, followingid);
        ResultSet resultSetfollow = psSelectfollow.executeQuery();

        boolean isFollowing = resultSetfollow.next(); // Check if the user is already following

%>
        <div class="flex-fill d-flex flex-row gap-3 mt-3 mb-2">
            <div class="col-lg-12">
                <form method="post" action="#">
                <button class="btn btn-sm btn-default" type="submit" name="profils">
                    <div class="d-flex align-items-center col-lg-10"> <!-- Use flexbox to align items horizontally -->
                        <div class="mr-2"> <!-- Add margin to separate the image from the text -->
                            <img class="link-secondary" style="border-radius: 50%" src="img/rp-logo.jpg" width="40px" height="40px">
                        </div>
                        <div class="m-2 col-lg-2"><%= usernam %></div>
                    </div>
                </button></form>
            </div>
            <div class="mt-1  flex-fill">
                <div class="d-flex flex-row ">
                    <div><form method="post" action="followunfollow.jsp">
                        <% if (isFollowing) { %>
                        <input type="hidden" value="<%=followingid %>" name="followingidi">
                        <button class="btn btn-sm btn-secondary" type="submit" name="unfollow">Unfollow</button>
                        <% } else { %>
                        <input type="hidden" value="<%=followingid %>" name="followingidi">
                        <button class="btn btn-sm btn-secondary" type="submit"name="follow">Follow</button>
                        <% } %>
                    </form></div>
                </div>
            </div>
        </div>
<%
    }

    resultSet.close();
    psSelect.close();
} catch (Exception e) {
    out.print(e);
}
%>

        </div> 
    </div> 
  </div>

</main>
            <%@ include file="footer.jsp" %>