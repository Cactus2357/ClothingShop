<%-- 
    Document   : cart
    Created on : Dec 3, 2024, 5:07:22 AM
    Author     : hi
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="asset/script/color-modes.js"></script>

    <link rel="stylesheet" href="asset/style/theme-button.css" />
    <link rel="stylesheet" href="asset/style/image-placeholder.css" />

    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-bs5.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.1/dist/summernote-bs5.min.js"></script>

    <!--  -->
    <link rel="stylesheet" href="https://cdn.datatables.net/2.1.8/css/dataTables.bootstrap5.css" />
    <script src="https://cdn.datatables.net/2.1.8/js/dataTables.js"></script>
    <script src="https://cdn.datatables.net/2.1.8/js/dataTables.bootstrap5.js"></script>
    <!--  -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-table@1.23.5/dist/bootstrap-table.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-table@1.23.5/dist/bootstrap-table.min.js"></script>
    <!--  -->

    <style>
      body {
        /* min-height: 75rem; */
        padding-top: 4.5rem;
      }

      .flex-even {
        flex: 1;
      }
    </style>
  </head>
  <body>

    <jsp:include page="part/navbar.jsp" />
    <jsp:include page="part/notification.jsp">
      <jsp:param name="response" value="${response}" />
      <jsp:param name="responseType" value="${responseType}" />
    </jsp:include>

    <main class="container p-5 px-3">
      <div class="container-fluid mb-3">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#" class="link-underline link-underline-opacity-0 link-underline-opacity-100-hover">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Shopping cart</li>
          </ol>
        </nav>
        <h3>Shopping cart</h3>
      </div>
      <style>
        .max-width-col {
          width: auto;
          white-space: nowrap;
        }
      </style>

      <div class="row g-5">
        <div class="col-xl-8 mb-3">
          <div class="table-responsive">
            <table class="table border-top " id="cart-table">
              <c:if test="${not empty cartItems}">
                <thead>
                  <tr>
                    <th scope="col"></th>
                    <th scope="col" class="" style="min-width: 400px;">Products</th>
                    <th scope="col" class="text-end" style="width: 100px;">In stock</th>
                    <th scope="col" class="text-end" style="width: 100px;">Price</th>
                    <th scope="col" class="w-auto" style="width: 200px;">Quantity</th>
                    <th scope="col" class="text-end" style="width: 100px;">Total</th>
                    <th scope="col" class="w-auto"></th>
                  </tr>
                </thead>
              </c:if>
              <tbody class="">
                <c:forEach items="${cartItems}" var="item">
                  <tr class="align-middle cart-item">
                    <td>
                      <img src="${productMap[item.productId].image}" width="48" height="48" class="rounded border object-fit-cover" alt="" />
                    </td>
                    <td>
                      <a href="product-detail?id=${item.productId}" class="link-underline link-underline-opacity-0 link-underline-opacity-100-hover"> ${productMap[item.productId].name} </a>
                    </td>
                    <td class="text-body-emphasis text-end text-muted">${productMap[item.productId].quantity}</td>
                    <td class="text-body-emphasis text-end cart-item-price">$${productMap[item.productId].salePrice}</td>
                    <td>
                      <input type="number" class="form-control form-control-sm cart-item-quantity" min="1" max="${productMap[item.productId].quantity}" value="1" name="" id="" />
                    </td>
                    <td class="text-body-emphasis text-end cart-item-total">_</td>
                    <td>
                      <button class="btn btn-outline-danger border-0"><i class="bi bi-trash3"></i></button>
                    </td>
                  </tr>
                </c:forEach>
                <c:if test="${empty cartItems}">
                  <tr><td class="text-center"> No items found </td></tr>
                </c:if>
                <c:if test="${not empty cartItems}">
                  <tr class="align-middle">
                    <td class="text-body-emphasis fw-semibold fs-5" colspan="5">Items subtotal :</td>
                    <td class="text-body-emphasis fw-bold text-end cart-subtotal">$691</td>
                    <td>
                      <button class="btn btn-outline-danger border-0"><i class="bi bi-trash3"></i></button>
                    </td>
                  </tr>
                </c:if>

              </tbody>
            </table>
          </div>
          <script>
            $(() => {
              function updateItemTotal($cartItem) {
                const price = parseFloat($cartItem.find(".cart-item-price").text().replace("$", "")) || 0;
                const quantity = parseInt($cartItem.find(".cart-item-quantity").val()) || 1;
                const total = price * quantity;
                $cartItem.find(".cart-item-total").text(`$\${total.toFixed(2)}`);
              }

              function updateSubtotal() {
                let subtotal = 0;
                $(".cart-item").each((index, element) => {
                  const $item = $(element);
                  const total = parseFloat($item.find(".cart-item-total").text().replace("$", "")) || 0;
                  subtotal += total;
                });
                $(".cart-subtotal").text(`$\${subtotal.toFixed(2)}`);
                calculateSummary();
              }

              $(".cart-item").each((index, element) => {
                const $item = $(element);
                updateItemTotal($item);
              });

              $(".cart-item-quantity").on("input", function () {
                const $row = $(this).closest(".cart-item");
                updateItemTotal($row);
                updateSubtotal();
              });

              function calculateSummary() {
                const subtotal = parseFloat($(".cart-subtotal").text().replace("$", "")) || 0;
                const discount = 59;
                const taxRate = 0.18;
                const shippingCost = 30;

                const tax = subtotal * taxRate;
                const total = subtotal - discount + tax + shippingCost;

                $(".cart-subtotal").text(`$\${subtotal.toFixed(2)}`);
                $(".text-danger").text(`-$\${discount.toFixed(2)}`);
                $(".text-body-emphasis")
                        .filter((_, el) => $(el).text().includes("Tax"))
                        .text(`$\${tax.toFixed(2)}`);
                $(".text-body-emphasis")
                        .filter((_, el) => $(el).text().includes("Shipping"))
                        .text(`$\${shippingCost.toFixed(2)}`);
                $(".d-flex h4")
                        .last()
                        .text(`$\${total.toFixed(2)}`);
              }

              $(".btn-outline-primary").on("click", () => {
                const voucherCode = $(".form-control").val().trim();
                if (voucherCode === "DISCOUNT10") {
                  alert("Voucher applied: $10 discount");
                  calculateSummary();
                } else {
                  alert("Invalid voucher code");
                }
              });



              calculateSummary();

              updateSubtotal();
            });
          </script>

        </div>
        <div class="col-xl-4 mb-3">
          <div class="card">
            <div class="card-body">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="mb-0">Summary</h3>
                <a class="btn btn-link link-underline link-underline-opacity-0 link-underline-opacity-100-hover p-0" href="#">Edit cart</a>
              </div>
              <select class="mb-3 form-select">
                <option value="cod">Cash on Delivery</option>
                <option value="card">Card</option>
                <option value="paypal">Paypal</option>
              </select>
              <div>
                <div class="d-flex justify-content-between">
                  <p class="text-body fw-semibold">Items subtotal :</p>
                  <p class="text-body-emphasis fw-semibold cart-subtotal">_</p>
                </div>
                <div class="d-flex justify-content-between">
                  <p class="text-body fw-semibold">Discount :</p>
                  <p class="text-danger fw-semibold">-$59</p>
                </div>
                <div class="d-flex justify-content-between">
                  <p class="text-body fw-semibold">Tax :</p>
                  <p class="text-body-emphasis fw-semibold">$126.2</p>
                </div>
                <div class="d-flex justify-content-between">
                  <p class="text-body fw-semibold">Subtotal :</p>
                  <p class="text-body-emphasis fw-semibold">$665</p>
                </div>
                <div class="d-flex justify-content-between">
                  <p class="text-body fw-semibold">Shipping Cost :</p>
                  <p class="text-body-emphasis fw-semibold">$30</p>
                </div>
              </div>
              <div class="mb-3 input-group"><input placeholder="Voucher" aria-label="voucher" class="form-control" /><button type="button" class="px-5 btn btn-outline-primary">Apply</button></div>
              <div class="d-flex justify-content-between border-top border-bottom border-translucent py-3 mb-4">
                <h4 class="mb-0">Total :</h4>
                <h4 class="mb-0">_</h4>
              </div>
              <button type="button" class="w-100 btn btn-primary">Proceed to check out <i class="bi bi-chevron-right"></i></button>
            </div>
          </div>
        </div>
      </div>
    </main>
    <div class="container">
      <footer class="py-3 my-4">
        <ul class="nav justify-content-center border-bottom pb-3 mb-3">
          <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Home</a></li>
          <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Features</a></li>
          <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Pricing</a></li>
          <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">FAQs</a></li>
          <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">About</a></li>
        </ul>
        <p class="text-center text-body-secondary">&copy; 2024 Company, Inc</p>
      </footer>
    </div>

    <script src="js/bootstrap.bundle.min.js"></script>
  </body>
</html>
