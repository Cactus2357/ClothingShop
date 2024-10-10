<%-- 
    Document   : signin
    Created on : Sep 11, 2024, 11:42:43 PM
    Author     : hi
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <script src="asset/script/color-modes.js"></script>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>


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

    <jsp:include page="part/notification.jsp">
      <jsp:param name="response" value="${response}" />
      <jsp:param name="responseType" value="${responseType}" />
    </jsp:include>

    <c:url var="url" value="signin">
      <c:if test="${redirect ne null}"><c:param name="redirect" value="${redirect}" /></c:if>
    </c:url>
    <%--<c:param name="redirect" value="${fn:escapeXml(redirect)}" />--%>


    <main class="form-signin container w-100 m-auto d-flex justify-content-center z-2 p-3">
      <div class="col-12 col-lg-8 col-xxl-7">
        <form action="${url}" method="post" class="has-validation needs-validation" novalidate>
          <a href="home" class="text-decoration-none"><h1> CSO </h1></a>
          <h1 class="h3 mb-3 fw-normal">Sign in</h1>

          <div class="form-floating">
            <input type="text" class="form-control mb-3 has-validation" id="username" name="sudoLogin" placeholder="Username" value="${requestScope.sudoLogin}" required />
            <label for="username">Username or Email</label>
          </div>
          <div class="form-floating">
            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required />
            <label for="password">Password</label>
          </div>

          <div class="form-check my-3">
            <input class="form-check-input" type="checkbox" value="remember-me" id="remember" />
            <label class="form-check-label" for="remember">Remember me</label>
            <a class="float-end text-decoration-none" href="#">Forgot password?</a>
          </div>
          <!--<p class="mb-3 text-danger">Server response</p>-->
          <%--<p class="float-start mb-3">
            <span class="text-danger"> ${requestScope.response} </span>
            <span class="text-success"> ${requestScope.response_ok} </span>
          </p>--%>
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
        (() => {
          "use strict";
          const forms = document.querySelectorAll(".needs-validation");

          Array.from(forms).forEach((form) => {
            form.addEventListener("submit", (event) => {
              if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
              }

              form.classList.add("was-validated");
            }, false);
          });
        })();
      });
    </script>
  </body>
</html>
