<div class="row">
    <div class="col-lg-12 mb-2">
        <a href="createNewPost.jsp" class="btn block btn-secondary" style="width: 100%">
            create post
         </a> 
    </div>
     <%@ include file= "connections.jsp"%>
            <%
 
        if ("POST".equals(request.getMethod())) {
            try{ 
            int logid = (int) session.getAttribute("loggedid");
                String descrption = request.getParameter("descrption");
                String title = request.getParameter("title");   
                
            if( title != null && descrption!=null){
                        PreparedStatement psInsert = conn.prepareStatement("insert into blogs "
                        + "(`user_id`,`title`,`content`) "
                        + "values(?,?,?)");
                        psInsert.setInt(2,logid);
                       psInsert.setString(3,title);
                       psInsert.setString(4,descrption);                      

                        psInsert.execute(); 

                        response.sendRedirect("index.jsp");
        }else{
           message = "<p class='alert alert-danger text-center'> empty space found</p>";

        }
        }catch(Exception e){
         message = "<p class='alert alert-danger text-center'>"+ e +"</p>";
        }    
        
    }
     %>
</div>
 
          