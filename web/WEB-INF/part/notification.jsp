<%-- 
    Document   : notification
    Created on : Oct 1, 2024, 5:21:20 PM
    Author     : hi
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="type" value="${param.responseType ? 'success' : 'danger'}" scope="page" />
<c:set var="state" value="${(param.response ne null and not empty param.response) ? 'show' : ''}" scope="page" />
<div class="toast-container position-fixed top-0 start-50 translate-middle-x p-3">
  <div id="notification" class="toast ${state} bg-${type} text-bg-${type}" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="7000">
    <div class="d-flex">
      <div class="toast-body">${param.response}</div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
    </div>
  </div>
</div>

