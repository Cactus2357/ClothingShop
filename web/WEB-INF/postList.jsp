<%-- 
    Document   : postList
    Created on : Sep 13, 2024, 11:46:59 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post List</title>
    </head>
    <body>
        <h1>All Posts</h1>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>User ID</th>
                <th>Image</th>
                <th>Brief Info</th>
                <th>Action</th>
            </tr>
            <%
            java.util.List<com.myshop.model.Post> posts = (java.util.List<com.myshop.model.Post>) request.getAttribute("posts");
            for (com.myshop.model.Post post : posts) {
            %>
            <tr>
                <td><%= post.getId() %></td>
                <td><%= post.getUserId() %></td>
                <td><img src="<%= post.getImage() %>" alt="Post Image" style="max-width:100px;"/></td>
                <td><%= post.getBriefInfo() %></td>
                <td>
                    <a href="postDetal?id=<%= post.getId() %>">View Detail</a>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </body>
</html>
