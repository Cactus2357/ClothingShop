<%-- Document : index Created on : Sep 13, 2024, 1:52:36 AM Author : hi --%> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>CSO</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />

    <style>
      .bd-placeholder-img {
        font-size: 2.5rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/asset/style/index.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
  </head>
  <body>
    <header>
      <jsp:include page="part/navbar.jsp" />
    </header>

    <main>
      <div id="myCarousel" class="carousel slide mb-6" data-bs-ride="carousel">
        <div class="carousel-indicators">
          <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
          <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
          <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
          <div class="carousel-item active">
            <!-- <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
            <rect width="100%" height="100%" fill="var(--bs-secondary-color)" />
            </svg> -->
            <img src="${pageContext.request.contextPath}/asset/img/autumn-slider.webp" class="object-fit-cover" width="100%" height="100%" alt="" />
            <div class="container">
              <div class="carousel-caption bg-dark text-light bg-opacity-25 px-2 text-start">
                <h1>Example headline.</h1>
                <p class="opacity-75">Some representative placeholder content for the first slide of the carousel.</p>
                <p><a class="btn btn-lg btn-primary" href="signup">Sign up today</a></p>
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <!-- <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
              <rect width="100%" height="100%" fill="var(--bs-secondary-color)" />
            </svg> -->
            <img src="${pageContext.request.contextPath}/asset/img/discount-slider.webp" class="object-fit-cover" width="100%" height="100%" alt="" />
            <div class="container">
              <div class="carousel-caption bg-dark text-light bg-opacity-25 px-2">
                <h1>Another example headline.</h1>
                <p>Some representative placeholder content for the second slide of the carousel.</p>
                <p><a class="btn btn-lg btn-primary" href="#">Learn more</a></p>
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <!-- <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
              <rect width="100%" height="100%" fill="var(--bs-secondary-color)" />
            </svg> -->
            <img src="${pageContext.request.contextPath}/asset/img/trendy-slider.png" class="object-fit-cover" width="100%" height="100%" alt="" />
            <div class="container">
              <div class="carousel-caption bg-dark text-light bg-opacity-25 px-2 text-end">
                <h1>One more for good measure.</h1>
                <p>Some representative placeholder content for the third slide of this carousel.</p>
                <p><a class="btn btn-lg btn-primary" href="product-list">Browse gallery</a></p>
              </div>
            </div>
          </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="visually-hidden">Next</span>
        </button>
      </div>

      <!-- Marketing messaging and featurettes
  ================================================== -->
      <!-- Wrap the rest of the page in another container to center all the content. -->

      <div class="container marketing">
        <!-- Three columns of text below the carousel -->
        <div class="row">
          <div class="col-lg-4">
            <img src="asset/img/avatar1.jfif" class="object-fit-cover rounded-circle" width="140" height="140" alt="" />
            <h2 class="fw-normal">Heading</h2>
            <p>Some representative placeholder content for the three columns of text below the carousel. This is the first column.</p>
            <p><a class="btn btn-secondary" href="#">View details &raquo;</a></p>
          </div>
          <!-- /.col-lg-4 -->
          <div class="col-lg-4">
            <img src="asset/img/avatar2.jpg" class="object-fit-cover rounded-circle" width="140" height="140" alt="" />
            <h2 class="fw-normal">Heading</h2>
            <p>Another exciting bit of representative placeholder content. This time, we've moved on to the second column.</p>
            <p><a class="btn btn-secondary" href="#">View details &raquo;</a></p>
          </div>
          <!-- /.col-lg-4 -->
          <div class="col-lg-4">
            <img src="asset/img/avatar3.webp" class="object-fit-cover rounded-circle" width="140" height="140" alt="" />
            <h2 class="fw-normal">Heading</h2>
            <p>And lastly this, the third column of representative placeholder content.</p>
            <p><a class="btn btn-secondary" href="#">View details &raquo;</a></p>
          </div>
          <!-- /.col-lg-4 -->
        </div>
        <!-- /.row -->

        <!-- START THE FEATURETTES -->

        <hr class="featurette-divider" />

        <div class="row featurette">
          <div class="col-md-7">
            <h2 class="featurette-heading fw-normal lh-1">First featurette heading. <span class="text-body-secondary">It’ll blow your mind.</span></h2>
            <p class="lead">Some great placeholder content for the first featurette here. Imagine some exciting prose here.</p>
          </div>
          <div class="col-md-5">
            <!--            <svg
                          class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
                          width="500"
                          height="500"
                          xmlns="http://www.w3.org/2000/svg"
                          role="img"
                          aria-label="Placeholder: 500x500"
                          preserveAspectRatio="xMidYMid slice"
                          focusable="false"
                          >
                        <title>Placeholder</title>
                        <rect width="100%" height="100%" fill="var(--bs-secondary-bg)" />
                        <text x="50%" y="50%" fill="var(--bs-secondary-color)" dy=".3em">500x500</text>
                        </svg>-->
            <img src="asset/img/Graphic Tee.jpg" class="object-fit-cover rounded-circle" width="500" height="500" alt="" />
          </div>
        </div>

        <hr class="featurette-divider" />

        <div class="row featurette">
          <div class="col-md-7 order-md-2">
            <h2 class="featurette-heading fw-normal lh-1">Oh yeah, it’s that good. <span class="text-body-secondary">See for yourself.</span></h2>
            <p class="lead">Another featurette? Of course. More placeholder content here to give you an idea of how this layout would work with some actual real-world content in place.</p>
          </div>
          <div class="col-md-5 order-md-1">
            <!--            <svg
                          class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
                          width="500"
                          height="500"
                          xmlns="http://www.w3.org/2000/svg"
                          role="img"
                          aria-label="Placeholder: 500x500"
                          preserveAspectRatio="xMidYMid slice"
                          focusable="false"
                          >
                        <title>Placeholder</title>
                        <rect width="100%" height="100%" fill="var(--bs-secondary-bg)" />
                        <text x="50%" y="50%" fill="var(--bs-secondary-color)" dy=".3em">500x500</text>
                        </svg>-->
            <img src="asset/img/Denim Jacket.jpg" class="object-fit-cover rounded-circle" width="500" height="500" alt="" />
          </div>
        </div>

        <hr class="featurette-divider" />

        <div class="row featurette">
          <div class="col-md-7">
            <h2 class="featurette-heading fw-normal lh-1">And lastly, this one. <span class="text-body-secondary">Checkmate.</span></h2>
            <p class="lead">
              And yes, this is the last block of representative placeholder content. Again, not really intended to be actually read, simply here to give you a better view of what this would look like with some actual content. Your content.
            </p>
          </div>
          <div class="col-md-5">
            <!--            <svg
                          class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto"
                          width="500"
                          height="500"
                          xmlns="http://www.w3.org/2000/svg"
                          role="img"
                          aria-label="Placeholder: 500x500"
                          preserveAspectRatio="xMidYMid slice"
                          focusable="false"
                          >
                        <title>Placeholder</title>
                        <rect width="100%" height="100%" fill="var(--bs-secondary-bg)" />
                        <text x="50%" y="50%" fill="var(--bs-secondary-color)" dy=".3em">500x500</text>
                        </svg>-->
            <img src="asset/img/Navy Blue Blazer.jpg" class="object-fit-cover rounded-circle" width="500" height="500" alt="" />
          </div>
        </div>

        <hr class="featurette-divider" />

        <!-- /END THE FEATURETTES -->
      </div>
      <!-- /.container -->

      <!-- FOOTER -->
      <footer class="container">
        <p class="float-end"><a href="#">Back to top</a></p>
        <p>&copy; 2017–2024 Company, Inc. &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a></p>
      </footer>
      <%--<jsp:include page="part/footer.jsp" />--%>
    </main>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
