<%-- 
    Document   : navbar
    Created on : Oct 1, 2024, 5:08:24 PM
    Author     : hi
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${sessionScope.user ne null and sessionScope.user.role ne 'customer'}">
  <div class="offcanvas offcanvas-start" data-bs-scroll="true" tabindex="-1" id="sidebar">
    <div class="offcanvas-header">
      <h5 class="offcanvas-title" id="sidebar-label">Backdrop with scrolling</h5>
      <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
      <p>Try scrolling the rest of the page to see this option in action.</p>
      <hr />
      <ul class="list-group" id="offcanvas-links">
        <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/home">Home</a>
        <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/product-list">Products</a>
        <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/product">Add Product</a>
        <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/category">Add Category</a>
        <a class="list-group-item list-group-item-action" href="${pageContext.request.contextPath}/users">User</a>
      </ul>
    </div>
  </div>
</c:if>

<link rel="stylesheet" href="${pageContext.request.contextPath}/asset/style/theme-button.css"/>

<svg xmlns="http://www.w3.org/2000/svg" class="d-none">
  <symbol id="check2" viewBox="0 0 16 16">
    <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z" />
  </symbol>
  <symbol id="circle-half" viewBox="0 0 16 16">
    <path d="M8 15A7 7 0 1 0 8 1v14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z" />
  </symbol>
  <symbol id="moon-stars-fill" viewBox="0 0 16 16">
    <path
      d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z"
      />
    <path
      d="M10.794 3.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387a1.734 1.734 0 0 0-1.097 1.097l-.387 1.162a.217.217 0 0 1-.412 0l-.387-1.162A1.734 1.734 0 0 0 9.31 6.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387a1.734 1.734 0 0 0 1.097-1.097l.387-1.162zM13.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732l-.774-.258a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L13.863.1z"
      />
  </symbol>
  <symbol id="sun-fill" viewBox="0 0 16 16">
    <path
      d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"
      />
  </symbol>
</svg>

<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark border-bottom">
  <div class="container-fluid">
    <a href="${pageContext.request.contextPath}" class="navbar-brand text-primary">CSO</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0" id="navbar-links">
        <li class="nav-item">
          <a class="nav-link" href="home">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="product-list">Products</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${sessionScope.user ne null ? '' : 'disabled'}" href="cart" tabindex="-1">Cart</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="https://github.com/Cactus2357/ClothingShop" target="_blank">About</a>
        </li>
        <c:if test="${sessionScope.user ne null and sessionScope.user.role ne 'customer'}">
          <li>
            <button class="nav-link text-primary" data-bs-toggle="offcanvas" data-bs-target="#sidebar" accesskey="d">Dashboard</button>
          </li>
        </c:if>
      </ul>
      <div class="dropdown me-2 bd-mode-toggle" >
        <button class="btn btn-bd-primary dropdown-toggle d-flex align-items-center" id="bd-theme" type="button" data-bs-toggle="dropdown" data-bs-auto-close="outside">
          <svg class="bi my-1 theme-icon-active" width="1em" height="1em"><use href="#circle-half"></use></svg>
          <span class="visually-hidden" id="bd-theme-text">Toggle theme</span>
        </button>
        <ul class="dropdown-menu dropdown-menu-end shadow">
          <li>
            <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="light">
              <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#sun-fill"></use></svg>
              Light
              <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
            </button>
          </li>
          <li>
            <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="dark">
              <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#moon-stars-fill"></use></svg>
              Dark
              <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
            </button>
          </li>
          <li>
            <button type="button" class="dropdown-item d-flex align-items-center active" data-bs-theme-value="auto">
              <svg class="bi me-2 opacity-50" width="1em" height="1em"><use href="#circle-half"></use></svg>
              Auto
              <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
            </button>
          </li>
        </ul>
      </div>
      <form action="product-list" class="d-flex me-2" role="search">
        <div class="input-group">
          <input class="form-control" name="query" type="search" placeholder="Search..." />
          <button class="btn btn-outline-success" type="submit">Search</button>
        </div>
      </form>
      <c:choose>
        <c:when test="${sessionScope.user eq null}">
          <a href="${pageContext.request.contextPath}/signin" class="btn btn-outline-primary me-2">Sign in</a>
          <a href="${pageContext.request.contextPath}/signup" class="btn btn-primary">Sign up</a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary">Profile</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</nav>

<script>
  const currentPath = window.location.pathname;
  $('#navbar-links a, #offcanvas-links a').each(function () {
    if (this.pathname === currentPath) {
      $(this).addClass('active');
    }
  });
  $('#navbar-links a').each(function () {
    if (this.pathname === currentPath) {
      $(this).addClass('text-decoration-underline link-offset-2');
    }
  });
</script>

<script src="${pageContext.request.contextPath}/asset/script/color-modes.js"></script>