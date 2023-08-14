<%@ include file= "header.jsp"%>

    <%@ include file="connections.jsp" %>
    <%@ page import="java.util.Date, java.sql.Timestamp" %>
<%
try {
    int loggedUserId = (int) session.getAttribute("loggedid");
    int followingId = Integer.parseInt(request.getParameter("followingidi"));
    boolean isFollowing = Boolean.parseBoolean(request.getParameter("isFollowing"));
        // Debugging statements
    out.println("loggedUserId: " + loggedUserId);
    out.println("followingId: " + followingId);
    out.println("isFollowing: " + isFollowing);

    if (isFollowing) {
        // Unfollow logic
        PreparedStatement psUnfollow = conn.prepareStatement("DELETE FROM followers WHERE follower_id = ? AND following_id = ?");
        psUnfollow.setInt(1, loggedUserId);
        psUnfollow.setInt(2, followingId);
        psUnfollow.executeUpdate();
    } else {
        // Follow logic
        PreparedStatement psFollow = conn.prepareStatement("INSERT INTO followers (follower_id, following_id) VALUES (?, ?)");
        psFollow.setInt(1, loggedUserId);
        psFollow.setInt(2, followingId);
        psFollow.executeUpdate();
    }

    response.sendRedirect("UserList.jsp"); // Redirect back to your main page
} catch (Exception e) {
    out.print("Error: " + e.getMessage());
}
%>
