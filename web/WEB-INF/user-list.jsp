<%-- 
    Document   : user-list
    Created on : Oct 22, 2024, 12:50:00 AM
    Author     : hi
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="asset/script/color-modes.js"></script>

    <link rel="stylesheet" href="asset/style/theme-button.css" />
    <link rel="stylesheet" href="asset/style/image-placeholder.css" />

    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-bs5.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-bs5.min.js"></script>

    <!--  -->
    <link rel="stylesheet" href="https://cdn.datatables.net/2.1.8/css/dataTables.bootstrap5.css" />
    <script src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
    <script src="https://cdn.datatables.net/2.1.8/js/dataTables.bootstrap5.js"></script>
    <!--  -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-table@1.23.5/dist/bootstrap-table.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-table@1.23.5/dist/bootstrap-table.min.js"></script>
    <!--  -->

    <style>
      body {
        /* min-height: 75rem; */
        padding-top: 4.5rem;
      }

      .flex-even {
        flex: 1;
      }
    </style>
  </head>
  <body>
    <jsp:include page="part/navbar.jsp" />
    <main class="container-fluid p-5 px-3">
      <div class="container-fluid mb-3 mx-3">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#" class="link-underline link-underline-opacity-0 link-underline-opacity-100-hover">Dashboard</a></li>
            <li class="breadcrumb-item active" aria-current="page">Users</li>
          </ol>
        </nav>
        <h3>User List</h3>
      </div>
      <!-- <div class="container-fluid mb-3 mx-3 d-flex flex-wrap gap-3">
        <input type="text" class="form-control border-secondary" style="width: 300px" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1" />
        <div class="btn-group" style="width: 400px">
          <div class="btn-group w-100">
            <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">User roles</button>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">Admin</a></li>
              <li><a class="dropdown-item" href="#">Manager</a></li>
              <li><a class="dropdown-item" href="#">Staff</a></li>
              <li><a class="dropdown-item" href="#">Customer</a></li>
            </ul>
          </div>
          <div class="btn-group w-100">
            <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">Status</button>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">Active</a></li>
              <li><a class="dropdown-item" href="#">Inactive</a></li>
              <li><a class="dropdown-item" href="#">Blocked</a></li>
            </ul>
          </div>
          <button class="btn btn-outline-secondary w-100" type="button">More filters</button>
        </div>
        <button class="btn btn-primary d-flex justify-content-center gap-2 px-3 me-3 ms-xl-auto"><i class="bi bi-plus"></i> Add user</button>
      </div> -->
      <div class="container-fl table-responsive mx-3 pe-4">
        <table class="table table-striped table-hover" id="user-table">
          <thead>
            <tr>
              <th scope="col">#</th>
              <th scope="col">Username</th>
              <th scope="col">Email</th>
              <th scope="col">Avatar</th>
              <th scope="col">FamilyName</th>
              <th scope="col">GivenName</th>
              <th scope="col">Gender</th>
              <th scope="col">Phone</th>
              <th scope="col">Address</th>
              <th scope="col">Role</th>
              <th scope="col">Status</th>
              <th scope="col">Created At</th>
              <th scope="col">Option</th>
            </tr>
          </thead>
          <tbody class="table-group-divider">
            <c:forEach items="${userList}" var="user">
              <tr class="align-middle">
                <th scope="row">${user.userID}</th>
                <td>@${user.userName}</td>
                <td><a href="mailto:${user.email}">${user.email}</a></td>
                <td><a href="#"><img src="${user.avatar ne null ? user.avatar : 'asset/img/default_picture.png'}" width="36" height="36" class="rounded-circle" alt="" /></a></td>
                <td>${user.familyName}</td>
                <td>${user.givenName}</td>
                <td>${user.gender}</td>
                <td>${user.phone}</td>
                <td>${user.address}</td>
                <td>${user.role}</td>
                <td>${user.status}</td>
                <td class="text-nowrap"><fmt:formatDate pattern="yyyy/MM/dd hh:mm:ss" value="${user.createdAt}" /></td>
                <td>
                  <button class="btn rounded-circle"><i class="bi bi-three-dots-vertical"></i></button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        <script>
          $("#user-table").DataTable();
        </script>
      </div>
    </main>
    <div class="container">
      <footer class="py-3 my-4">
        <ul class="nav justify-content-center border-bottom pb-3 mb-3">
          <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Home</a></li>
          <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Features</a></li>
          <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Pricing</a></li>
          <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">FAQs</a></li>
          <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">About</a></li>
        </ul>
        <p class="text-center text-body-secondary">&copy; 2024 Company, Inc</p>
      </footer>
    </div>

    <script src="js/bootstrap.bundle.min.js"></script>
  </body>
</html>
