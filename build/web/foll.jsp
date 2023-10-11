

               <%
               try {
                   int logid = (int) session.getAttribute("loggedid");
                   String gido=request.getParameter("id");
                   PreparedStatement psSelect = conn.prepareStatement("SELECT * FROM users WHERE user_id = ?");
                   psSelect.setString(1, gido);
                   ResultSet resultSeti = psSelect.executeQuery();

                   while (resultSeti.next()) {
                       String usernam = resultSeti.getString("username");
                       int followeduser = resultSeti.getInt("user_id");

                       PreparedStatement psSelectfollow = conn.prepareStatement("SELECT * FROM followers WHERE following_id = ? AND followedby_id = ?");
                       psSelectfollow.setInt(1, followeduser);
                       psSelectfollow.setInt(2, logid);
                       ResultSet resultSetfollow = psSelectfollow.executeQuery();

                    %>
                    <%--<%@include file="userCard"%>--%>
    
    <!-- Right side: Follow/Unfollow button -->
    <!--<form method="post" action="followlogic.jsp">-->
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
                <!--<button class="btn btn-sm btn-secondary " type="submit" name="unfollow">following</button>-->
                <!--<button class="btn btn-sm btn-secondary " type="submit" name="follow">Following</button>-->
                            <button onclick="followuser(<%=followeduser  %>)"  class="btn btn-sm btn-outline-primary ">
                <span id="follow_<%= followeduser %>">
                    <!--<i class='far fa-heart mr-1'> </i>-->
                    following
                    <%--<%=  %>--%>
                </span></button>                
            </div>
        <%
            } else {
        %>
            <div>
                <!-- Follow button -->
                <input type="hidden" value="<%=followeduser%>" name="followingidi">
                <!--<button class="btn btn-sm btn-secondary " type="submit" name="follow">Follow</button>-->
                <!--<button class="btn btn-sm btn-secondary " type="submit" name="follow">Follow</button>-->
                            <button onclick="followuser(<%=followeduser  %>)"  class="btn btn-sm btn-outline-primary ">
                <span id="follow_<%= followeduser %>">Follow
                    <!--<i class='far fa-heart mr-1'> </i>-->
                    <%--<%=  %>--%>
                </span></button>
                
            </div>
        <%
            }
        %>
    <!--</form>-->

                    <%
                        }

                        resultSeti.close();
                        psSelect.close();
                    } catch (Exception e) {
                        out.print(e);
                    }
                    %>