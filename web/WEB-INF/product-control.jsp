<%-- Document : product-control Created on : Oct 1, 2024, 6:24:15 AM Author : hi --%> <%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </style>
  </head>
  <body>
    <jsp:include page="part/navbar.jsp" />
    <jsp:include page="part/notification.jsp" />

    <main class="container-fluid p-3">
      <form action="product" method="post" id="product-form" enctype="multipart/form-data">
        <div class="row">
          <div class="container mb-3">
            <h2 class="float-start">Add a Product</h2>
            <div class="d-flex float-end gap-2">
              <button class="btn btn-success" type="submit">Confirm</button>
              <button class="btn btn-secondary" type="reset">Discard</button>
            </div>
          </div>
          <div class="col-lg-7 mb-lg-0 mb-3">
            <div class="card">
              <div class="card-body container">
                <label class="form-label" for="title">Product Title</label>
                <input type="text" class="form-control mb-3" name="title" id="title" placeholder="Write title here..." required="" />

                <div class="row mb-3">
                  <div class="col-sm-6">
                    <label class="form-label" for="original-price">Original Price</label>
                    <div class="input-group">
                      <span class="input-group-text">$</span>
                      <input type="number" class="form-control" name="original-price" id="original-price" required="" />
                    </div>
                  </div>

                  <div class="col-sm-6">
                    <label class="form-label" for="selling-price">Selling Price</label>
                    <div class="input-group">
                      <span class="input-group-text">$</span>
                      <input type="number" class="form-control" name="selling-price" id="selling-price" required="" />
                    </div>
                  </div>
                </div>

                <label for="quantity" class="form-label">Quantity</label>
                <input type="number" class="form-control mb-3" name="quantity" id="quantity" aria-describedby="helpId" required="" />

                <label class="form-label" for="description">Description</label>
                <textarea name="description" class="form-control" id="description" rows="5" placeholder="Write a description here..." required=""></textarea>
              </div>
            </div>
          </div>
          <div class="col-lg-5 mb-3">
            <div class="card">
              <div class="card-header">
                <label for="image"> Product Image </label>
              </div>
              <div class="card-body p-0">
                <label class="w-100 has-validation" for="image">
                  <img class="card-img rounded-top-0" id="image-preview" src="asset/img/placeholder.jpg" alt="preview" />
                </label>
                <input type="file" accept="image/*" name="image" id="image" onchange="previewImage(this)" hidden required="" />
              </div>
            </div>
          </div>
        </div>
      </form>
    </main>

    <jsp:include page="part/footer.jsp" />

    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/jquery@3/dist/jquery.min.js" crossorigin="anonymous"></script>
    <script>
      const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
      const tooltipList = [...tooltipTriggerList].map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl));

      const $imagePreview = $("#image-preview");
      const imageSrc = $imagePreview.attr("src");

      function previewImage(input) {
        if (input.files && input.files[0]) {
          let reader = new FileReader();
          reader.onload = (e) => $imagePreview.attr("src", e.target.result);
          reader.readAsDataURL(input.files[0]);
        }
      }

      $("#product-form").on("reset", () => {
        $imagePreview.attr("src", imageSrc);
      });
    </script>
  </body>
</html>
