$(document).ready(function () {
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  const tooltipList = [...tooltipTriggerList].map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl));

  const maxFiles = 4;
  const maxSizeInMB = 50;
  const maxSizeInBytes = maxSizeInMB * 1024 * 1024;
  const $writeReviewBtn = $("#write-review-btn");

  const $reviewContainer = $("#user-reviews-container");
  const productId = 25;
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
          return `<a href="${a.attachment}" class="btn btn-sm ${attachmentType[a.type][0]} rounded-pill px-3">
                              <i class="bi ${attachmentType[a.type][1]}"></i>
                            </a>`;
        })
        .join("\n");

      if (attachmentList.length) {
        attachmentHtml = `<div class="mt-2">${attachmentHtml}</div>`;
      }

      let reviewItem = `
            <div class="card bg-body-tertiary" id="review-${review.reviewId}">
              <div class="card-body d-flex justify-content-between">
                <div class="d-flex mb-2 mb-md-0">
                  <img src="${review.userAvatar || "asset/img/default_picture.png"}" class="rounded-circle me-3" height="48" width="48" />
                  <div class="flex-auto">
                    <h5 class="lh-1 mb-0 d-inline-flex align-items-center gap-2">
                      <span>@${review.userName}</span>
                      <i class="ratings text-warning fs-6" value="${review.rating}" max="5"></i>
                    </h5>
                    <small class="fw-light text-muted text-nowrap">${review.createdAt}</small>
                    <p class="mb-0">${review.comment}</p>
                    ${attachmentHtml}
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

    offset += result.reviewList.length;

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
        $("#modal-product-rating").text(`${result.productRating.toFixed(1)} out of 5.0`);
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

  $("#reviewsModal")
    .on("show.bs.modal", (e) => {
      offset = 0;
      loadReviews(productId);
    })
    .on("hide.bs.modal", (e) => {
      $reviewContainer.html(null);
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
      errorMessage += `You can upload a maximum of ${maxFiles} files. `;
    }

    files.forEach((file) => {
      if (file.size > maxSizeInBytes) {
        errorMessage += `${file.name} exceeds the size limit of ${maxSizeInMB} MB. `;
      }
    });

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

  $("#user-rating")
    .focus(() => {
      $("#star-select-container").addClass("border border-warning");
    })
    .blur(() => {
      $("#star-select-container").removeClass("border border-warning");
    })
    .on("input", function () {
      updateUserRatings($(this).val());
    });
});
