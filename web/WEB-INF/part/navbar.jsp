<%-- 
    Document   : navbar
    Created on : Oct 1, 2024, 5:08:24 PM
    Author     : hi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="offcanvas offcanvas-start" data-bs-scroll="true" tabindex="-1" id="sidebar">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="sidebar-label">Backdrop with scrolling</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
  </div>
  <div class="offcanvas-body">
    <p>Try scrolling the rest of the page to see this option in action.</p>
    <hr />
    <ul class="list-group">
      <a class="list-group-item" href="product-list">Products</a>
      <a class="list-group-item" href="product">Add Product</a>
    </ul>
  </div>
</div>

<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark border-bottom">
  <div class="container-fluid">
    <a class="navbar-brand" href="#" data-bs-toggle="offcanvas" data-bs-target="#sidebar">Side bar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
          <a class="nav-link active" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled">Disabled</a>
        </li>
      </ul>
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" />
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>