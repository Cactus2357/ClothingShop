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
      <button class="btn btn-outline-primary rounded-pill align-self-center" id="write-review-btn" onclick="edit(this)">Write a review</button>
      <!-- <a href="#review-23" class="btn btn-outline-primary rounded-pill align-self-center" id="write-review-btn">See my review</a> -->
    </div>
    <div class="container px-xl-5 mx-xl-5">
      <div class="row g-3 mb-3">
        <!-- Review Form -->
        <div class="card bg-body-tertiary" id="compose-review-container">
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
        </div>

        <!-- User Reviews -->
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
      </div>
      <c:if test="${not empty reviewList and haveMoreReviews}">
        <button class="btn btn-outline-primary border-0 rounded-pill" data-bs-toggle="modal" data-bs-target="#reviewsModal">See all reviews</button>
      </c:if>
    </div>
  </div>

  <!-- Modal for all reviews -->
  <div class="modal fade" id="reviewsModal" tabindex="-1">
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
            <!--            <h4 class="d-flex">
                          <span class="me-2" id="modal-product-rating">0.0 out of 5.0</span>
                          <span class="ratings text-warning me-2" value="" max="5" id="modal-star-rating"></span>
                        </h4>-->
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
                  .join("");

          if (attachmentList.length) {
            attachmentHtml = `<div class="mt-2">\${attachmentHtml}</div>`;
          }

          let reviewItem = `
            <div class="card bg-body-tertiary" id="review-${review.reviewId}">
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
            $(".ratings").each(updateUserRating);
            $reviewContainer.append(spinnerHtml);
            setTimeout(() => {
              appendReview(result);
              $("#user-reviews-container .spinner-border").remove();
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

      $("#load-more-btn").click(() => {
        loadReviews(productId, offset)
      });

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

      function updateUserRating() {
        let rating = parseFloat($(this).attr("value"));
        let maxRating = parseFloat($(this).attr("max")) || 5;
        let fullStars = Math.floor(rating);
        let halfStar = rating % 1 >= 0.5 ? 1 : 0;
        let emptyStars = maxRating - fullStars - halfStar;
        let html = '<i class="bi bi-star-fill"></i>'.repeat(fullStars) + (halfStar ? '<i class="bi bi-star-half"></i>' : "") + '<i class="bi bi-star"></i>'.repeat(emptyStars);
        $(this).html(html);
        $("#star-select-container star-select").each(s =>{
          if (s.attr('data-bs-value') <= rating) {
            s.addClass('bg-secondary bg-opacity-25')
          }
        })
      }

      updateUserRatings(0);
      $("#compose-review-container").hide();
      $("#write-review-btn").click(edit);
      $("#cancel-review-btn").click(discard);

      $("#attachments").on("change", function (event) {
        const files = event.target.files;
        let errorMessage = "";
        if (files.length > maxFiles) {
          errorMessage += `You can upload a maximum of ${maxFiles} files. `;
        }
        for (let i = 0; i < files.length; i++) {
          if (files[i].size > maxSizeInBytes) {
            errorMessage += `${files[i].name} exceeds the size limit of ${maxSizeInMB} MB. `;
          }
        }
        if (errorMessage) {
          alert(errorMessage);
          $(this).val(null);
        }
      });

      $(".ratings").each(updateUserRating);

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
  </script>
</div>
