   <footer class="text-center">
    <p>© 2023 RP-forum. All rights reserved.</p>
  </footer>
    <script>
function likePost(postId) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            console.log("Response Text:", xhr.responseText); // Add this line for debugging
            var newLikeCount = xhr.responseText;
            document.getElementById("likes_" + postId).innerHTML =newLikeCount;
        }
    };
    xhr.open("POST", "like_handler.jsp", true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.send("postId=" + postId);
}

    </script>
                        <script>
function followuserget(followid) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
//            console.log("Response Text:", xhr.responseText); // Add this line for debugging
            var newfollow = xhr.responseText;
            document.getElementById("followget_" + followid).innerHTML =newfollow;
        }
    };
    xhr.open("POST", "follow_handler.jsp", true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.send("followid=" + followid);
}

    </script>     
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
</body>
</html>
