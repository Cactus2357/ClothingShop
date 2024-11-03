<!--<%-- Document : user-review Created on : Oct 25, 2024, 4:04:06 PM Author : hi --%>-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix = "fmt" uri ="http://java.sun.com/jsp/jstl/fmt" %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- <%--${productRating}   ${reviewCount}   ${reviewList}   ${attachmentMap}--%> -->

<div class="container-fluid p-3 rounded">
  <style>
    .ratings {
      display: flex;
      gap: 0.25rem;
      align-items: center;
    }

    #attachments::-webkit-file-upload-button {
      display: none;
    }

    .attachment-btn {
      --bs-text-opacity: 1;
      --bs-border-opacity: 1;
      background-color: var(--bs-success-bg-subtle);
      color: rgba(var(--bs-success-rgb), var(--bs-text-opacity));
      border-color: rgba(var(--bs-success-rgb), var(--bs-border-opacity));
    }
    .attachment-input::-webkit-file-upload-button {
      display: none;
    }
  </style>
  <div class="container">
    <div class="d-flex gap-2 flex-wrap justify-content-between px-xl-5 mb-3">
      <div>
        <h3>Reviews</h3>
        <h4 class="d-flex">
          <span class="me-2"><fmt:formatNumber type="number" minFractionDigits="1" maxFractionDigits="1" value="${productRating}" /> out of 5.0</span>
          <span class="ratings text-warning me-2" value="${productRating}" max="5"></span>
        </h4>
        <span class="text-secondary">${reviewCount} rating(s)</span>
      </div>
      <c:if test="${sessionScope.user != null}">
        <button class="btn btn-outline-primary rounded-pill align-self-center" id="compose-review-btn">Write a review</button>
        <!-- <a href="#review-23" class="btn btn-outline-primary rounded-pill align-self-center" id="write-review-btn">See my review</a> -->
      </c:if>
    </div>
    <div class="container px-xl-5 mx-xl-5">
      <c:if test="${sessionScope.user != null}">
        <!-- Review Form -->
        <!--        <div class="card bg-body-tertiary" id="compose-review-container">
                  <div class="card-body">
                    <form action="review" method="post" enctype="multipart/form-data">
                      <input name="productId" value="${product.id}" type="hidden" hidden="" />
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
                                  <div class="d-flex gap-1 align-items-center overflow-hidden position-absolute top-0" id="star-select-container">
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
                          <div class="input-group input-group-sm mb-1">
                            <label class="btn attachment-btn rounded-pill" for="attachments"> <i class="bi bi-paperclip me-1"></i>&le; 4 Attachment(s) </label>
                            <input type="file" name="attachment[]" accept="video/*,image/*" id="attachments" class="form-control bg-transparent border-0 shadow-none" multiple />
                            <span class="form-text">&le; 50MB</span>
                          </div>
                          <textarea class="flex-grow-1 w-100 form-control" rows="4" name="comment" id="user-review"></textarea>
                        </div>
                      </div>
                      <div class="float-end d-flex gap-2 mt-md-2" id="review-control">
                        <button type="reset" id="cancel-review-btn" class="btn btn-sm btn-outline-secondary rounded-pill px-4 border-0" onclick="discard(this)">Cancel</button>
                        <button type="submit" id="submit-review-btn" class="btn btn-sm btn-primary rounded-pill px-4">Post</button>
                      </div>
                    </form>
                  </div>
                </div>-->
        <!-- User Reviews -->
        <div class="row g-3 mx-xl-5 mb-3">
          <!-- User write review -->
          <div class="card bg-body-tertiary" id="compose-review-container">
            <div class="card-body">
              <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
                <symbol id="bi-plus-lg" viewBox="0 0 16 16">
                  <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2" />
                </symbol>
                <symbol id="bi-x-lg" viewBox="0 0 16 16">
                  <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8z" />
                </symbol>
              </svg>
              <form action="review" method="post" enctype="multipart/form-data">
                <input name="productId" value="${product.id}" type="hidden" hidden="" />
                <div class="d-flex mb-2 mb-md-0">
                  <img src="${sessionScope.user.avatar ne null ? sessionScope.user.avatar : 'asset/img/default_picture.png'}" class="rounded-circle me-3" height="48" width="48" alt="${sessionScope.user.userName}" />
                  <div class="flex-auto flex-grow-1">
                    <h5 class="lh-1 d-flex align-items-center gap-2">
                      <span>@${sessionScope.user.userName}</span>
                      <span class="text-warning fs-6">
                        <input type="range" name="rating" min="1" max="5" id="user-rating" class="visually-hidden position-absolute" style="height: 1px; width: 96px" required />
                        <span class="d-flex position-absolute" style="top: 18px">
                          <div class="d-inline-block">
                            <i class="ratings" value="0" max="5"></i>
                            <div class="d-flex gap-1 align-items-center overflow-hidden position-absolute top-0" id="star-select-container">
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
                    <button class="btn btn-sm btn-outline-primary mb-2" type="button" id="add-attachment-btn">
                      <svg class="bi me-1" width="1em" height="1em"><use href="#bi-plus-lg"></use></svg>
                      <span>Add attachment</span>
                      <span class="form-text">&lt; 10MB</span>
                    </button>
                    <div id="user-attachments"></div>
                    <textarea class="form-control" rows="4" name="comment" id="user-review"></textarea>
                  </div>
                </div>
                <script>
                  $(() => {
                    const $composeReviewContainer = $("#compose-review-container");
                    const $userAttachments = $("#user-attachments");
                    const $addAttachmentBtn = $("#add-attachment-btn");
                    const $composeReviewBtn = $("#compose-review-btn");
                    const $userReview = $("#user-review");
                    const $userRating = $("#user-rating");
                    const $starSelectContainer = $("#star-select-container");
                    const maxFiles = 4;
                    const maxFileSizeInMB = 50;
                    const maxFileSizeInByte = maxFileSizeInMB * 1024 * 1024;
                    const starSelectBorderClass = "border border-warning";

                    function updateUserRating(rating = 0) {
                      $(".star-select").css("opacity", function () {
                        return $(this).data("bs-value") <= rating ? 1 : 0;
                      });
                    }

                    function edit(btn) {
                      $composeReviewBtn.prop("disabled", true);
                      $composeReviewContainer.show();
                      $userReview.focus();
                      $addAttachmentBtn.show();
                    }

                    function discard(btn) {
                      $composeReviewBtn.prop("disabled", false);
                      $composeReviewContainer.hide();
                      $userAttachments.empty();
                      updateUserRating();
                    }

                    $composeReviewBtn.click(edit);
                    $("#cancel-review-btn").click(discard);

                    $userAttachments
                            .on("click", ".remove-attachment", function () {
                              $(this).closest(".attachment").remove();
                              $addAttachmentBtn.show();
                            })
                            .on("change", ".attachment-input", function (e) {
                              const file = e.target.files[0];
                              if (file.size > maxFileSizeInByte) {
                                alert(`"${file.name}" exceeds the size limit of ${maxFileSizeInMB}MB.`);
                                $(this).val(null);
                              }
                            });

                    $addAttachmentBtn.click(function () {
                      $userAttachments.append(`<div class="input-group input-group-sm mb-2 attachment">
                        <button class="btn btn-outline-danger remove-attachment" type="button"><svg class="bi" width="1em" height="1em"><use href="#bi-x-lg"></use></svg></button>
                        <input type="file" name="attachment[]" accept="video/*,image/*" class="form-control attachment-input" required />
                        <input type="text" name="attachment-description[]" class="form-control w-50" placeholder="Short description... (optional)" />
                      </div>`);

                      if ($userAttachments.children(".attachment").length >= maxFiles) {
                        $(this).hide();
                      }
                    });

                    $(".star-select").click(function () {
                      const value = $(this).data("bs-value");
                      $userRating.val(value).trigger("input");
                    });

                    $userRating
                            .on("focus blur", function (e) {
                              $starSelectContainer.toggleClass(starSelectBorderClass, e.type === "focus");
                            })
                            .on("input", function () {
                              updateUserRating($(this).val());
                            });

                    // initial
                    updateUserRating();
                    $composeReviewContainer.hide();
                  });
                </script>
                <div class="float-end d-flex gap-2 mt-md-2" id="review-control">
                  <button type="reset" id="cancel-review-btn" class="btn btn-sm btn-outline-secondary rounded-pill px-4 border-0">Discard</button>
                  <button type="submit" id="submit-review-btn" class="btn btn-sm btn-primary rounded-pill px-4">Post</button>
                </div>
              </form>
            </div>
          </div>
          <!-- User write review -->
        </div>
      </c:if>
      <div class="row g-3 mx-xl-5 mb-3" id="new-review-container"></div>
      <!--      <div class="row g-3 mb-3 mx-xl-5">
      <c:choose>
        <c:when test="${reviewList eq null}">
          <h5 class="text-center text-danger">Failed to retrieve reviews</h5>
        </c:when>
        <c:when test="${empty reviewList}">
          <h5 class="text-center">No reviews yet</h5>
        </c:when>
        <c:otherwise>
          <c:forEach items="${reviewList}" var="review">
            <div class="card bg-body-tertiary">
              <div class="card-body d-flex justify-content-between">
                <div class="d-flex mb-2 mb-md-0">
                  <img src="${review.userAvatar != null ? review.userAvatar : 'asset/img/default_picture.png'}" class="rounded-circle me-3" height="48" width="48" />
                  <div class="flex-auto">
                    <h5 class="lh-1 mb-0 d-inline-flex align-items-center gap-2">
                      <span>@${review.userName}</span>
                      <i class="ratings text-warning fs-6" value="${review.rating}" max="5"></i>
                    </h5>
                    <small class="fw-light text-muted text-nowrap">
            <fmt:formatDate type="date" value="${review.createdAt}" />
          </small>
          <p class="mb-0">${review.comment}</p>

            <c:if test="${not empty attachmentMap[review.reviewId]}">
              <div class="mt-2">
              <c:forEach items="${attachmentMap[review.reviewId]}" var="attachment">
                <c:choose>
                  <c:when test="${attachment.type eq 'image'}">
                    <a href="${attachment.attachment}" class="btn btn-sm btn-outline-primary rounded-pill px-3">
                      <i class="bi bi-image"></i>
                    </a>
                  </c:when>
                  <c:when test="${attachment.type eq 'video'}">
                    <a href="${attachment.attachment}" class="btn btn-sm btn-outline-danger rounded-pill px-3">
                      <i class="bi bi-camera-video"></i>
                    </a>
                  </c:when>
                  <c:otherwise>
                    <a href="${attachment.attachment}" class="btn btn-sm btn-outline-secondary rounded-pill px-3">
                      <i class="bi bi-paperclip"></i>
                    </a>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
            </div>
            </c:if>
          </div>
        </div>
        <button type="button" class="btn rounded-circle align-self-start"><i class="bi bi-three-dots-vertical"></i></button>
      </div>
    </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>-->
      <c:if test="${haveMoreReviews}">
        <button class="btn btn-outline-primary border-0 rounded-pill mx-xl-5" data-bs-toggle="modal" data-bs-target="#reviewsModal">See all reviews</button>
      </c:if>
    </div>
  </div>

  <div class="modal fade" id="reviewsModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-fullscreen-md-down modal-xl">
      <div class="modal-content" style="min-height: 80dvh">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="reviewsModalLabel">User reviews</h1>
          <span class="fw-semibold fs-5 ms-4" id="modal-product-rating">0.0 out of 5.0</span>
          <span class="fs-5 ratings text-warning ms-2" value="0.0" max="5" id="modal-star-rating"></span>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div class="container-fluid px-5">
            <div class="row g-3 mx-xl-5 mb-3" id="user-reviews-container"></div>
            <div class="d-flex">
              <button class="btn btn-outline-primary rounded-pill px-4 mx-auto" id="load-more-btn">Load more</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
