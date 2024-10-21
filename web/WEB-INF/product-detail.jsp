<%-- Document : product-detail Created on : Oct 1, 2024, 10:06:44 PM Author : hi --%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix = "fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <style>
      body {
        min-height: 75rem;
        padding-top: 4.5rem;
      }

      .product-item:hover {
        --bs-border-opacity: 1;
        border-color: rgba(var(--bs-primary-rgb), var(--bs-border-opacity)) !important;
        box-shadow: var(--bs-box-shadow) !important;
      }

      .ratings {
        display: flex !important;
        gap: 0.25rem !important;
        align-items: center !important;
      }
    </style>
  </head>
  <body>
    <jsp:include page="part/navbar.jsp" />

    <main class="container-fluid p-3">
      <div class="row row-cols-1 row-cols-lg-2 g-3 mb-3">
        <div class="col col-lg-4">
          <img src="${requestScope.product.image}" class="img-fluid border rounded w-100" alt="..." />
        </div>
        <div class="col col-lg-8">
          <div class="d-flex flex-column bg-body-secondary rounded p-4 h-100">
            <h2 class="container d-flex flex-wrap align-items-center gap-2 mb-4">
              <span class="me-3 mb-2"> ${requestScope.product.name} </span>
              <c:forEach items="${categoryList}" var="category">
                <a class="badge text-bg-primary nav-link mb-2" href="product-list?category-id=${category.id}">${category.name}</a>
              </c:forEach>
            </h2>
            <div class="container mb-4">
              <h4>Pricing</h4>
              <div class="d-flex ps-3 gap-3">
                <span class="card-text fs-4 text-truncate text-secondary text-decoration-line-through"> Original: <strong> $${requestScope.product.unitPrice} </strong> </span>
                <span class="card-text fs-4 text-truncate text-success">Selling: <strong>$${requestScope.product.salePrice}</strong></span>
              </div>
            </div>
            <div class="container mb-4">
              <h4>Import date</h4>
              <span class="fs-5 ms-3">
                <fmt:formatDate type="both" dateStyle="long" timeStyle="short" value="${requestScope.product.importDate}" />
              </span>
            </div>
            <div class="container mb-auto">
              <h4>Description</h4>
              <p class="px-3" style="text-align: justify; text-justify: inter-word">${requestScope.product.description}</p>
            </div>
            <div class="container d-flex justify-content-end align-items-center gap-3">
              <button class="btn btn-lg btn-primary" type="button">Buy Now</button>
              <button class="btn btn-lg btn-outline-primary" type="button">Add to Cart</button>
            </div>
          </div>
        </div>
      </div>
      <div class="container-fluid bg-body-secondary p-5 rounded">
        <h2>Latest Reviews</h2>
        <span class="ratings" value="4.3" max="5.0">
          <span class="ms-2">4.3/5.0</span>
          <span class="ms-2">(7)</span>
        </span>

        <div class="container"></div>
      </div>
    </main>
    <jsp:include page="part/footer.jsp" />

    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script>
      const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
      const tooltipList = [...tooltipTriggerList].map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl));
      $(() => {
        $(".ratings").each(function () {
          let rating = parseFloat($(this).attr("value"));
          let maxRating = parseFloat($(this).attr("max")) || 5;
          let fullStars = Math.floor(rating);
          let halfStar = rating % 1 >= 0.5 ? 1 : 0;
          let emptyStars = maxRating - fullStars - halfStar;
          let starsHtml =
            '<i class="bi bi-star-fill text-warning"></i>'.repeat(fullStars) +
            (halfStar ? '<i class="bi bi-star-half text-warning"></i>' : "") +
            '<i class="bi bi-star text-warning"></i>'.repeat(emptyStars);

          $(this).prepend(starsHtml);
        });
      });
    </script>
  </body>
</html>
