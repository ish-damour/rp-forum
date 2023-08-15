<%@ page import="java.io.*, java.sql.*" %>
<%
    int imageId = Integer.parseInt(request.getParameter("id"));

    String dbUrl = "jdbc:mysql://localhost:3306/rpForum";
    String dbUsername = "root";
    String dbPassword = "";

    Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
    String query = "SELECT image_data FROM blogs WHERE blog_id = ?";
    PreparedStatement preparedStatement = connection.prepareStatement(query);
    preparedStatement.setInt(1, imageId);

    ResultSet resultSet = preparedStatement.executeQuery();
    if (resultSet.next()) {
        byte[] imageData = resultSet.getBytes("image_data");

        response.setContentType("image/jpeg"); // Set the appropriate content type

        OutputStream outputStream = response.getOutputStream();
        outputStream.write(imageData);
        outputStream.close();
    }

    resultSet.close();
    preparedStatement.close();
    connection.close();
%>
