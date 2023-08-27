
    <%
    String itemIdToDelete = "1";
    %>

    <form action="deleteItem.jsp" method="post">
        <!-- Assuming you have an item ID to delete, you can use a hidden input field -->
        <input type="hidden" name="itemId" value="<%= itemIdToDelete %>">
        
        <!-- Delete button that triggers the confirmation modal -->
        <button type="button" onclick="confirmDelete()" class="btn text-danger"><strong><i class="far fa-trash-alt"></i> Delete</strong></button>
    </form>

    <!-- Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Delete Confirmation</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this item?
                </div>
                <div class="modal-footer">
                    <form method="POST" action="deleteit.jsp">
                       <input type="hidden" name="itemId" value="<%= imageId %>"> 
                    <button type="submit" class="btn btn-secondary" >Cancel</button>
                    <button type="submit" class="btn btn-danger" name="deleteblog">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

