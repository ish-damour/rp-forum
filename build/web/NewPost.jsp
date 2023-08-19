
       
<!DOCTYPE html>
<html>
<head>
    <title>Set Focus Example</title>
    <script>
        function setFocus() {
            document.getElementById("foc").focus();
        }
    </script>
</head>
<body onload="setFocus()">
    <form>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username">
        <br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password">
        <div id="">nnnnnnnnnn</div>
        <br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>

