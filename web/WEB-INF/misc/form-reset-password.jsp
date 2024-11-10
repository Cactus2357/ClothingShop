<%-- 
    Document   : form-reset-password
    Created on : Oct 31, 2024, 12:15:07 AM
    Author     : hi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <script src="${pageContext.request.contextPath}/asset/script/color-modes.js"></script>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Reset Password</title>
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
    <jsp:include page="../part/notification.jsp">
      <jsp:param name="response" value="${response}" />
      <jsp:param name="responseType" value="${responseType}" />
    </jsp:include>
    <main class="container w-100 m-auto d-flex justify-content-center z-2 p-3">
      <div class="col-10 col-lg-8 col-xxl-6">
        <form action="change-password" method="post" class="has-validation">
          <input type="text"  style="display: none">
          <input type="password" style="display: none" autocomplete="new-password" />
          <h1><a href="${pageContext.request.contextPath}" class="text-decoration-none">CSO</a></h1>
          <h3>Reset Password</h3>
          <p class="d-flex align-items-center">
            Enter a new password for
            <input type="email" name="email" id="email" name="email" class="form-control-plaintext ms-1 w-auto fw-bold" readonly value="${sessionScope.authEmail}" />
          </p>
          <p>Password must be at least 8 characters length. Current session will last for 3 minutes</p>
          <small>We suggest using strong password include <b>numbers</b>, <b>letters</b>, and <b>punctuation marks</b>.</small>
          <fieldset>
            <div class="form-floating">
              <input type="password" class="form-control form-control-lg" name="newPassword" id="pasword" placeholder="Password" required />
              <label for="pasword">New Password</label>
            </div>
            <div class="form-floating">
              <input type="password" class="form-control form-control-lg mt-3" name="newPassword2" id="confirm-password" placeholder="OTP" required />
              <label for="confirm-password">Confirm Password</label>
            </div>
          </fieldset>
          <button class="btn btn-success w-100 mt-3">Reset Password</button>
        </form>
        <p class="mt-5 mb-3 text-body-secondary">&copy; 2024–2024</p>
      </div>
    </main>

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
