<%@include file="loginblocker.jsp" %>  
<%@ include file= "header.jsp"%>
<%@ include file= "nav.jsp"%>
  <main class="container"> 
  <div class="row justify-content-center">  
      <div class="col-lg-4">
          <%@ include file="starterProfile.jsp"%>

      </div>
    <div class="col-md-8">
        <div class="row justify-content-center"> 
            <div class="col-lg-12 "> 
               

               <%
               try {
                   int logid = (int) session.getAttribute("loggedid");
                   PreparedStatement psSelect = conn.prepareStatement("SELECT * FROM users WHERE user_id != ?");
                   psSelect.setInt(1, logid);
                   ResultSet resultSet = psSelect.executeQuery();

                   while (resultSet.next()) {
                       String usernam = resultSet.getString("username");
                       int followeduser = resultSet.getInt("user_id");

                       PreparedStatement psSelectfollow = conn.prepareStatement("SELECT * FROM followers WHERE following_id = ? AND followedby_id = ?");
                       psSelectfollow.setInt(1, followeduser);
                       psSelectfollow.setInt(2, logid);
                       ResultSet resultSetfollow = psSelectfollow.executeQuery();

                    %>
                    <%--<%@include file="userCard"%>--%>
<div class="d-flex flex-row justify-content-between align-items-center mt-3 mb-2">
    <div class="d-flex">
        <!-- Left side: User image and username -->
        <div class="mr-2">
            <!-- User image -->
            <img class="link-secondary" style="border-radius: 50%" src="img/rp-logo.jpg" width="40px" height="40px">
        </div>
        <div class="mr-3">
            <!-- Username -->
            <%= usernam %>
        </div>
    </div>
    
    <!-- Right side: Follow/Unfollow button -->
    <form method="post" action="followlogic.jsp">
        <%
            // Check if the user is already following the person
            PreparedStatement psSelectl = conn.prepareStatement("SELECT * FROM followers WHERE following_id = ? AND followedby_id = ? AND followed = ?");
            psSelectl.setInt(1, followeduser);
            psSelectl.setInt(2, logid);  
            psSelectl.setInt(3, 1);  
            ResultSet resultSetl = psSelectl.executeQuery();
        
            if (resultSetl.next()) {
                int followed_id = resultSetl.getInt("following_id");
        %>
            <div>
                <!-- Unfollow button -->
                <input type="hidden" value="<%= followed_id %>" name="followingidi">
                <button class="btn btn-sm btn-secondary" type="submit" name="unfollow">Unfollow</button>
            </div>
        <%
            } else {
        %>
            <div>
                <!-- Follow button -->
                <input type="hidden" value="<%=followeduser%>" name="followingidi">
                <button class="btn btn-sm btn-secondary" type="submit" name="follow">Follow</button>
            </div>
        <%
            }
        %>
    </form>
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
  </div>
</main> 