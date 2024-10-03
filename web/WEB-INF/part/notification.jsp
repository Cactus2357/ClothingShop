<%-- 
    Document   : notification
    Created on : Oct 1, 2024, 5:21:20 PM
    Author     : hi
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="toast-container position-fixed top-0 start-50 translate-middle-x p-3">
  <div id="notification" class="toast bg-${requestScope.response_type ? 'success' : 'danger'} text-bg-${requestScope.response_type ? 'success' : 'danger'}" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="7000">
    <div class="d-flex">
      <div class="toast-body">
        ${requestScope.response}
      </div>
      <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast"></button>
    </div>
  </div>
</div>
<script>
  $(() => {
    const notifi = $('#notification')
    const notification = bootstrap.Toast.getOrCreateInstance($('#notification'));
  <c:if test="${requestScope.response ne null}">
    notification.show();
  </c:if>
  })
</script>