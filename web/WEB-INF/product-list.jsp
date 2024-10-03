<%-- 
    Document   : product-list
    Created on : Sep 28, 2024, 10:00:23 PM
    Author     : hi
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <script src="https://unpkg.com/jquery@3/dist/jquery.min.js" crossorigin="anonymous"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="asset/script/color-modes.js"></script>

    <link rel="stylesheet" href="asset/style/theme-button.css" />

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

  <main class="container-fluid p-5">
    <div class="row">
      <div class="container-fluid col-md-4 col-xl-3">
        <div class="border bg-body-tertiary rounded mb-3 p-2 row sticky-top" style="top: 76px">
          <div class="mb-3">
            <label class="form-label">Keywords</label>
            <br />
            <span class="badge text-bg-primary">Keyword</span>
            <span class="badge text-bg-primary">Keyword</span>
            <span class="badge text-bg-primary">Keyword</span>
          </div>
          <div class="mb-3">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" value="" id="checkbox1" />
              <label class="form-check-label" for="checkbox1"> Option 1 </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" value="" id="checkbox2" />
              <label class="form-check-label" for="checkbox2"> Option 2 </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" value="" id="checkbox3" />
              <label class="form-check-label" for="checkbox3"> Option 3 </label>
            </div>
          </div>
          <div class="mb-3">
            <label for="range1" class="form-label">Label ($0-100)</label>
            <strong class="float-end"> &gt; <output id="rangeOutput1">23</output>$</strong>
            <input type="range" class="form-range" min="0" max="100" value="23" id="range1" oninput="$('#rangeOutput1').val(this.value)" />
          </div>
          <div class="mb-3">
            <div class="mb-3">
              <label for="category" class="form-label">Category</label>
              <select class="form-select" name="dategory" id="dategory" disabled>
                <option selected disabled>Select a category</option>
                <option value="">New Delhi</option>
                <option value="">Istanbul</option>
                <option value="">Jakarta</option>
              </select>
            </div>
          </div>
          <div class="mb-3">
            <label class="form-label">Category 1</label>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" value="" id="checkbox4" />
              <label class="form-check-label" for="checkbox4"> Option 1 </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" value="" id="checkbox5" />
              <label class="form-check-label" for="checkbox5"> Option 2 </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" value="" id="checkbox6" />
              <label class="form-check-label" for="checkbox6"> Option 3 </label>
            </div>
          </div>
          <div class="mb-3">
            <label class="form-label">Category 2</label>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" value="" id="checkbox7" />
              <label class="form-check-label" for="checkbox7"> Option 1 </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" value="" id="checkbox8" />
              <label class="form-check-label" for="checkbox8"> Option 2 </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="checkbox" value="" id="checkbox9" />
              <label class="form-check-label" for="checkbox9"> Option 3 </label>
            </div>
          </div>
        </div>
      </div>
      <div class="container-fluid col-md-8 col-xl-9">
        <div class="container mb-3">
          <!-- !!! -->
          <form action="#" method="get">
            <div class="row">
              <div class="col-xl-6 mb-3">
                <div class="input-group input-group-sm">
                  <input type="search" list="searchList" name="query" class="form-control" placeholder="Search" value="${query}" />
                  <button type="submit" class="btn btn-secondary"><i class="bi bi-search"></i></button>
                </div>
                <datalist id="searchList">
                  <option value="San Francisco"></option>
                  <option value="New York"></option>
                  <option value="Seattle"></option>
                  <option value="Los Angeles"></option>
                  <option value="Chicago"></option>
                </datalist>
              </div>
              <div class="col-auto col-xl-6 mb-3">
                <div class="d-flex flex-wrap float-end gap-2">
                  <input type="radio" class="btn-check" name="order" value="0" id="radio1" autocomplete="off" ${(order ne null and order ne 0) ? '' : 'checked'} />
                  <label class="btn btn-sm btn-outline-primary" for="radio1">New</label>

                  <input type="radio" class="btn-check" name="order" value="1" id="radio2" autocomplete="off" ${order eq 1 ? 'checked' : ''} />
                  <label class="btn btn-sm btn-outline-primary" for="radio2">Price ascending</label>

                  <input type="radio" class="btn-check" name="order" value="2" id="radio3" autocomplete="off" ${order eq 2 ? 'checked' : ''} />
                  <label class="btn btn-sm btn-outline-primary" for="radio3">Price descending</label>

                  <input type="radio" class="btn-check" name="order" value="3" id="radio4" autocomplete="off" ${order eq 3 ? 'checked' : ''} />
                  <label class="btn btn-sm btn-outline-primary disabled" for="radio4">Rating</label>

                  <input type="number" name="size" min="5" max="20" value="${size ne null ? size : 9}" class="form-control form-control-sm w-auto" data-bs-toggle="tooltip" data-bs-title="Products per page" />
                </div>
              </div>
            </div>
          </form>
          <!-- !!! -->
        </div>
        <div class="container mb-3">
          <c:choose>
            <c:when test="${productList eq null}">
              <h3>Server error</h3>
            </c:when>
            <c:when test="${empty productList}">
              <h3>No products found</h3>
            </c:when>
            <c:otherwise>
              <h3>Products found (${totalItems})</h3>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="container mb-3">
          <!-- !!! -->
          <div class="row row-cols-1 row-cols-lg-2 row-cols-xxl-3 g-4 mb-3" data-masonry='{"percentPosition": true }'>
            <c:forEach var="product" items="${productList}">

              <div class="col">
                <div class="card bg-body-tertiary h-100 product-item">
                  <a href="product-detail?id=${product.id}"><img src="${product.image}" class="card-img-top" alt="..." /></a>
                  <div class="card-body">
                    <h5 class="card-title">${product.name}</h5>
                    <p class="card-text text-truncate">${product.description}</p>
                    <div class="d-flex justify-content-between align-items-center">
                      <span class="card-text fs-4">$${product.salePrice}</span>
                      <span class="float-end">
                        <a href="product-detail?id=${product.id}" class="btn btn-primary me-1">More info</a><a href="#" class="btn btn-outline-primary"> <i class="bi bi-cart"></i> </a>
                      </span>
                    </div>
                  </div>
                </div>
              </div>

            </c:forEach>
          </div>
          <c:if test="${productList ne null and not empty productList and totalPages ne 1}">

            <div class="container d-flex justify-content-end">
              <nav>
                <c:url var="pageURL" value="product-list">
                  <c:param name="query" value="${query}" />
                  <c:if test="${order ne null and order ne 0}"><c:param name="order" value="${order}" /></c:if>
                  <c:if test="${size ne null and size ne 9}"><c:param name="size" value="${size}" /> </c:if>
                </c:url>
                <ul class="pagination">
                  <c:if test="${(page != null && page > 1)}">
                    <li class="page-item ${(page != null && page > 1) ? '' : 'disabled'}">
                      <a class="page-link" href="${pageURL}&page=1">&laquo;</a>
                    </li>
                  </c:if>
                  <c:forEach begin="1" end="5" var="i">
                    <c:set var="p" value="${page + i - 3}" />
                    <c:if test="${p >= 1 && p <= totalPages}">
                      <li class="page-item">
                        <a class="page-link ${p == page ? 'active' : ''}" href="${pageURL}&page=${p}">${p}</a>
                      </li>
                    </c:if>
                  </c:forEach>
                  <c:if test="${(page != null && page < totalPages)}">
                    <li class="page-item ${(page != null && page < totalPages) ? '' : 'disabled'}">
                      <a class="page-link" href="${pageURL}&page=${totalPages}">&raquo;</a>
                    </li>
                  </c:if>
                </ul>
              </nav>
            </div>

          </c:if>
        </div>
      </div>
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
  <script async src="https://cdn.jsdelivr.net/npm/masonry-layout@4.2.2/dist/masonry.pkgd.min.js" integrity="sha384-GNFwBvfVxBkLMJpYMOABq3c+d3KnQxudP/mGPkzpZSTYykLBNsZEnG2D9G/X/+7D" crossorigin="anonymous"></script>
  <script src="https://unpkg.com/jquery@3/dist/jquery.min.js" crossorigin="anonymous"></script>
  <script>
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltipList = [...tooltipTriggerList].map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl));
  </script>
</body>
</html>
