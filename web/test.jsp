<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Number Validation</title>
</head>
<body>
    <form method="post">
        Enter a number: <input type="text" name="number" />
        <input type="submit" value="Check" />
    </form>

    <%
        String userInput = request.getParameter("number");
        String message = "";

        if (userInput != null && userInput.equals("2")) {
            message = "Success!";
        } else if (userInput != null && !userInput.isEmpty()) {
            message = "Invalid input. Please enter '2'.";
        }
    %>

    <p><%= message %></p>
</body>
</html>
