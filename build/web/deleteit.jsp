<%@ include file="connections.jsp" %>  
<%
        if("POST".equals(request.getMethod()) && request.getParameter("deleteblog")!=null){
        String iddelete=request.getParameter("itemId");  
            try{
        String idparam=request.getParameter("itemId");
            
              PreparedStatement psInsert = conn.prepareStatement("DELETE FROM blogs WHERE blog_id=?"); 
           psInsert.setString(1,idparam); 
           
           int happen= psInsert.executeUpdate(); 
       if(happen>0){
                 response.sendRedirect("index.jsp");
                 out.print(" deleted"+idparam);
    }else{
    out.print("Failed to delete"+idparam);
    }
    }catch(Exception e){
    out.print(e);
    }
        }else{
      response.sendRedirect("index.jsp");   
        }

    %>