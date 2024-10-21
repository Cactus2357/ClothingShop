<%-- Document : category-control Created on : Oct 7, 2024, 3:35:18 AM Author : hi --%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@page contentType="text/html"
pageEncoding="UTF-8"%>
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

    <style>
      body {
        /*min-height: 75rem;*/
        padding-top: 4.5rem;
      }
    </style>
  </head>
  <body>
    <jsp:include page="part/navbar.jsp" />
    <jsp:include page="part/notification.jsp">
      <jsp:param name="response" value="${response}" />
      <jsp:param name="responseType" value="${responseType}" />
    </jsp:include>

    <main class="container-fluid p-3">
      <form action="category" method="post" id="product-form">
        <div class="row">
          <div class="container mb-3">
            <h2 class="float-start">Category List</h2>
            <div class="d-flex float-end gap-2"></div>
          </div>
          <div class="mb-3">
            <div class="card">
              <div class="card-body container">
                <input type="number" name="category-id" id="category-id" hidden />
                <label class="form-label" for="category-name">Category Name</label>
                <div class="input-group d-flex flex-nowrap mb-3">
                  <span class="input-group-text" id="basic-addon1">@</span>
                  <input type="text" class="form-control" name="category-name" id="category-name" placeholder="Write name here..." />
                  <button class="btn btn-success" type="submit">Confirm</button>
                  <button class="btn btn-secondary" type="reset">Discard</button>
                </div>
              </div>
            </div>
          </div>
          <div class="mb-3">
            <div class="card">
              <div class="card-body container overflow-y-auto" style="height: 600px">
                <table class="table table-sm table-hover table-striped category-table caption-top">
                  <caption>
                    List of categories
                  </caption>
                  <thead>
                    <tr>
                      <th scope="col">#</th>
                      <th scope="col">Name</th>
                    </tr>
                  </thead>
                  <tbody class="table-group-divider">
                    <c:forEach items="${categoryList}" var="c">
                      <tr>
                        <th scope="row">${c.id}</th>
                        <td>${c.name}</td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </form>
    </main>

    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script>
      $(document).ready(function () {
        $(".category-table tbody tr").on("click", function () {
          const categoryId = $(this).find("th").text().trim();
          const categoryName = $(this).find("td").text().trim();

          $("#category-id").val(categoryId);
          $("#category-name").val(categoryName).focus();
        });

        $("#category-name").focus();
      });
    </script>
  </body>
</html>
