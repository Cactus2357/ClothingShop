<%-- 
    Document   : send-email-form
    Created on : Oct 30, 2024, 2:55:37 AM
    Author     : hi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <script src="asset/script/color-modes.js"></script>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title></title>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <style>
      html,
      body {
        height: 100%;
      }
    </style>
  </head>

  <body class="d-flex align-items-center py-4 bg-body-tertiary">
    <main class="form-signin container w-100 m-auto d-flex justify-content-center z-2 p-3">
      <div class="col-10 col-lg-8 col-xxl-6">
        <h1><a href="${pageContext.request.contextPath}" class="text-decoration-none">CSO</a></h1>
        <h1 class="h3 mb-3 fw-normal">Please enter your email address</h1>
        <form action="reset-password" method="post" class="has-validation">
          <div class="form-floating">
            <input type="email" class="form-control form-control-lg mb-3" name="email" id="email" placeholder="Email" />
            <label for="email">Email</label>
          </div>
          <button class="btn btn-success w-100 py-2 mb-3" id="send-otp-btn" type="submit">Send OPT</button>
        </form>
        <p class="mt-5 mb-3 text-body-secondary">&copy; 2024-2024</p>
      </div>
    </main>
    <script src="js/bootstrap.bundle.min.js"></script>
  </body>
</html>
