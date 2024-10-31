<%-- Document : signup Created on : Sep 12, 2024, 11:12:00 PM Author : hi --%> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <script src="asset/script/color-modes.js"></script>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Sign up</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />

    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

    <!-- Custom styles for this template -->
    <style>
      html,
      body {
        height: 100%;
      }
    </style>
  </head>

  <body class="d-flex align-items-center py-4 bg-body-tertiary">
    <jsp:include page="part/notification.jsp">
      <jsp:param name="response" value="${response}" />
      <jsp:param name="responseType" value="${responseType}" />
    </jsp:include>
    <main class="form-signin container w-100 m-auto d-flex justify-content-center z-2 p-3">
      <div class="col-10 col-lg-8 col-xxl-6">
        <a href="home" class="text-decoration-none text-end"><h1>CSO</h1></a>
        <h1 class="h3 mb-3 fw-normal text-end">Register your account</h1>
        <form action="signup" method="post" autocomplete="off" class="needs-validation" novalidate>
          <input type="text" style="display:none">
          <input type="password" style="display:none" autocomplete="new-password" >
          <div class="form-floating mb-3 has-validation">
            <input type="text" class="form-control" id="username" name="name" value="${requestScope.name}" placeholder="Username" required />
            <label for="username">Username</label>
            <div class="invalid-feedback">Username not available</div>
          </div>

          <div class="form-floating mb-3 has-validation">
            <input type="email" class="form-control" id="email" name="email" value="${requestScope.email}" placeholder="name@example.com" required autocomplete="off" />
            <label for="email">Email address</label>
            <div class="invalid-feedback">Email required</div>
          </div>

          <fieldset>
            <div class="row">
              <div class="col-xl-6">
                <div class="input-group mb-3">
                  <div class="form-floating has-validation">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required autocomplete="off" />
                    <label for="password">Password</label>
                  </div>
                  <button type="button" class="input-group-text" id="showPasswordBtn"><i class="bi bi-eye-slash"></i></button>
                </div>
              </div>

              <div class="col-xl-6">
                <div class="form-floating mb-3 has-validation">
                  <input type="password" class="form-control" id="password_cfm" name="passwordCfm" placeholder="Confirm password" required />
                  <label for="password_cfm">Confirm password</label>
                  <div class="invalid-feedback">Password not match</div>
                </div>
              </div>
            </div>
          </fieldset>

          <div class="row mb-3">
            <div class="col-6">
              <div class="form-floating">
                <input type="text" class="form-control" id="familyName" name="familyName" value="${requestScope.familyName}" placeholder="Family Name" required />
                <label for="familyName">Family Name</label>
              </div>
            </div>

            <div class="col-6">
              <div class="form-floating">
                <input type="text" class="form-control" id="givenName" name="givenName" value="${requestScope.givenName}" placeholder="Given Name" required />
                <label for="givenName">Given Name</label>
              </div>
            </div>
          </div>

          <div class="mb-3 d-flex align-items-center gap-3">
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="gender" id="gender-male" value="male" required ${requestScope.gender eq 'male' ? 'checked' : ''} />
              <label class="form-check-label" for="gender-male">Male</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="gender" id="gender-female" value="female" required ${requestScope.gender eq 'female' ? 'checked' : ''} />
              <label class="form-check-label" for="gender-female">Female</label>
            </div>
          </div>

          <div class="row">
            <div class="col-md-4">
              <div class="form-floating mb-3">
                <input type="tel" class="form-control" id="phone" name="phone" value="${requestScope.phone}" placeholder="888-88-888" />
                <label for="phone">Phone number</label>
              </div>
            </div>

            <div class="col-md-8">
              <div class="form-floating mb-3">
                <input type="text" class="form-control" id="address" name="address" value="${requestScope.address}" placeholder="Address" />
                <label for="address">Address</label>
              </div>
            </div>
          </div>
          <div class="form-check-reverse mb-3 user-select-none">
            <input class="form-check-input" type="checkbox" value="subscribe" id="subscribe" />
            <label class="form-check-label" for="subscribe">Subscribe to our newsletter</label>
          </div>

          <button class="btn btn-success w-100 py-2 mb-3" type="submit">Sign up</button>
        </form>

        <div class="text-center">
          <p>or sign up with</p>
          <button class="btn btn-danger w-100 py-2 mb-3" type="submit"><i class="bi bi-google me-2"></i>Google</button>
        </div>
        <hr />
        <div class="text-center">
          <p>Already have an account?<a href="signin" class="text-decoration-none"> Sign in </a></p>
        </div>
        <p class="mt-5 mb-3 text-body-secondary">&copy; 2024–2024</p>
      </div>
    </main>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

    <script>
      $(() => {
        $("input").on("input", function () {
          $(this).removeClass("is-valid is-invalid");
        });

        $("#showPasswordBtn").on("click", function () {
          const $input = $("#password");
          const $inputCfm = $("#password_cfm");
          const $icon = $(this).find("i");

          if ($input.attr("type") === "password") {
            $input.attr("type", "text");
            $inputCfm.attr("type", "text");
            $icon.removeClass("bi-eye-slash").addClass("bi-eye");
          } else {
            $input.attr("type", "password");
            $inputCfm.attr("type", "password");
            $icon.removeClass("bi-eye").addClass("bi-eye-slash");
          }
        });

        (() => {
          "use strict";
          const forms = document.querySelectorAll(".needs-validation");

          Array.from(forms).forEach((form) => {
            form.addEventListener(
                    "submit",
                    (event) => {
              if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
              }

              form.classList.add("was-validated");
            },
                    false
                    );
          });
        })();
      });
    </script>
  </body>
</html>