//    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
//    const tooltipList = [...tooltipTriggerList].map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl));

    $(document).ready(function () {
      $("body").tooltip({
        selector: ".attachment",
      });

      const attachmentType = {
        image: ["btn-outline-primary", "bi bi-image"],
        video: ["btn-outline-danger", "bi bi-camera-video"],
        default: ["btn-outline-secondary", "bi bi-paperclip"],
      };

      const spinnerHtml = '<div class="spinner-border mx-auto" role="status"><span class="visually-hidden">Loading...</span></div>';
      const $reviewContainer = $("#user-reviews-container");
      const $loadMoreBtn = $("#load-more-btn");
      const urlParams = new URLSearchParams(window.location.search);
      const productId = urlParams.get("id");
      let offset = 0;

      function appendReview(response, container = $reviewContainer) {
        if (!response.reviewList.length) {
          container.html(`<h5 class="text-center">">No review yet</h5>`);
          $loadMoreBtn.hide();
          return;
        }

        response.reviewList.forEach((review) => {
//          let attachmentHtml = (response.attachmentMap[review.reviewId] || [])
//                  .map((a) => {
//                    return `<a href="\${a.attachment}" class="btn btn-sm me-1 mb-1 \${attachmentType[a.type][0]} rounded-pill px-3"><i class="\${attachmentType[a.type][1]}"></i></a>`;
//                  })
//                  .join("");
//
//          if (attachmentHtml.length)
//            attachmentHtml = `<div class="mt-2">\${attachmentHtml}</div>`;
          let $attachmentHtml = $('<div class="mt-2"></div>');
          (response.attachmentMap[review.reviewId] || []).forEach((a) => {
            let $attachmentLink = $(`<a href="\${a.attachment}" class="btn btn-sm me-1 mb-1 attachment \${attachmentType[a.type][0]} rounded-pill px-3"><i class="\${attachmentType[a.type][1]}"></i></a>`);
            if (a.description) {
              $attachmentLink.attr({
                "data-bs-toggle": "tooltip",
                "data-bs-title": a.description,
              });
            }
            $attachmentHtml.append($attachmentLink);
          });


          let reviewItem = `
            <div class="card bg-body-tertiary" id="review-\${review.reviewId}">
              <div class="card-body d-flex justify-content-between">
                <div class="d-flex mb-2 mb-md-0">
                  <img src="\${review.userAvatar || "asset/img/default_picture.png"}" class="rounded-circle me-3" height="48" width="48" />
                  <div class="flex-auto">
                    <div class="lh-1 mb-0 d-inline-flex flex-wrap align-items-center gap-2">
                      <span class="fw-semibold">@\${review.userName}</span>
                      <i class="ratings text-warning fs-6" value="\${review.rating}" max="5"></i>
                      <small class="fw-light text-muted">\${review.createdAt}</small>
                    </div>
                    <p class="mb-0">\${review.comment}</p>
                    \${$attachmentHtml.prop("outerHTML")}
                  </div>
                </div>
                <button type="button" class="btn rounded-circle align-self-start">
                  <i class="bi bi-three-dots-vertical"></i>
                </button>
              </div>
            </div>`;

          // reviewHtml.push(reviewItem);
          container.append(reviewItem);
        });

        $(".ratings").each(updateRating);
        offset += response.reviewList.length;

        if (response.haveMoreReviews) {
          $loadMoreBtn.show();
        } else {
          $loadMoreBtn.hide();
      }
      }

      function loadReviews( { productId = 25, limit = 10, offset = 0, container = $("#user-reviews-container") }) {
        const timeOut = 0;
        $loadMoreBtn.hide();
        container.append(spinnerHtml);
        $.ajax({
          url: "http://localhost:8080/shop/review",
          type: "get",
          data: {
            productId: productId,
            limit: limit,
            offset: offset, },
          timeout: 5000,
          success: (result) => {
            $("#modal-product-rating").text(`\${result.productRating.toFixed(1)} out of 5.0`);
            $("#modal-star-rating").attr("value", result.productRating);
            $(".ratings").each(updateRating);

            setTimeout(() => {
              appendReview(result, container);
              container.children(".spinner-border").remove();
            }, timeOut);
          },
          error: (xhr, status, error) => {
            console.error("Error:", error);
            setTimeout(() => {
              container.html(`<h5 class="text-center text-danger">Failed to retrieve user reviews</h5>`);
              $loadMoreBtn.show();
            }, timeOut);
          },
        });
      }

      $loadMoreBtn.click(() => {
        loadReviews({productId: productId, offset: offset});
      });

      $("#reviewsModal")
              .on("show.bs.modal", (e) => {
                offset = 0;
                loadReviews({productId: productId});
              })
              .on("hide.bs.modal", (e) => {
                $reviewContainer.html(null);
              });

      // loadReviews(productId, 3, 0, $("#new-review-container"));
      loadReviews({productId: productId, limit: 3, container: $("#new-review-container")});

      /// /// /// /// /// /// /// /// /// ///

      function updateRating() {
        let rating = parseFloat($(this).attr("value"));
        let maxRating = parseFloat($(this).attr("max")) || 5;
        let fullStars = Math.floor(rating);
        let halfStar = rating % 1 >= 0.5 ? 1 : 0;
        let emptyStars = maxRating - fullStars - halfStar;
        let starsHtml = '<i class="bi bi-star-fill"></i>'.repeat(fullStars) + (halfStar ? '<i class="bi bi-star-half"></i>' : "") + '<i class="bi bi-star"></i>'.repeat(emptyStars);
        $(this).html(starsHtml);
      }
    });
  </script>

  <!-- Modal for all reviews -->
  <!--  <div class="modal fade" id="reviewsModal" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-fullscreen-lg-down modal-xl">
        <div class="modal-content" style="min-height: 80dvh">
          <div class="modal-header">
            <h1 class="modal-title fs-3" id="reviewsModalLabel">User reviews</h1>
            <span class="fw-semibold fs-5 ms-4" id="modal-product-rating">0.0 out of 5.0</span>
            <span class="fs-5 ratings text-warning ms-2" value="0.0" max="5" id="modal-star-rating"></span>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <div class="container p-5">
              <div class="row g-3 mx-xl-5 mb-3" id="user-reviews-container"></div>
              <div class="d-flex">
                <button class="btn btn-outline-primary rounded-pill px-4 mx-auto" id="load-more-btn">Load more</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  
    <script>
      $(() => {
        const maxFiles = 4;
        const maxSizeInMB = 50;
        const maxSizeInBytes = maxSizeInMB * 1024 * 1024;
        const $writeReviewBtn = $("#write-review-btn");
  
        const $reviewContainer = $("#user-reviews-container");
        // const $("#load-more-btn") = $("#load-more-btn");
        const productId = ${product.id};
        const spinnerHtml = '<div class="spinner-border mx-auto" role="status"><span class="visually-hidden">Loading...</span></div>';
        let offset = 0;
  
        function appendReview(result) {
          if (!result.reviewList.length) {
            $reviewContainer.html(`<h5 class="text-center">">No review yet</h5>`);
            $("#load-more-btn").hide();
            return;
          }
  
          let reviewHtml = [];
          const attachmentType = {
            image: ["btn-outline-primary", "bi-image"],
            video: ["btn-outline-danger", "bi-camera-video"],
            default: ["btn-outline-secondary", "bi-paperclip"],
          };
  
          result.reviewList.forEach((review) => {
            let attachmentList = result.attachmentMap[review.reviewId] || [];
            let attachmentHtml = attachmentList
                    .map((a) => {
                      return `<a href="\${a.attachment}" class="btn btn-sm \${attachmentType[a.type][0]} rounded-pill px-3">
                                <i class="bi \${attachmentType[a.type][1]}"></i>
                              </a>`;
                    })
                    .join("\n");
  
            if (attachmentList.length) {
              attachmentHtml = `<div class="mt-2">\${attachmentHtml}</div>`;
            }
  
            let reviewItem = `
              <div class="card bg-body-tertiary" id="review-\${review.reviewId}">
                <div class="card-body d-flex justify-content-between">
                  <div class="d-flex mb-2 mb-md-0">
                    <img src="\${review.userAvatar || "asset/img/default_picture.png"}" class="rounded-circle me-3" height="48" width="48" />
                    <div class="flex-auto">
                      <h5 class="lh-1 mb-0 d-inline-flex align-items-center gap-2">
                        <span>@\${review.userName}</span>
                        <i class="ratings text-warning fs-6" value="\${review.rating}" max="5"></i>
                      </h5>
                      <small class="fw-light text-muted text-nowrap">\${review.createdAt}</small>
                      <p class="mb-0">\${review.comment}</p>
                      \${attachmentHtml}
                    </div>
                  </div>
                  <button type="button" class="btn rounded-circle align-self-start">
                    <i class="bi bi-three-dots-vertical"></i>
                  </button>
                </div>
              </div>`;
  
            reviewHtml.push(reviewItem);
          });
  
          $reviewContainer.append(reviewHtml.join(""));
          updateRatings();
  
          offset += result.reviewList.length
  
          if (!result.haveMoreReviews) {
            $("#load-more-btn").hide();
          } else {
            $("#load-more-btn").show();
          }
        }
  
        function loadReviews(productId, offset = 0) {
          const timeOut = 1500;
          $("#load-more-btn").hide();
          $.ajax({
            url: "review",
            type: "get",
            timeout: 5000,
            data: {
              productId: productId,
              offset: offset,
            },
            success: (result, status, xhr) => {
              $("#modal-product-rating").text(`\${result.productRating.toFixed(1)} out of 5.0`);
              $("#modal-star-rating").attr("value", result.productRating);
              $reviewContainer.append(spinnerHtml);
              $(".ratings").each(updateRatings);
              setTimeout(() => {
                appendReview(result);
                $("#user-reviews-container .spinner-border").remove();
                $(".ratings").each(updateRatings);
              }, timeOut);
            },
            error: (xhr, status, error) => {
              console.error("Error:", error);
              setTimeout(() => {
                $("#user-reviews-container").html(`<h5 class="text-center text-danger">Fail to retrieve user reviews</h5>`);
              }, timeOut);
              $("#load-more-btn").show();
            },
          });
        }
  
        $("#load-more-btn").click(loadReviews(productId, offset));
  
        $("#reviewsModal").on("show.bs.modal", (e) => {
          offset = 0;
          loadReviews(productId);
        }).on('hide.bs.modal', (e) => {
          $reviewContainer.html(null)
        });
  
        /// /// /// /// /// /// /// /// /// ///
  
        function edit(btn) {
          $writeReviewBtn.attr("disabled", true);
          $("#compose-review-container").show();
          $("#user-review").focus();
        }
  
        function discard(btn) {
          $writeReviewBtn.attr("disabled", false);
          $("#compose-review-container").hide();
          $("#user-review").html(null);
        }
  
        function updateUserRatings(rating) {
          $(".star-select").each(function () {
            $(this).css("opacity", $(this).data("bs-value") <= rating ? 1 : 0);
          });
        }
  
        function updateRatings() {
          let rating = parseFloat($(this).attr("value"));
          let maxRating = parseFloat($(this).attr("max")) || 5;
          let fullStars = Math.floor(rating);
          let halfStar = rating % 1 >= 0.5 ? 1 : 0;
          let emptyStars = maxRating - fullStars - halfStar;
          let html = '<i class="bi bi-star-fill"></i>'.repeat(fullStars) + (halfStar ? '<i class="bi bi-star-half"></i>' : "") + '<i class="bi bi-star"></i>'.repeat(emptyStars);
          $(this).html(html);
        }
  
        updateUserRatings(0);
        $("#compose-review-container").hide();
        $("#write-review-btn").click(edit);
        $("#cancel-review-btn").click(discard);
  
        $("#attachments").on("change", function (event) {
          const files = event.target.files;
          let errorMessage = "";
          if (files.length > maxFiles) {
            errorMessage += `You can upload a maximum of \${maxFiles} files. `;
          }
  
          files.forEach(file => {
            if (file.size > maxSizeInBytes) {
              errorMessage += `\${file.name} exceeds the size limit of \${maxSizeInMB} MB. `;
            }
          })
  
          if (errorMessage) {
            alert(errorMessage);
            $(this).val(null);
          }
        });
  
        $(".ratings").each(updateRatings);
  
        $(".star-select").click((e) => {
          let value = $(e.target).data("bs-value");
          $("#user-rating").val(value).trigger("input");
        });
  
        $("#user-rating").focus(() => {
          $("#star-select-container").addClass("border border-warning");
        }).blur(() => {
          $("#star-select-container").removeClass("border border-warning");
        }).on("input", function () {
          updateUserRatings($(this).val());
        });
      });
    </script>-->
</div>
