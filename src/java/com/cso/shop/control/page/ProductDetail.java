/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.page;

import com.cso.shop.dao.CategoryDAO;
import com.cso.shop.dao.ProductDAO;
import com.cso.shop.dao.ReviewDAO;
import com.cso.shop.model.Category;
import com.cso.shop.model.Product;
import com.cso.shop.model.ProductReview;
import com.cso.shop.model.ReviewAttachment;
import com.cso.shop.util.Utils;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hi
 */
public class ProductDetail extends HttpServlet {

  private ProductDAO pdao = new ProductDAO();
  private CategoryDAO cdao = new CategoryDAO();
  private ReviewDAO rdao = new ReviewDAO();

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {

    int productId = Utils.tryParseInt(req.getParameter("id"), -1);
    Product product = new Product();
    product.setId(productId);

    try {
      product = pdao.select(product);

      if (product == null) {
        throw new Exception("no product found");
      }

      List<Category> categoryList = cdao.selectAll(productId);
      List<ProductReview> reviewList = rdao.selectAll(productId, 3);

      int[] reviewIds = reviewList.stream().mapToInt(ProductReview::getReviewId).toArray();
      Map<Integer, List<ReviewAttachment>> attachmentMap = rdao.mapAllReviewAttachment(reviewIds);

      List<Float> ratingList = rdao.selectAllRatings(productId);
      float productRating = (float) ratingList.stream().mapToDouble(Float::doubleValue).average().orElse(0.0);
      int reviewCount = ratingList.size();

      req.setAttribute("product", product);
      req.setAttribute("productRating", productRating);
      req.setAttribute("categoryList", categoryList);
      req.setAttribute("reviewCount", reviewCount);
      req.setAttribute("reviewList", reviewList);
      req.setAttribute("attachmentMap", attachmentMap);
      req.setAttribute("haveMoreReviews", (reviewCount > reviewList.size()));

      req.getRequestDispatcher("WEB-INF/product-detail.jsp").forward(req, resp);
      return;

    } catch (SQLException e) {
      log(e.getMessage());
    } catch (Exception e) {
      System.err.println(e);
    }

    resp.sendRedirect("product-list");
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    resp.sendError(404);
  }

  @Override
  public String getServletInfo() {
    return "Short description";
  }// </editor-fold>

  protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    resp.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = resp.getWriter()) {
      out.println("ProductDetail at " + req.getContextPath());
    }
  }

}
