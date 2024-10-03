<%-- Document : product-detail Created on : Oct 1, 2024, 10:06:44 PM Author : hi --%> <%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix = "fmt" uri =
"http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <script src="https://unpkg.com/jquery@3/dist/jquery.min.js" crossorigin="anonymous"></script>
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
    <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
      <symbol id="check2" viewBox="0 0 16 16">
        <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z" />
      </symbol>
      <symbol id="circle-half" viewBox="0 0 16 16">
        <path d="M8 15A7 7 0 1 0 8 1v14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z" />
      </symbol>
      <symbol id="moon-stars-fill" viewBox="0 0 16 16">
        <path
          d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z"
        />
        <path
          d="M10.794 3.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387a1.734 1.734 0 0 0-1.097 1.097l-.387 1.162a.217.217 0 0 1-.412 0l-.387-1.162A1.734 1.734 0 0 0 9.31 6.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387a1.734 1.734 0 0 0 1.097-1.097l.387-1.162zM13.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732l-.774-.258a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L13.863.1z"
        />
      </symbol>
      <symbol id="sun-fill" viewBox="0 0 16 16">
        <path
          d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"
        />
      </symbol>
    </svg>
    <div class="dropdown position-fixed bottom-0 end-0 mb-3 me-3 bd-mode-toggle">
      <button class="btn btn-bd-primary py-2 dropdown-toggle d-flex align-items-center" id="bd-theme" type="button" data-bs-toggle="dropdown">
        <svg class="bi my-1 theme-icon-active" width="1em" height="1em"><use href="#circle-half"></use></svg>
        <span class="visually-hidden" id="bd-theme-text">Toggle theme</span>
      </button>
      <ul class="dropdown-menu dropdown-menu-end shadow">
        <li>
          <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="light">
            <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#sun-fill"></use></svg>
            Light
            <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
          </button>
        </li>
        <li>
          <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="dark">
            <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#moon-stars-fill"></use></svg>
            Dark
            <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
          </button>
        </li>
        <li>
          <button type="button" class="dropdown-item d-flex align-items-center active" data-bs-theme-value="auto">
            <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#circle-half"></use></svg>
            Auto
            <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
          </button>
        </li>
      </ul>
    </div>

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
              <span class="badge text-bg-primary mb-2">Category</span>
              <span class="badge text-bg-primary mb-2">Category</span>
              <span class="badge text-bg-primary mb-2">Category</span>
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
            <div class="container">
              <h4>Description</h4>
              <p class="px-3" style="text-align: justify; text-justify: inter-word">${requestScope.product.description}</p>
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
    <script src="https://unpkg.com/jquery@3/dist/jquery.min.js" crossorigin="anonymous"></script>
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
