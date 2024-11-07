<%-- 
    Document   : verify-otp-form
    Created on : Oct 30, 2024, 3:00:15 AM
    Author     : hi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <script src="${pageContext.request.contextPath}/asset/script/color-modes.js"></script>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Verify OTP</title>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
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
        <p>An email has been sent to <b>${requestScope.email}</b>. <small class="text-muted text-nowrap">( Your OTP will expire after ${requestScope.otpExpiry} minutes )</small></p>
        <p class="text-warning">You have ${remainAttempts} attempts</p>
        <form action="${formDestination ne null ? formDestination : 'reset-password'}" method="post" class="has-validation">
          <div class="input-group">
            <div class="form-floating">
              <input type="password" class="form-control" name="otp" id="otp" placeholder="OTP" required />
              <label for="email">Your OTP Number</label>
            </div>
            <button class="btn btn-success px-3" type="submit">Verify</button>
            <button class="btn btn-outline-secondary" type="button">Resend</button>
          </div>
        </form>
        <p class="mt-5 mb-3 text-body-secondary">&copy; 2024-2024</p>
      </div>
    </main>

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
