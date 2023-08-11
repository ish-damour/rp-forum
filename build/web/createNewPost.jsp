<%@ include file= "header.jsp"%>
<div class="container"> 
    <div class="row py-5 justify-content-center">
         <div class="d-flex flex-row justify-content-between mb-4">
                <div>
                    <a href="index.jsp" class="btn btn-sm btn-secondary">Back home</a>
                </div>
            </div>
        <div class="col-lg-6">
           
            <form class="row gap-3">
                <div class="mb-3">
                    <label for="location" class="form-label">Location</label>
                    <input type="text" class="form-control" id="location" placeholder="location">
                  </div>
                  <div class="mb-3">
                    <label for="exampleFormControlTextarea1" class="form-label">Write description</label>
                    <textarea class="form-control" id="Write description" rows="4" placeholder="Write description"></textarea>
                  </div> 
                <div class="mb-3">
                    <input class="custom-file-input" type="file">
                  </div> 
                <div class="mb-3">
                    <button type="submit" class="w-100 btn btn-block btn-secondary">save post</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@ include file= "footer.jsp"%>

