<%-- 
    Document   : postDetail
    Created on : Sep 13, 2024, 11:48:35 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post Detail</title>
    </head>
    <body>
        <h1>Post Detail</h1>
    <%
        com.myshop.model.Post post = (com.myshop.model.Post) request.getAttribute("post");
        if (post != null) {
    %>
    <p><strong>ID:</strong> <%= post.getId() %></p>
    <p><strong>User ID:</strong> <%= post.getUserId() %></p>
    <p><strong>Image:</strong> <img src="<%= post.getImage() %>" alt="Post Image" style="max-width:200px;"/></p>
    <p><strong>Category ID:</strong> <%= post.getCategoryId() %></p>
    <p><strong>Brief Info:</strong> <%= post.getBriefInfo() %></p>
    <p><strong>Description:</strong> <%= post.getDescription() %></p>
    <p><strong>Status:</strong> <%= post.getStatus() %></p>
    <p><strong>Last Updated At:</strong> <%= post.getUpdatedAt() %></p>
    <a href="postList">Back to Posts</a>
    <%
        } else {
    %>
    <p>No post found.</p>
    <a href="postList">Back to Posts</a>
    <%
        }
    %>
</body>
</html>

