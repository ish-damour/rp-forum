<%@include file="loginblocker.jsp" %>
<%@ include file= "header.jsp" %>
<%@ include file= "nav.jsp" %>

<main class="container">
    <div class="row g-5 justify-content-center">
            <%
        // Retrieve the ID parameter from the URL
        String idParam = request.getParameter("id");
        
        // Convert the parameter to an integer (you might need to handle exceptions)
        int id = Integer.parseInt(idParam);
        session.setAttribute("idgetted",+id);
    %>
        <%  
        String nameCheck = (String) session.getAttribute("loggedname");
        if (nameCheck != null) {
        %>
        <div class="col-md-4">
            <div class="position-sticky" style="top: 8rem;">
                <div class="p-1">
                    <%@ include file= "starterProfile.jsp" %>
                </div>
            </div>
        </div>
        <% } %>
        <div class="col-md-8">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <nav class="blog-pagination" aria-label="Pagination">
                        <a class="btn btn-sm btn-outline-secondary rounded-pill" href="#">Recent</a>
                        <a class="btn btn-sm btn-outline-secondary rounded-pill" href="#">28-jan</a>
                    </nav>
                </div>
                <div class="col-lg-12">
                      <%@ include file="postsetted.jsp" %>
                </div>
            </div>
        </div>
    </div>
</main>
                <div hidden="">
                    <%@ include file="footer.jsp" %></div>