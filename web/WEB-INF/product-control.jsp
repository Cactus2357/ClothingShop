<%-- Document : product-control Created on : Oct 1, 2024, 6:24:15 AM Author : hi --%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />

    <link rel="stylesheet" href="asset/style/theme-button.css" />
    <link rel="stylesheet" href="asset/style/select2-bootstrap-5-theme.css" />

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-bs5.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-bs5.min.js"></script>

    <script src="asset/script/color-modes.js"></script>
    <link rel="stylesheet" href="asset/style/image-placeholder.css" />

    <style>
      body {
        min-height: 75rem;
        padding-top: 4.5rem;
      }

      .dragging {
        border: 2px dashed rgba(var(--bs-primary-rgb), 1);
        background-color: #f8f9fa;
      }

      #image::-webkit-file-upload-button {
        display: none;
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
      <form action="product" method="post" id="product-form" enctype="multipart/form-data">
        <div class="row g-3">
          <div class="container">
            <h2 class="float-start">${product ne null ? 'Update' : 'Add'} a Product</h2>
            <div class="d-flex float-end gap-2">
              <button class="btn btn-success" type="submit">Confirm</button>
              <button class="btn btn-secondary" type="reset">Discard</button>
            </div>
          </div>
          <div class="col-lg-7 mb-lg-0">
            <div class="card">
              <div class="card-body container">
                <input name="id" value="${product.id}" hidden>
                <label class="form-label" for="title">Product Title</label>
                <input type="text" class="form-control mb-3" name="title" id="title" value="${product.name}" placeholder="Write title here..." required="" />

                <div class="row mb-3">
                  <div class="col-sm-6">
                    <label class="form-label" for="original-price">Original Price</label>
                    <div class="input-group">
                      <span class="input-group-text">$</span>
                      <input type="number" class="form-control" name="original-price" id="original-price" value="${product.unitPrice}" placeholder="0.00" required="" />
                    </div>
                  </div>

                  <div class="col-sm-6">
                    <label class="form-label" for="selling-price">Selling Price</label>
                    <div class="input-group">
                      <span class="input-group-text">$</span>
                      <input type="number" class="form-control" name="selling-price" id="selling-price" value="${product.salePrice}" placeholder="0.00" required="" />
                    </div>
                  </div>
                </div>

                <label for="quantity" class="form-label">Quantity</label>
                <input type="number" class="form-control mb-3" name="quantity" id="quantity" value="${product.quantity}" placeholder="000" required="" />

                <label for="category" class="form-label">Category</label>
                <select class="form-select mb-3" id="category" name="category" data-placeholder="Choose categories..." multiple>
                  <c:forEach items="${categoryList}" var="c">
                    <option value="${c.id}" ${productCategory.get(c.id) == true ? 'selected' : ''}>${c.name}</option>
                  </c:forEach>
                </select>
                <label class="form-label mt-3" for="description">Description</label>
                <textarea name="description" class="summernote" id="description" required="">${product.description}</textarea>
              </div>
            </div>
          </div>
          <div class="col-lg-5">
            <!--            <div class="card">
                          <div class="card-header">
                            <label for="image" class="input-group">
                              <span class="input-group-text"> Product Image </span>
                              <input type="file" class="form-control" accept="image/png, image/jpeg" name="image" id="image" onchange="previewImage(this)" />
                            </label>
                          </div>
                          <div class="card-body p-0">
                            <label class="w-100" style="cursor: pointer" for="image">
                              <img class="card-img object-fit-cover rounded-top-0" id="image-preview" src="${product ne null ? product.image : 'asset/img/placeholder.jpg'}" alt="preview" />
                              <div class="svg-image rounded-bottom-3" id="placeholder" style="font-size: 10em">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
                                <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0"></path>
                                <path
                                  d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1z"
                                  ></path>
                                </svg>
                              </div>
                              <img class="card-img object-fit-cover rounded-top-0" id="image-preview" src="${product ne null ? product.image : 'asset/img/placeholder.jpg'}" style="display: none" alt="preview" />
                            </label>
                            <input name="image-path" value="${product.image}" hidden="">
                            <input type="file" accept="image/*" name="image" id="image" onchange="previewImage(this)" hidden ${product ne null ? '' : 'required'}/>
                          </div>
                        </div>-->
            <div class="card">
              <div class="card-header">
                <label for="image" class="input-group">
                  <span class="input-group-text"> Product Image </span>
                  <input type="file" class="form-control" accept="image/png, image/jpeg" name="image" id="image" onchange="previewImage(this)" ${product ne null ? '' : 'required'} />
                </label>
              </div>
              <div class="card-body p-0">
                <label class="w-100" style="cursor: pointer" for="image">
                  <c:choose>
                    <c:when test="${product ne null}">
                      <input name="image-path" value="${product.image}" hidden="">
                      <img class="card-img object-fit-cover rounded-top-0" id="placeholder" src="${product.image}" alt="preview" />
                    </c:when>
                    <c:otherwise>
                      <div class="svg-image rounded-bottom-3" id="placeholder" style="font-size: 10em">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
                        <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0"></path>
                        <path
                          d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1z"
                          ></path>
                        </svg>
                      </div>
                    </c:otherwise>
                  </c:choose>
                  <img class="card-img object-fit-cover rounded-top-0" id="image-preview" src="#" style="display: none" alt="preview" />
                </label>
              </div>
            </div>
          </div>
        </div>
      </form>
    </main>

    <jsp:include page="part/footer.jsp" />

    <script src="js/bootstrap.bundle.min.js">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.full.min.js">
    </script>
    <script>
      const productDescription = $('#description').val();
      const $imagePreview = $("#image-preview");
      const $placeholder = $("#placeholder");

      function previewImage(input) {
        if (input.files && input.files[0]) {
          let reader = new FileReader();
          reader.onload = function (e) {
            $("#image-preview").attr("src", e.target.result).show();
            $("#placeholder").hide();
          };
          reader.readAsDataURL(input.files[0]);
        }
      }

      $("#image").on("change", function () {
        if (!this.files.length) {
          $("#image-preview").hide();
          $("#placeholder").show();
        }
      });

      $("#product-form").on("reset", () => {
        $("#image-preview").attr("src", null);
        $("#image-preview").hide();
        $("#placeholder").show();
      });

      $(() => {
        $("#category").select2({
          theme: "bootstrap-5",
          width: $(this).data("width") || $(this).hasClass("w-100") ? "100%" : "style",
          placeholder: $(this).data("placeholder") || "Select options...",
          closeOnSelect: false,
          allowClear: true,
        });

        $(".summernote").summernote({
          placeholder: "Write a description here...",
          tabsize: 2,
          height: null,
          minHeight: 200,
        });
      })
    </script>
  </body>
</html>
