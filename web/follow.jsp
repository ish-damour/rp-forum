<%@ include file= "header.jsp"%>

    <%@ include file="connections.jsp" %>
    <%@ page import="java.util.Date, java.sql.Timestamp" %>
<%
try {
    int logid = (int) session.getAttribute("loggedid");
    PreparedStatement psSelect = conn.prepareStatement("SELECT * FROM users WHERE unique_id != ?");
    psSelect.setInt(1, logid);
    ResultSet resultSet = psSelect.executeQuery();

    while (resultSet.next()) {
        String usernam = resultSet.getString("username");
        int followingid = resultSet.getInt("unique_id");
        int followingid2=(int)session.getAttribute("followingid1");
        PreparedStatement psSelectfollow = conn.prepareStatement("SELECT * FROM follow WHERE follower_id = ? AND following_id = ?");
        psSelectfollow.setInt(1, logid);

        psSelectfollow.setInt(2, followingid2);
        ResultSet resultSetfollow = psSelectfollow.executeQuery();

        boolean isFollowing = resultSetfollow.next(); // Check if the user is already following

%>
                        <% if (isFollowing) { %>
                        
                        <% } else { 
        PreparedStatement psupdatefollow = conn.prepareStatement("INSERT INTO  follow VALUES(?,?,?,?)");
         psupdatefollow.setInt(1, 123456789);
        psupdatefollow.setInt(2, logid);
        psupdatefollow.setInt(3, followingid);
        psupdatefollow.setString(4,"1");
         int rowaffected=psupdatefollow.executeUpdate();   
            if(rowaffected>0){
          %>  mmmmmmmm
<%
    }else{
%>
nnnnnnnnnnnn
          <%
}

                        } %>
<%
    }

    resultSet.close();
    psSelect.close();
} catch (Exception e) {
    out.print(e);
}
%>    
    </body>
</html>
