<%-- Document : product-list Created on : Sep 28, 2024, 10:00:23 PM Author : hi --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Product List</title>
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

      .dropdown-menu {
        overflow: hidden;
        overflow-y: auto;
        max-height: calc(50vh - 150px);
      }
    </style>
  </head>
  <body>
    <jsp:include page="part/navbar.jsp" />
    <jsp:include page="part/notification.jsp">
      <jsp:param name="response" value="${response}" />
      <jsp:param name="responseType" value="${responseType}" />
    </jsp:include>

    <main class="container-fluid p-5 pt-0">
      <form action="#" method="get">
        <div class="row">
          <div class="container-fluid col-md-4 col-xl-3">
            <!-- style="top: 76px -->
            <div class="border bg-body-tertiary rounded mb-3 p-2 pt-3 row sticky-top" style="top: 4.5rem">
              <div class="mb-3">
                <label class="form-label">Suggestions</label>
                <br />
                <c:forEach items="${suggestions}" var="c">
                  <a class="badge rounded-pill text-bg-primary nav-link" href="product-list?category-id=${c.id}">${c.name}</a>
                </c:forEach>
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
                <input type="range" class="form-range" min="0" max="100" value="23" id="min-sale-price" oninput="$('#rangeOutput1').val(this.value)" />
              </div>
              <div class="mb-3">
                <div class="mb-3">
                  <label for="category" class="form-label">Category</label>
                  <div class="dropdown">
                    <button class="btn btn-outline-secondary dropdown-toggle w-100" type="button" id="category" data-bs-toggle="dropdown">Select a Category</button>
                    <ul class="dropdown-menu w-100">
                      <li>
                        <a class="dropdown-item" href="product-list">None</a>
                      </li>
                      <c:forEach items="${categoryList}" var="c">
                        <li>
                          <a class="dropdown-item" href="product-list?category-id=${c.id}">${c.name}</a>
                        </li>
                      </c:forEach>
                    </ul>
                  </div>
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
              <div class="mb-3">
                <label class="form-label" for="display">Information count</label>
                <input type="range" class="form-control" value="6" min="0" max="6" name="display" id="display" placeholder="Display" />
              </div>
            </div>
          </div>
          <div class="container-fluid col-md-8 col-xl-9">
            <div class="bg-body mb-3 sticky-top pt-3" style="top: 3.5rem">
              <!-- !!! -->
              <div class="row">
                <div class="col-xl-6 mb-3">
                  <div class="input-group input-group-sm">
                    <input type="search" list="searchList" name="query" class="form-control" placeholder="Search" value="${query}" />
                    <button type="submit" class="btn btn-success px-3"><i class="bi bi-search"></i></button>
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
                  <c:url var="orderURL" value="product-list">
                    <c:param name="query" value="${query}" />
                    <c:if test="${size ne null and size ne 9}"><c:param name="size" value="${size}" /> </c:if>
                  </c:url>
                  <div class="d-flex flex-wrap float-end gap-2">
                    <a class="btn btn-sm btn-outline-primary ${(order ne null and order ne 0) ? '' : 'active'}" href="${orderURL}"> New </a>
                    <a class="btn btn-sm btn-outline-primary ${order eq 1 ? 'active' : ''}" href="${orderURL}&order=1"> Price ascending </a>
                    <a class="btn btn-sm btn-outline-primary ${order eq 2 ? 'active' : ''}" href="${orderURL}&order=2"> Price descending </a>
                    <a class="btn btn-sm btn-outline-primary ${order eq 3 ? 'active' : ''} disabled" href="${orderURL}&order=3"> Rating </a>

                    <input
                      type="number"
                      name="size"
                      min="5"
                      max="20"
                      value="${size ne null ? size : 9}"
                      class="form-control form-control-sm w-auto"
                      data-bs-toggle="tooltip"
                      data-bs-title="Products per page"
                      />
                  </div>
                </div>
              </div>
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
              <div class="row row-cols-1 row-cols-lg-2 row-cols-xxl-3 g-4 mb-3" id="product-list" data-masonry='{"percentPosition": true }'>
                <c:forEach var="product" items="${productList}">
                  <div class="col">
                    <div class="card bg-body-tertiary h-100 product-item">
                      <a href="product-detail?id=${product.id}">
                        <img src="${product.image}" height="400px" class="card-img object-fit-cover product-image" alt="${product.name}" />
                      </a>
                      <div class="position-absolute p-2 product-category">
                        <c:if test="${sessionScope.user.role eq 'admin'}">
                          <a class="badge text-bg-success rounded-pill nav-link" href="product?id=${product.id}">Edit</a>
                        </c:if>
                        <c:forEach items="${productCategoryMap.get(product.id)}" var="category">
                          <a class="badge text-bg-primary rounded-pill nav-link" href="product-list?category-id=${category.id}">${category.name}</a>
                        </c:forEach>
                      </div>
                      <div class="card-body product-info">
                        <small class="float-end text-muted product-import-date"><fmt:formatDate type="date" value="${product.importDate}" /></small>
                        <h5 class="card-title text-truncate product-name">${product.name}</h5>
                        <div class="card-text text-truncate product-description"><%--${fn:substring((product.description), 0, 50)}...--%>${product.description}</div>
                        <div class="mt-2">
                          <span class="text-success fs-4 product-sale-price"> $${product.salePrice} </span>
                          <small class="text-secondary text-decoration-line-through product-unit-price"> $${product.unitPrice} </small>
                          <span class="float-end d-flex gap-1">
                            <a href="#" class="btn btn-outline-primary border-0 rounded-circle"> <i class="bi bi-cart"></i> </a>
                            <a href="product-detail?id=${product.id}" class="btn btn-primary rounded-pill"> More info </a>
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                </c:forEach>
              </div>
              <div class="container d-flex px-0 justify-content-between">
                <c:if test="${productList ne null and not empty productList and totalPages ne 1}">
                  <nav>
                    <c:url var="pageURL" value="product-list">
                      <c:param name="query" value="${query}" />
                      <c:if test="${order ne null and order ne 0}"><c:param name="order" value="${order}" /></c:if>
                      <c:if test="${size ne null and size ne 9}"><c:param name="size" value="${size}" /> </c:if>
                      <%--<c:if test="${display ne null and display ne 2}"><c:param name="display" value="${display}" /> </c:if>--%>
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
                </c:if>
              </div>
            </div>
          </div>
        </div>
      </form>
    </main>

    <jsp:include page="part/footer.jsp" />

    <script src="js/bootstrap.bundle.min.js"></script>
    <script
      async
      src="https://cdn.jsdelivr.net/npm/masonry-layout@4.2.2/dist/masonry.pkgd.min.js"
      integrity="sha384-GNFwBvfVxBkLMJpYMOABq3c+d3KnQxudP/mGPkzpZSTYykLBNsZEnG2D9G/X/+7D"
      crossorigin="anonymous"
    ></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script>
      const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
      const tooltipList = [...tooltipTriggerList].map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl));

      $(document).ready(function () {
        let lastInfoCount = parseInt($("#display").val(), 10);

//        $(".product-description").text($(".product-description").text());

        $("#display").on("input", function () {
          let infoCount = parseInt($(this).val(), 10);
          let elements = [
            // ".product-image",
            ".product-category",
            [".product-name", ".product-info"],
            ".product-sale-price",
            ".product-import-date",
            ".product-description",
            ".product-unit-price",
          ];
          if (infoCount < 0) {
            infoCount = 0;
          } else if (infoCount > elements.length) {
            infoCount = elements.length;
          }

          $(".product-item").each(function () {
            $(this).find(elements.flat().join(",")).hide().removeClass("item masonry-brick");

            for (let i = infoCount - 1; i >= 0; i--) {
              let selector = elements[i];

              if (Array.isArray(selector)) {
                $(this).find(selector.join(",")).show();
              } else {
                $(this).find(selector).show();
              }
            }
          });

          $("#product-list").masonry();
        });
      });
    </script>
  </body>
</html>
