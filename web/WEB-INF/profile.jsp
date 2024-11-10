<%-- Document : profile Created on : Sep 19, 2024, 9:45:06 PM Author : hi --%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@page contentType="text/html"
                                                                                                                                                        pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Cropper.min.css -->
    <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.css" /> -->
    <title>Profile</title>
    <style>
      .note {
        min-height: 17px;
        margin: 4px 0 2px;
        font-size: 12px;
      }

      .img-container img {
        max-width: 100%;
      }

      /* .cropper-view-box,
      .cropper-face {
        border-radius: 50%;
      } */

      /* The css styles for `outline` do not follow `border-radius` on iOS/Safari (#979). */
      /* .cropper-view-box {
        outline: 0;
        box-shadow: 0 0 0 1px #39f;
      } */

      .bi {
        fill: currentColor;
      }

      body {
        min-height: 75rem;
        padding-top: 4.5rem;
      }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
  </head>

  <body>
    <jsp:include page="part/navbar.jsp" />
    <jsp:include page="part/notification.jsp">
      <jsp:param name="response" value="${response}" />
      <jsp:param name="responseType" value="${responseType}" />
    </jsp:include>
    <main>
      <div class="py-4 container-xl clearfix">
        <header class="d-md-flex align-items-center justify-content-between mt-1 mb-4">
          <div class="d-flex align-items-center mb-2 mb-md-0">
            <img
              src="${sessionScope.user.avatar ne null ? sessionScope.user.avatar  : 'asset/img/default_picture.png'}"
              alt="@${sessionScope.user.userName}"
              class="rounded-circle me-3"
              height="48"
              width="48"
              />
            <div class="flex-auto">
              <h1 class="h3 lh-1 mb-0">
                <a href="#" class="text-reset text-decoration-none">
                  ${sessionScope.user.familyName} ${sessionScope.user.givenName} <span class="text-muted">(@${sessionScope.user.userName})</span>
                </a>
              </h1>
              <div class="d-flex align-items-center flex-wrap color-brand-teal">
                <p class="text-muted mb-0 me-1">Your personal account</p>
              </div>
            </div>
          </div>
          <!--<a href="signout" class="btn btn-outline-danger btn-sm px-4"> Sign out </a>-->
          <button class="btn btn-outline-danger btn-sm px-4" data-bs-toggle="modal" data-bs-target="#signout-modal">Sign out</button>
          <div class="modal fade" id="signout-modal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content">
                <!-- <div class="modal-header bg-danger-subtle">
                    <span>
                      <i class="bi bi-exclamation-triangle text-danger me-2"></i>
                      This is extremely important.
                    </span>
                  </div> -->
                <div class="modal-header">
                  <h5 class="modal-title">Sign out</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body bg-danger-subtle text-danger pt-4">
                  <p>Are you sure you want to sign out?</p>
                </div>
                <div class="modal-footer">
                  <div class="d-flex gap-2 w-100">
                    <button type="button" class="btn btn-secondary col-6" data-bs-dismiss="modal">Cancel</button>
                    <a href="${pageContext.request.contextPath}/signout" type="button" class="btn btn-danger col-6">Sign out</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </header>
        <div class="d-md-grid">
          <nav>
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
              <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#nav-profile" role="tab" id="nav-profile-tab">
                <span class="order-0 fs-6">Public profile</span>
              </button>

              <button class="nav-link" data-bs-toggle="tab" data-bs-target="#nav-password" role="tab" id="nav-password-tab">
                <span class="order-0 fs-6">${sessionScope.user.password ne null ? 'Change Password' : 'Add Password'}</span>
              </button>

              <!--               <button class="nav-link " data-bs-toggle="tab" data-bs-target="#nav-delete-account" role="tab" id="nav-delete-account-tab">
                              <h2 class="fw-normal order-0 fs-6 text-danger">Delete Account</h2>
                            </button> -->
            </div>
          </nav>

          <div class="container-xl tab-content py-4">
            <div class="tab-pane fade show active" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="-1">
              <div class="clearfix d-flex flex-shrink-0 flex-column-reverse flex-md-row gap-md-3">
                <div class="col-12 col-md-8">
                  <form action="${pageContext.request.contextPath}/profile" method="post">
                    <div class="row">
                      <dl>
                        <dt><label for="username">Name</label></dt>
                        <dd>
                          <div class="input-group mb-1">
                            <label for="username" class="input-group-text"><i class="bi bi-at"></i></label>
                            <input class="form-control" name="username" id="username" placeholder="Username" value="${sessionScope.user.userName}" required />
                          </div>
                        </dd>
                      </dl>
                      <dl>
                        <dt><label for="email">Email</label></dt>
                        <dd>
                          <div class="input-group mb-1">
                            <label for="email" class="input-group-text"><i class="bi bi-envelope-at"></i></label>
                            <input class="form-control" type="email" name="email" id="email" value="${sessionScope.user.email}" readonly />
                          </div>
                        </dd>
                      </dl>

                      <!-- <div class="row mb-1"> -->
                      <dl class="col-6">
                        <dt><label for="familyName">Family Name</label></dt>
                        <dd>
                          <!-- <div class="input-group mb-1"> -->
                          <!-- <span for="familyName" class="input-group-text"><i class="bi bi-at"></i></span> -->
                          <input class="form-control" name="familyName" id="familyName" value="${sessionScope.user.familyName}" />
                          <!-- </div> -->
                        </dd>
                      </dl>
                      <dl class="col-6">
                        <dt><label for="givenName">Given Name</label></dt>
                        <dd>
                          <!-- <div class="input-group mb-1"> -->
                          <!-- <span for="user_name" class="input-group-text"><i class="bi bi-at"></i></span> -->
                          <input class="form-control" name="givenName" id="givenName" value="${sessionScope.user.givenName}" required />
                          <!-- </div> -->
                        </dd>
                      </dl>
                      <!-- </div> -->

                      <dl>
                        <dt><label>Gender</label></dt>
                        <dd>
                          <input type="radio" class="btn-check" value="male" name="gender" id="male" autocomplete="off" ${sessionScope.user.gender eq 'male' ? 'checked' : ''} />
                          <label class="btn btn-outline-secondary px-4" for="male">
                            <span> <i class="bi bi-gender-male me-2"></i> Male </span>
                          </label>

                          <input type="radio" class="btn-check" value="female" name="gender" id="female" autocomplete="off" ${sessionScope.user.gender eq 'female' ? 'checked' : ''} />
                          <label class="btn btn-outline-secondary px-4" for="female">
                            <span> <i class="bi bi-gender-female me-2"></i> Female </span>
                          </label>
                        </dd>
                      </dl>

                      <dl>
                        <dt><label for="phone">Phone</label></dt>
                        <dd>
                          <div class="input-group mb-1">
                            <label for="phone" class="input-group-text"><i class="bi bi-telephone"></i></label>
                            <input class="form-control" type="tel" name="phone" id="phone" placeholder="Contact" value="${sessionScope.user.phone}" />
                            <!-- <span class="invalid-feedback">Invalid phone number</span> -->
                          </div>
                        </dd>
                      </dl>
                      <dl>
                        <dt><label for="address">Address</label></dt>
                        <dd>
                          <div class="input-group mb-1">
                            <label for="address" class="input-group-text"><i class="bi bi-house"></i></label>
                            <input class="form-control" type="text" name="address" id="address" placeholder="Home address" value="${sessionScope.user.address}" />
                            <!-- <span class="invalid-feedback">Invalid address</span> -->
                          </div>
                        </dd>
                      </dl>
                      <p class="note mb-2">
                        Many of the fields on this page are optional and can be deleted at any time, and by filling them out, you're giving us consent to share this data wherever your user
                        profile appears. Please see our
                        <a class="text-decoration-none" href="#">privacy statement</a> to learn more about how we use this information.
                      </p>
                      <p>
                        <button
                          type="submit"
                          onsubmit="return alert('Are you sure you want to update your info?')"
                          class="btn btn-success d-inline-flex align-items-center flex-row justify-content-between position-relative text-center user-select-none"
                          >
                          <span class="d-grid flex-grow-1 flex-shrink-0 flex-auto align-content-center justify-content-center">
                            <span>Update profile</span>
                          </span>
                        </button>
                      </p>
                    </div>
                  </form>
                </div>

                <div class="col-12 col-md-4 px-md-2">
                  <div class="container float-lg-end">
                    <dl class="user-select-none">
                      <dt><label class="d-block mb-2">Profile picture</label></dt>
                      <dd class="clearfix position-relative">
                        <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
                          <input type="file" name="avatar_img" id="avatar_upload" accept="image/*" hidden />
                        </form>
                        <div class="container-fluid">
                          <a href="#">
                            <img
                              src="${sessionScope.user.avatar ne null ? sessionScope.user.avatar  : 'asset/img/default_picture.png'}"
                              id="avatar"
                              class="rounded-circle shadow"
                              width="200"
                              alt="Avatar"
                              />
                          </a>
                          <div class="dropdown position-absolute rounded-2 p-2 start-0 bottom-0 ms-2">
                            <button class="btn btn-sm btn-dark rounded-3" type="button" id="editAvatarButton" data-bs-toggle="dropdown" aria-expanded="false">
                              <i class="bi bi-pencil me-1"></i>
                              <span>Edit</span>
                            </button>
                            <ul class="dropdown-menu py-0" aria-labelledby="editAvatarButton">
                              <li><label for="avatar_upload" class="dropdown-item" style="cursor: pointer" tabindex="0">Upload a photo...</label></li>
                              <li>
                                <a class="dropdown-item" onclick="return alert('Are you sure you want to reset your profile picture?');"> Remove photo </a>
                              </li>
                            </ul>
                          </div>
                        </div>
                      </dd>
                    </dl>
                    <div class="container my-3">
                      <div class="progress mb-3" style="height: 5px; width: 200px; display: none">
                        <div class="progress-bar progress-bar-striped progress-bar-animated bg-success" role="progressbar"></div>
                      </div>
                      <div class="alert px-2 py-0 text-truncate" style="display: none" role="alert"></div>
                    </div>
                    <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="modalLabel">Crop the image</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body">
                            <div class="img-container">
                              <img id="image" src="asset/img/default_picture.png" alt="" />
                            </div>
                          </div>
                          <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-success" id="crop">Confirm</button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="tab-pane fade" id="nav-password" role="tabpanel" aria-labelledby="nav-password-tab" tabindex="-1">
              <div class="d-inline">
                <form action="change-password" method="post">
                  <input type="text" style="display:none" tabindex="-1">
                  <input type="password" style="display:none" autocomplete="new-password" tabindex="-1">
                  <input type="email" name="email" class="visually-hidden" value="${sessionScope.user.email}"tabindex="-1">
                  <c:if test="${sessionScope.user.password ne null}">
                    <dl>
                      <dt><label for="user_old_password">Old Password</label></dt>
                      <dd>
                        <input type="password" name="oldPassword" id="user_old_password" required="required" class="form-control form-control" />
                      </dd>
                    </dl>
                  </c:if>
                  <fieldset>
                    <dl>
                      <dt><label for="user_new_password">New Password</label></dt>
                      <dd>
                        <input type="password" name="newPassword" id="user_new_password" required="required" spellcheck="false" class="form-control" />
                      </dd>
                    </dl>
                    <dl>
                      <dt><label for="user_confirm_new_password">Confirm New Password</label></dt>
                      <dd>
                        <input type="password" name="newPassword2" id="user_confirm_new_password" required="required" class="form-control" />
                      </dd>
                    </dl>
                  </fieldset>
                  <p class="d-flex align-items-center">
                    <button type="submit" class="btn btn-success me-2">Update password</button>
                    <span><a class="text-decoration-none" href="reset-password">I forgot my password</a></span>
                  </p>
                </form>
              </div>
            </div>
            <!--  -->
            <!--            <div class="tab-pane fade" id="nav-delete-account" role="tabpanel" aria-labelledby="nav-delete-account-tab" tabindex="-1">
                          <div class="d-inline">
                            <p class="mb-2">Once you delete your account, there is no going back. Please be certain.</p>
                            <button type="submit" class="btn-outline-danger btn me-2" data-bs-toggle="modal" data-bs-target="#delete-account-modal">Delete your account</button>
                            <div class="modal fade" id="delete-account-modal" tabindex="-1">
                              <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                  <form action="" autocomplete="off" id="delete_account_form">
                                    <div class="modal-header">
                                      <h5 class="modal-title">Modal title</h5>
                                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-header bg-danger-subtle">
                                      <span>
                                        <i class="bi bi-exclamation-triangle text-danger me-2"></i>
                                        This is extremely important.
                                      </span>
                                    </div>
                                    <div class="modal-body">
                                      <p>We will <strong>delete all your data</strong>, and your username will be available to anyone on Template.</p>
                                      <hr />
                                      <dl>
                                        <dt><label for="sudo_login"> Your username or email </label></dt>
                                        <dd>
                                          <input type="text" name="sudo_login" id="sudo_login" required="required" autocomplete="off" class="form-control form-control" />
                                        </dd>
                                        <dt>
                                          <label for="verify_text"> Type <i class="fw-normal user-select-none">delete my account </i>below to verify </label>
                                        </dt>
                                        <dd>
                                          <input type="text" name="verify_text" id="verify_text" required="required" autocomplete="off" class="form-control form-control" />
                                        </dd>
                                        <dt><label for="confirm_password"> Confirm your password </label></dt>
                                        <dd>
                                          <input type="password" name="confirm_password" id="confirm_password" required="required" autocomplete="off" class="form-control form-control" />
                                        </dd>
                                      </dl>
                                    </div>
                                    <div class="modal-footer">
                                      <button type="button" id="delete_account_btn" class="btn btn-danger w-100" disabled>Delete this account</button>
                                    </div>
                                  </form>
                                </div>
                              </div>
                            </div>
                            <script>
                              const deleteAccountForm = document.getElementById("delete_account_form");
                              deleteAccountForm.addEventListener("input", function () {
                                const sudoLogin = document.getElementById("sudo_login").value;
                                const vefiryText = document.getElementById("verify_text").value;
                                const confirmPassword = document.getElementById("confirm_password").value;
                                const submitBtn = document.getElementById("delete_account_btn");
            
                                const isSudoLoginValid = sudoLogin === "Username" || sudoLogin === "user@email.com";
                                const isVerifyTextValid = vefiryText === "delete my account";
                                const isConfirmPasswordValid = confirmPassword !== "";
            
                                if (isSudoLoginValid && isVerifyTextValid && isConfirmPasswordValid) {
                                  submitBtn.disabled = false;
                                } else {
                                  submitBtn.disabled = true;
                                }
                              });
                            </script>
                          </div>
                        </div>-->
            <!--  -->
          </div>
        </div>
      </div>
    </main>

    <jsp:include page="part/footer.jsp" />

    <!--    <footer class="footer mt-auto pt-4">
          <div class="container">
            <div class="row m-0">
              <div class="col-12 col-md">
                <img class="mb-2" src="favicon.ico" alt="" width="19" height="19" />
                <small class="d-block mb-3 text-muted">&copy; 2017–2021</small>
              </div>
              <div class="col-6 col-md">
                <h5>Features</h5>
                <ul class="list-unstyled text-small">
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Cool stuff</a></li>
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Random feature</a></li>
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Team feature</a></li>
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Stuff for developers</a></li>
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Another one</a></li>
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Last time</a></li>
                </ul>
              </div>
              <div class="col-6 col-md">
                <h5>Resources</h5>
                <ul class="list-unstyled text-small">
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Resource</a></li>
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Resource name</a></li>
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Another resource</a></li>
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Final resource</a></li>
                </ul>
              </div>
              <div class="col-6 col-md">
                <h5>About</h5>
                <ul class="list-unstyled text-small">
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Team</a></li>
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Locations</a></li>
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Privacy</a></li>
                  <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Terms</a></li>
                </ul>
              </div>
            </div>
          </div>
          <style>
            body {
              display: flex;
              flex-direction: column;
              min-height: 100vh;
              margin: 0;
            }
    
            main {
              flex: 1;
              padding: 0;
            }
          </style>
        </footer>-->
    <!--</div>-->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js">
    </script>
    <!-- <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script> -->
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js">
    </script>
    <!-- Cropper.min.js -->
    <!-- <script
      src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js"
      integrity="sha512-JyCZjCOZoyeQZSd5+YEAcFgz2fowJ1F1hyJOXgtKu4llIa0KneLcidn5bwfutiehUTiOuK87A986BZJMko0eWQ=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script> -->
    <script>
      $(() => {
        const myModal = document.getElementById("myModal");
        const myInput = document.getElementById("myInput");

        myModal.addEventListener("shown.bs.modal", () => {
          myInput.focus();
        });

        let popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
        let popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
          return new bootstrap.Popover(popoverTriggerEl);
        });

        $('[data-toggle="tooltip"]').tooltip();
      });
    </script>
  </body>
</html>
