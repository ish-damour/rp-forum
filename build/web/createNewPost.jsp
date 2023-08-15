<%@ include file= "header.jsp"%>
<%@ include file= "connections.jsp"%>
<div class="container"> 
    <div class="row py-5 justify-content-center">
         <div class="d-flex flex-row justify-content-between mb-4">
                <div>
                    <a href="index.jsp" class="btn btn-sm btn-secondary">Back home</a>
                </div>
            </div>
        <div class="col-lg-6">
           <form action="UploadImage" method="post" action="UploadImage" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="location" class="form-label">Title</label>
                    <input type="text" class="form-control" name="title" id="Title" placeholder="Title">
                  </div>
                  <div class="mb-3">
                    <label for="exampleFormControlTextarea1" class="form-label">Write description</label>
                    <textarea class="form-control" id="Write description"name="content" rows="4" placeholder="Write description"></textarea>
                  </div> 
                <div class="mb-3">
                        
             <input type="file" name="imageFile" accept="image/*">
                  </div> 
                <div class="mb-3">
                    <button type="submit" class="w-100 btn btn-block btn-secondary" name="upload">save post</button>
                </div>
            </form>
       
        </div>
    </div>
</div>
<%@ include file= "footer.jsp"%>

