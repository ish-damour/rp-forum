
<%@ page import="java.sql.*" %>
<%@ include file="connections.jsp" %>   
<%
   Statement    statemen = conn.createStatement();
 %> 
  <%
        ResultSet rsi = statemen.executeQuery("SELECT * FROM posts");
        while (rsi.next()) {
            int idll = rsi.getInt("id");
            String titlej = rsi.getString("title");
            int likesj = rsi.getInt("likes");
    %>
            <div>
                <h2><%= titlej %></h2>
                <button onclick="likePost(<%= idll %>)">Like</button>
                <span id="likes_<%= idll %>"><%= likesj %></span> Likes
            </div>
    <%
        }
        rsi.close();
    %>
    <script>
        function likePost(postId) {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var newLikeCount = xhr.responseText;
                    document.getElementById("likes_" + postId).innerHTML = newLikeCount;
                }
            };
            xhr.open("POST", "like_handler.jsp", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.send("postId=" + postId);
        }
    </script>   
    