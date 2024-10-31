<%-- Document : product-detail Created on : Oct 1, 2024, 10:06:44 PM Author : hi --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${product.name}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-bs5.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-bs5.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/style/image-placeholder.css"/>

    <style>
      body {
        min-height: 75rem;
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

    <!--  -->
    <main class="container-fluid pt-5 px-3">
      <div class="row g-3">
        <div class="col-12 col-md-4 col-xl-3">
          <aside class="container-fluid sticky-top" style="top: 4.5rem">
            <div class="border bg-body-tertiary rounded p-2 mt-3 row">
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
                    <button class="btn btn-outline-primary text-start dropdown-toggle w-100" type="button" id="category" data-bs-toggle="dropdown">Select a Category</button>
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
                <label class="form-label">Product Details</label>
                <div class="form-check">
                  <input class="form-check-input toggle-display" type="checkbox" value="product-name" id="checkbox4" checked />
                  <label class="form-check-label" for="checkbox4"> Title </label>
                </div>
                <div class="form-check">
                  <input class="form-check-input toggle-display" type="checkbox" value="product-category" id="checkbox5" checked />
                  <label class="form-check-label" for="checkbox5"> Categories </label>
                </div>
                <div class="form-check">
                  <input class="form-check-input toggle-display" type="checkbox" value="product-sale-price" id="checkbox7" checked />
                  <label class="form-check-label" for="checkbox7"> Sale Price </label>
                </div>
                <div class="form-check">
                  <input class="form-check-input toggle-display" type="checkbox" value="product-unit-price" id="checkbox6" checked />
                  <label class="form-check-label" for="checkbox6"> Original Price </label>
                </div>
                <div class="form-check">
                  <input class="form-check-input toggle-display" type="checkbox" value="product-stock" id="checkbox8" checked />
                  <label class="form-check-label" for="checkbox8"> Quantity </label>
                </div>
                <div class="form-check">
                  <input class="form-check-input toggle-display" type="checkbox" value="product-import-date" id="checkbox9" checked />
                  <label class="form-check-label" for="checkbox9"> Import Date </label>
                </div>
                <div class="form-check">
                  <input class="form-check-input toggle-display" type="checkbox" value="product-description" id="checkbox10" checked />
                  <label class="form-check-label" for="checkbox10"> Description </label>
                </div>
              </div>
              <script>
                $(document).ready(function () {
                  // When any checkbox changes its state
                  $(".toggle-display").change(function () {
                    let classToToggle = $(this).val();
                    if ($(this).is(":checked")) {
                      $("." + classToToggle).show();
                    } else {
                      $("." + classToToggle).hide();
                    }
                  });
                });
              </script>
            </div>
          </aside>
        </div>
        <div class="col-12 col-md-8 col-xl-9 pt-3">
          <div class="row row-cols-1 row-cols-xl-2 g-3 mb-3">
            <div cass="col">
              <c:choose>
                <c:when test="${product.image ne null}">
                  <img src="${product.image}" class="img-fluid border rounded w-100" alt="${product.name}" />
                </c:when>
                <c:otherwise>
                  <div class="svg-image border rounded-3" id="product-image" style="font-size: 10em">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
                    <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0"></path>
                    <path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1z"></path>
                    </svg>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
            <div class="col">
              <div class="d-flex flex-column gap-3 bg-body-secondary rounded p-4 product-info">
                <h3 class="d-flex flex-wrap align-items-center gap-2">
                  <span class="me-3 product-name"> ${requestScope.product.name} </span>
                  <c:forEach items="${productCategoryList}" var="category">
                    <a class="badge text-bg-primary rounded-pill nav-link product-category" href="product-list?category-id=${category.id}">${category.name}</a>
                  </c:forEach>
                </h3>
                <h5 class="product-sale-price">
                  Pricing:
                  <span class="fw-normal gap-3">
                    <span class="text-success"> $${requestScope.product.salePrice} </span>
                    <small class="text-secondary text-decoration-line-through product-unit-price"> $${requestScope.product.unitPrice} </small>
                  </span>
                </h5>
                <h5 class="product-stock">In stock: <span class="text-muted fw-normal"> ${product.quantity} items </span></h5>
                <h5 class="product-import-date">Import date: <span class="text-muted fw-normal"> <fmt:formatDate type="both" dateStyle="long" timeStyle="short" value="${requestScope.product.importDate}" /> </span></h5>
                <div class="product-description">
                  <h5>Description</h5>
                  <p class="mx-3" style="text-align: justify; text-justify: inter-word"> ${requestScope.product.description} </p>
                </div>
                <div class="ms-auto d-flex gap-2">
                  <button class="btn btn-primary rounded-pill">Buy Now</button>
                  <button class="btn btn-outline-primary rounded-pill">Add to Cart</button>
                </div>
              </div>
            </div>
          </div>
          <hr />

          <jsp:include page="part/user-review.jsp"/>

        </div>
    </main>
    <!--  -->
    <jsp:include page="part/footer.jsp" />

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js">
    </script>
    <script>
      const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
      const tooltipList = [...tooltipTriggerList].map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl));
//      const $writeReviewBtn = $("#write-review-btn");
//      // const setting = {
//      //   toolbar: [
//      //     ["font", ["bold", "italic", "underline"]],
//      //     ["para", ["ul", "ol", "paragraph"]],
//      //     ["insert", ["picture", "video"]],
//      //   ],
//      //   placeholder: "Write a review here...",
//      //   minHeight: 100,
//      // };
//
//      function edit(btn) {
//        $writeReviewBtn.attr("disabled", true);
//        $("#user-review-container").show();
//        $("#user-review").focus(); /* .summernote({ focus: true }); */
//      }
//
//      function discard(btn) {
//        $writeReviewBtn.attr("disabled", false);
//        $("#user-review-container").hide();
//        $("#user-review").html(null);
//        // $("#user-review").summernote("destroy");
//      }
//
//      $(document).ready(function () {
//        $(".ratings").each(function () {
//          let rating = parseFloat($(this).attr("value"));
//          let maxRating = parseFloat($(this).attr("max")) || 5;
//          let fullStars = Math.floor(rating);
//          let halfStar = rating % 1 >= 0.5 ? 1 : 0;
//          let emptyStars = maxRating - fullStars - halfStar;
//          let starsHtml = '<i class="bi bi-star-fill"></i>'.repeat(fullStars) + (halfStar ? '<i class="bi bi-star-half"></i>' : "") + '<i class="bi bi-star"></i>'.repeat(emptyStars);
//          $(this).prepend(starsHtml);
//        });
//
//        updateStars(0);
//        // $("#user-review").summernote(setting);
//        $("#user-review-container").hide();
//        $("#write-review-btn").click(edit);
//        $("#cancel-review-btn").click(discard);
//
//        function updateStars(rating) {
//          $(".star-select").each(function () {
//            $(this).css("opacity", $(this).data("bs-value") <= rating ? 1 : 0);
//          });
//        }
//
//        $(".star-select").click((e) => {
//          let value = $(e.target).data("bs-value");
//          $("#user-rating").val(value).trigger("input");
//        });
//
//        $("#user-rating")
//                .focus(() => {
//                  $("#star-select-container").addClass("border border-warning");
//                })
//                .blur(() => {
//                  $("#star-select-container").removeClass("border border-warning");
//                });
//
//        $("#user-rating").on("input", function () {
//          updateStars($(this).val());
//        });
//      });
    </script>
  </body>
</html>
