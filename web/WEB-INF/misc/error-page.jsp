<%-- 
    Document   : error-page
    Created on : Oct 15, 2024, 3:50:57 AM
    Author     : hi
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="statusCode" value="${requestScope['jakarta.servlet.error.status_code']}" />
<c:set var="statusMesg" value="${requestScope['jakarta.servlet.error.message']}"/>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <title>Error ${statusCode}</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
    <script src="${pageContext.request.contextPath}/asset/script/color-modes.js"></script>
    <style>
      html,
      body {
        height: 100%;
      }
    </style>
  </head>

  <body>
    <div class="container-xxl h-100 d-flex align-items-center justify-content-center">
      <div class="text-center">
        <c:choose>
          <c:when test="${statusCode eq 404}">
            <p>${statusMesg ne null ? statusMesg : 'Page not found'}</p>
            <h2 class="mb-2 mx-2">Page Not Found :(</h2>
            <p class="mb-4 mx-2">${statusMesg ne null ? statusMesg : 'Oops! 😖 The requested URL was not found on this server.'}</p>
            <a href="${pageContext.request.contextPath}" class="btn btn-primary">Back to home</a>
            <div class="mt-3">
              <img src="${pageContext.request.contextPath}/asset/illustrations/page-misc-error-light.png" alt="" width="700" class="img-fluid" />
            </div>
          </c:when>
          <c:when test="${statusCode eq 500}">
            <h2 class="mb-2 mx-2">Under Maintenance!</h2>
            <p class="mb-4 mx-2">${statusMesg ne null ? statusMesg : 'Sorry for the inconvenience but we\'re performing some maintenance at the moment'}</p>
            <a href="${pageContext.request.contextPath}" class="btn btn-primary">Back to home</a>
            <div class="mt-4">
              <img src="${pageContext.request.contextPath}/asset/illustrations/girl-doing-yoga-light.png" alt="" width="700" class="img-fluid" />
            </div>
          </c:when>
          <c:otherwise>
            <h2 class="mb-2 mx-2">Something went wrong</h2>
            <p class="mb-4 mx-2">${statusMesg ne null ? statusMesg : 'Something went wrong, but don\'t fret -- it\'s not your fault. Let\'s try again.'}</p>
            <a href="${pageContext.request.contextPath}" class="btn btn-primary">Back to home</a>
            <div class="mt-4">
              <img src="${pageContext.request.contextPath}/asset/illustrations/man-with-laptop-light.png" alt="" width="400" class="img-fluid" />
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

  </body>
</html>
