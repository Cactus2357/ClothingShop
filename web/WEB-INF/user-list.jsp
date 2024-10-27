<%-- Document : user-list Created on : Oct 22, 2024, 12:50:00 AM Author : hi --%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix = "fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %> <%@page
contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User List</title>
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
        <h3>
          <span> User List </span>
          <div class="float-end me-3">
            <div class="dropdown">
              <button class="btn btn-primary d-flex align-items-center" type="button" id="filter" data-bs-toggle="dropdown" data-bs-auto-close="outside">
                Filter
                <i class="bi bi-gear-fill ms-2"></i>
              </button>
              <ul class="dropdown-menu" aria-labelledby="filter">
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-id" id="user-id" checked />
                    <label class="form-check-label" for="user-id">User ID</label>
                  </div>
                </li>
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-name" id="user-name" checked />
                    <label class="form-check-label" for="user-name">Username</label>
                  </div>
                </li>
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-email" id="user-email" checked />
                    <label class="form-check-label" for="user-email">Email</label>
                  </div>
                </li>
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-avatar" id="user-avatar" checked />
                    <label class="form-check-label" for="user-avatar">Avatar</label>
                  </div>
                </li>
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-family-name" id="user-family-name" />
                    <label class="form-check-label" for="user-family-name">Family Name</label>
                  </div>
                </li>
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-given-name" id="user-given-name" />
                    <label class="form-check-label" for="user-given-name">Given Name</label>
                  </div>
                </li>
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-gender" id="user-gender" />
                    <label class="form-check-label" for="user-gender">Gender</label>
                  </div>
                </li>
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-phone" id="user-phone" />
                    <label class="form-check-label" for="user-phone">Phone</label>
                  </div>
                </li>
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-address" id="user-address" />
                    <label class="form-check-label" for="user-address">Address</label>
                  </div>
                </li>
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-role" id="user-role" checked />
                    <label class="form-check-label" for="user-role">Role</label>
                  </div>
                </li>
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-status" id="user-status" checked />
                    <label class="form-check-label" for="user-status">Status</label>
                  </div>
                </li>
                <li class="dropdown-item">
                  <div class="form-check">
                    <input class="form-check-input toggle-display" type="checkbox" value="user-created-at" id="user-created-at" checked />
                    <label class="form-check-label" for="user-created-at">Created At</label>
                  </div>
                </li>
              </ul>
            </div>
            <!-- <script>
              $(() => {
                $(".toggle-display").change(function () {
                  let toggleClass = $(this).val();
                  if ($(this).is(":checked")) {
                    $("." + toggleClass).show();
                  } else {
                    $("." + toggleClass).hide();
                  }
                });
              });
            </script> -->
          </div>
        </h3>
      </div>
      <div class="container-fluid mb-3 mx-3 d-flex flex-wrap gap-3">
        <input type="text" class="form-control border-secondary" style="width: 300px" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1" disabled />
        <div class="btn-group" style="width: 400px">
          <div class="btn-group w-100">
            <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" disabled>User roles</button>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">Admin</a></li>
              <li><a class="dropdown-item" href="#">Manager</a></li>
              <li><a class="dropdown-item" href="#">Staff</a></li>
              <li><a class="dropdown-item" href="#">Customer</a></li>
            </ul>
          </div>
          <div class="btn-group w-100">
            <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" disabled>Status</button>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">Active</a></li>
              <li><a class="dropdown-item" href="#">Inactive</a></li>
              <li><a class="dropdown-item" href="#">Blocked</a></li>
            </ul>
          </div>
          <button class="btn btn-outline-secondary w-100" type="button" disabled>More filters</button>
        </div>
        <button class="btn btn-primary d-flex justify-content-center gap-2 px-3 me-3 ms-xl-auto" disabled><i class="bi bi-plus"></i> Add user</button>
      </div>
      <div class="container-fluid table-responsive mx-3 pe-4">
        <table class="table table-striped table-hover" id="user-table">
          <thead>
            <tr>
              <th scope="col" class="user-id">#</th>
              <th scope="col" class="user-avatar no-sort">Avatar</th>
              <th scope="col" class="user-name">Username</th>
              <th scope="col" class="user-email">Email</th>
              <th scope="col" class="user-family-name">FamilyName</th>
              <th scope="col" class="user-given-name">GivenName</th>
              <th scope="col" class="user-gender">Gender</th>
              <th scope="col" class="user-phone">Phone</th>
              <th scope="col" class="user-address">Address</th>
              <th scope="col" class="user-role">Role</th>
              <th scope="col" class="user-status">Status</th>
              <th scope="col" class="user-created-at">Created At</th>
              <th scope="col" class="no-sort">Option</th>
            </tr>
          </thead>
          <tbody class="table-group-divider">
            <c:forEach items="${userList}" var="user">
              <tr class="align-middle">
                <th scope="row" class="user-id">${user.userID}</th>
                <td class="user-avatar">
                  <a href="#"><img src="${user.avatar ne null ? user.avatar : 'asset/img/default_picture.png'}" width="36" height="36" class="rounded-circle" alt="" /></a>
                </td>
                <td class="user-name">@${user.userName}</td>
                <td class="user-email"><a href="mailto:${user.email}">${user.email}</a></td>
                <td class="user-family-name">${user.familyName}</td>
                <td class="user-given-name">${user.givenName}</td>
                <td class="user-gender">${user.gender}</td>
                <td class="user-phone">${user.phone}</td>
                <td class="user-address">${user.address}</td>
                <td class="user-role">${user.role}</td>
                <td class="user-status">${user.status}</td>
                <td class="text-nowrap"><fmt:formatDate pattern="yyyy/MM/dd hh:mm:ss" value="${user.createdAt}" /></td>
                <td>
                  <button class="btn rounded-circle"><i class="bi bi-three-dots-vertical"></i></button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        <script>
          $(document).ready(function () {
            $("#user-table").DataTable({
              responsive: true,
              autoWidth: false,
              columnDefs: [
                { targets: "no-sort", orderable: false }, // Disable sorting on certain columns if needed (e.g., Options)
              ],
            });

            function display() {
              $(".toggle-display").each(function () {
                let toggleClass = $(this).val();
                if ($(this).is(":checked")) {
                  $("." + toggleClass).show();
                } else {
                  $("." + toggleClass).hide();
                }
              });
            }

            display();

            $(".toggle-display").change(display);
          });
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
