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
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-bs5.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-bs5.min.js"></script>
    <link rel="stylesheet" href="asset/style/image-placeholder.css"/>

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

      .hidden-element {
        display: none;
      }
    </style>
  </head>
  <body>
    <jsp:include page="part/navbar.jsp" />

    <!--  -->
    <main class="container-fluid pt-5 px-3">
      <div class="row g-3">
        <div class="col-12 col-md-4 col-xl-3">
          <aside class="container-fluid sticky-top" style="top: 4.5rem">
            <div class="border bg-body-tertiary rounded p-2 row">
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
                <input type="range" class="form-range" min="0" step="10" max="100" value="23" id="min-sale-price" oninput="$('#rangeOutput1').val(this.value)" />
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
              <div class="mb-3">
                <label class="form-label" for="display">Information count</label>
                <input type="range" class="form-control" value="6" min="0" max="6" id="display" placeholder="Display" />
              </div>
            </div>
          </aside>
        </div>
        <div class="col-12 col-md-8 col-xl-9">
          <div class="row row-cols-1 row-cols-xl-2 g-3 mb-3">
            <div cass="col">
              <c:choose>
                <c:when test="${product.image ne null}">
                  <img src="${product.image}" class="img-fluid border rounded w-100" alt="product-image" />
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
                  <c:forEach items="${categoryList}" var="category">
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
                <h5 class="product-stock">In stock: <span class="text-muted fw-normal"> 20 items </span></h5>
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
          <div class="container-fluid p-3 rounded">
            <div class="container">
              <div class="d-flex gap-2 flex-wrap justify-content-between px-xl-5 mb-3">
                <div>
                  <h3>Reviews</h3>
                  <h4 class="d-flex">
                    <span class="me-2">${productRating} out of 5.0</span>
                    <span class="ratings text-warning me-2" value="${productRating}" max="5"></span>
                  </h4>
                  <span class="text-secondary">${reviewCount} ratings</span>
                </div>
                <button class="btn btn-outline-primary rounded-pill align-self-center" id="write-review-btn" onclick="edit(this)">Write a review</button>
                <!-- <a href="#review-23" class="btn btn-outline-primary rounded-pill align-self-center" id="write-review-btn">See my review</a> -->
              </div>

              <div class="container px-xl-5">
                <div class="row g-3 mx-xl-5 mb-3">
                  <!-- User write review -->
                  <div class="card bg-body-tertiary" id="user-review-container">
                    <div class="card-body">
                      <form action="">
                        <div class="d-flex mb-2 mb-md-0">
                          <img src="asset/img/default_picture.png" class="rounded-circle me-3" height="48" width="48" />
                          <div class="flex-auto flex-grow-1">
                            <h5 class="lh-1 mb-0 d-inline-flex align-items-center gap-2">
                              <span>Admin</span>
                              <span class="text-warning fs-6">
                                <input type="range" name="rating" min="1" max="5" id="user-rating" class="opacity-0 position-absolute" style="height: 1px; width: 96px" required />
                                <span class="d-flex position-absolute" style="top: 18px">
                                  <div class="d-inline-block">
                                    <i class="ratings" value="0" max="5"></i>
                                    <div class="ratings overflow-hidden position-absolute top-0" id="star-select-container">
                                      <i class="bi bi-star-fill star-select" data-bs-value="1"></i>
                                      <i class="bi bi-star-fill star-select" data-bs-value="2"></i>
                                      <i class="bi bi-star-fill star-select" data-bs-value="3"></i>
                                      <i class="bi bi-star-fill star-select" data-bs-value="4"></i>
                                      <i class="bi bi-star-fill star-select" data-bs-value="5"></i>
                                    </div>
                                  </div>
                                </span>
                              </span>
                            </h5>
                            <textarea class="flex-grow-1 w-100" name="user-review" id="user-review"></textarea>
                          </div>
                        </div>
                        <div class="float-end d-flex gap-2 mt-md-2" id="review-control">
                          <button type="reset" id="cancel-review-btn" class="btn btn-secondary rounded-pill px-4" onclick="discard(this)">Cancel</button>
                          <button type="submit" id="submit-review-btn" class="btn btn-primary rounded-pill px-4">Post</button>
                        </div>
                      </form>
                    </div>
                  </div>
                  <!-- User write review -->

                  <c:choose>
                    <c:when test="${reviewList eq null}" >
                      <h5 class="text-center text-danger">Fail to retrieve user reviews</h5>
                    </c:when>
                    <c:when  test="${empty reviewList}">
                      <h5 class="text-center">No review yet</h5>
                    </c:when>
                    <c:otherwise>
                      <c:forEach items="${reviewList}" var="review">
                        <div class="card bg-body-tertiary">
                          <div class="card-body d-flex justify-content-between">
                            <div class="d-flex mb-2 mb-md-0">
                              <img src="${review.userAvatar}" class="rounded-circle me-3" height="48" width="48" />
                              <div class="flex-auto">
                                <h5 class="lh-1 mb-0 d-inline-flex align-items-center gap-2">
                                  <span>@${review.userName}</span>
                                  <i class="ratings text-warning fs-6" value="${review.rating}" max="5"></i>
                                </h5>
                                <small class="fw-light text-muted text-nowrap"> <fmt:formatDate type="date" value="${review.createdAt}" /> </small>
                                <p class="mb-0">${review.comment}</p>
                              </div>
                            </div>
                            <button type="button" class="btn rounded-circle align-self-start"><i class="bi bi-three-dots-vertical"></i></button>
                          </div>
                        </div>
                      </c:forEach>
                      <a class="btn btn-outline-primary border-0 rounded-pill" href="javascript:void(0)">See all reviews</a>
                    </c:otherwise>
                  </c:choose>

                </div>
              </div>
            </div>
          </div>
        </div>
    </main>
    <!--  -->
    <jsp:include page="part/footer.jsp" />

    <script src="js/bootstrap.bundle.min.js">
    </script>
    <script>
      const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
      const tooltipList = [...tooltipTriggerList].map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl));
      const $writeReviewBtn = $("#write-review-btn");
      const setting = {
        toolbar: [
          ["font", ["bold", "italic", "underline"]],
          ["para", ["ul", "ol", "paragraph"]],
          ["insert", ["picture", "video"]],
        ],
        placeholder: "Write a review here...",
        minHeight: 100,
      };

      function edit(btn) {
        // $(btn).addClass("disabled");
        $writeReviewBtn.attr("disabled", true);
        $("#user-review-container").show();
        $("#user-review").summernote({focus: true});
      }

      function discard(btn) {
        $writeReviewBtn.attr("disabled", false);
        $("#user-review-container").hide();
        $("#user-review").html(null);
        // $("#user-review").summernote("destroy");
      }

      // function save(btn) {
      //   $writeReviewBtn.attr("disabled", true);
      //   let markup = $("#user-review").summernote("code");
      //   if (!markup || markup == "<p><br></p>") {
      //     $("#user-review").html(null);
      //   }
      //   $("#user-review").summernote("destroy");
      //   $("#user-review").val(markup);
      //   $("#review-control").remove();
      // }

      $(document).ready(function () {
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

        updateStars(0);
        $("#user-review").summernote(setting);
        $("#user-review-container").hide();
        $("#write-review-btn").click(edit);
        $("#cancel-review-btn").click(discard);
        // $("#submit-review-btn").click(save);

        function updateStars(rating) {
          $(".star-select").each(function () {
            $(this).css("opacity", $(this).data("bs-value") <= rating ? 1 : 0);
          });
        }

        $(".star-select").click((e) => {
          let value = $(e.target).data("bs-value");
          $("#user-rating").val(value).trigger("input");
        });

        $("#user-rating")
                .focus(() => {
                  $("#star-select-container").addClass("border border-black");
                })
                .blur(() => {
                  $("#star-select-container").removeClass("border border-black");
                });

        $("#user-rating").on("input", function () {
          updateStars($(this).val());
        });
      });
    </script>
  </body>
</html>
