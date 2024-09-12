<%-- 
    Document   : signin
    Created on : Sep 11, 2024, 11:42:43 PM
    Author     : hi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <script src="asset/script/color-modes.js"></script>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Signin Template · Bootstrap v5.3</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/sign-in/" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />

    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" />


    <script src="https://unpkg.com/jquery@3/dist/jquery.min.js" crossorigin="anonymous"></script>

    <style>
      html,
      body {
        height: 100%;
      }
    </style>
  </head>

  <body class="d-flex align-items-center py-4 bg-body-tertiary">
    <main class="form-signin container w-100 m-auto d-flex justify-content-center z-2 p-3">
      <div class="col-12 col-lg-8 col-xxl-7">
        <form class="has-validation">
          <a href="#" class="text-decoration-none"><h1>CSO</h1></a>
          <h1 class="h3 mb-3 fw-normal">Sign in</h1>

          <div class="form-floating">
            <input type="text" class="form-control mb-3 has-validation" id="username" placeholder="Username" value="Admin" />
            <label for="username">Username or Email</label>
          </div>
          <div class="input-group mb-3">
            <div class="form-floating">
              <input type="password" class="form-control" id="password" placeholder="Password" value="12345" />
              <label for="password">Password</label>
            </div>
            <button type="button" class="input-group-text" id="showPasswordBtn"><i class="bi bi-eye-slash"></i></button>
          </div>

          <div class="form-check my-3">
            <input class="form-check-input" type="checkbox" value="remember-me" id="remember" />
            <label class="form-check-label" for="remember">Remember me</label>
            <a class="float-end text-decoration-none" href="#">Forgot password?</a>
          </div>
          <!-- <p class="mb-3 text-danger">Server response</p> -->
          <button class="btn btn-success w-100 py-2 mb-3" type="submit">Sign in</button>
          <p class="mb-3 text-center">or sign in with</p>
          <button class="btn btn-danger w-100 py-2 mb-3" type="submit"><i class="bi bi-google me-2"></i>Google</button>
        </form>
        <hr />
        <div class="text-center">
          <p>Don't have an account?<a href="signup" class="text-decoration-none"> Sign up </a></p>
        </div>
        <p class="mt-5 mb-3 text-body-secondary">&copy; 2024-2024</p>
      </div>
    </main>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.js"></script>
    <script>
      $(() => {
        $("#showPasswordBtn").on("click", function () {
          const $input = $("#password");
          const $icon = $(this).find("i");

          if ($input.attr("type") === "password") {
            $input.attr("type", "text");
            $icon.removeClass("bi-eye-slash").addClass("bi-eye");
          } else {
            $input.attr("type", "password");
            $icon.removeClass("bi-eye").addClass("bi-eye-slash");
          }
        });
      });
    </script>
  </body>
</html>