/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.account;

import com.cso.shop.dao.ReviewDAO;
import com.cso.shop.model.ProductReview;
import com.cso.shop.model.Review;
import com.cso.shop.model.ReviewAttachment;
import com.cso.shop.model.User;
import com.cso.shop.util.Utils;
import com.google.gson.Gson;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author hi
 */
@MultipartConfig(
  fileSizeThreshold = 1024 * 1024 * 10, // 10MiB
  maxFileSize = 1024 * 1024 * 50, // 50MiB
  maxRequestSize = 1024 * 1024 * 100 // 100MiB
)
public class UserReview extends HttpServlet {

  private ReviewDAO rdao = new ReviewDAO();

  //<%-- ${productRating} --%>
  //<%-- ${reviewCount} --%>
  //<%-- ${reviewList} --%>
  //<%-- ${attachmentMap} --%>
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    resp.setCharacterEncoding("UTF-8");
    resp.setContentType("application/json");
    resp.setHeader("access-control-allow-headers", "content-type");
    resp.setHeader("access-control-allow-origin", "*");
    resp.setHeader("access-control-allow-methods", "get");

    try {
      int productId = Utils.tryParseInt(req.getParameter("productId"), -1);
      int limit = Utils.tryParseInt(req.getParameter("limit"), 10);
      int offset = Utils.tryParseInt(req.getParameter("offset"), 0);

      List<ProductReview> reviewList = rdao.selectAll(productId, limit, offset);
      int[] reviewIds = reviewList.stream().mapToInt(ProductReview::getReviewId).toArray();
      Map<Integer, List<ReviewAttachment>> attachmentMap = rdao.mapAllReviewAttachment(reviewIds);

      List<Float> ratingList = rdao.selectAllRatings(productId);
      int reviewCount = ratingList.size();
      float productRating = (float) ratingList.stream().mapToDouble(Float::floatValue).average().orElse(0.0f);
      boolean haveMoreReviews = (reviewCount > reviewList.size() + offset);

      Map<String, Object> response = new HashMap<>();
      response.put("productRating", productRating);
      response.put("reviewCount", reviewCount);
      response.put("reviewList", reviewList);
      response.put("attachmentMap", attachmentMap);
      response.put("haveMoreReviews", haveMoreReviews);

      Gson gson = new Gson();
      String json = gson.toJson(response);
      resp.getWriter().write(json);

    } catch (SQLException e) {
      resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      resp.getWriter().write("{\"error\": \"An error occurred\"}");
      e.printStackTrace();
    }

  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    HttpSession session = req.getSession();
    User user = (User) session.getAttribute("user");

    if (user == null) {
      String originalURL = URLEncoder.encode(req.getRequestURI(), "UTF-8");
      String redirectURL = req.getContextPath() + "/signin?redirect=" + originalURL;
      resp.sendRedirect(redirectURL);
      return;
    }

    int productId = Utils.tryParseInt(req.getParameter("productId"), -1);
    float rating = Utils.tryParseFloat(req.getParameter("rating"), -1);
    String comment = req.getParameter("comment");

    int userId = user.getUserID();
    Review userReview = new Review();
    userReview.setProductId(productId);
    userReview.setRating(rating);
    userReview.setComment(comment);
    userReview.setUserId(userId);

    List<ReviewAttachment> attachmentList = new ArrayList<>();
    String fileLocation = getServletContext().getInitParameter("file.location");

    if (fileLocation == null || fileLocation.isBlank()) {
      resp.setHeader("refresh", "0.5;url=product-detail?id=" + productId);
      return;
    }

    try {
      rdao.insert(userReview);

      String webFilePath = Utils.getWebFilePath();
      String regex = webFilePath.replaceAll("\\\\", "\\\\\\\\") + ("([^/\\\\]+)");
      Pattern pattern = Pattern.compile(regex);

      Part[] parts = req.getParts()
        .stream()
        .filter(part -> "attachment[]".equals(part.getName()) && part.getSize() > 0)
        .toArray(Part[]::new);

      String[] partDescriptions = req.getParameterValues("attachment-description[]");
      if (partDescriptions == null) {
        partDescriptions = new String[0];
      }

      for (int i = 0; i < parts.length; i++) {
//        if (i >= partDescriptions.length) {
//          break;
//        }

//        if (!"attachment[]".equals(parts[i].getName()) || parts[i].getSize() <= 0) {
//          continue;
//        }
        String attachmentPath = Utils.writeFile(parts[i], fileLocation);
        if (attachmentPath != null) {
          ReviewAttachment attachment = new ReviewAttachment();
          attachment.setAttachment(attachmentPath);

          Matcher matcher = pattern.matcher(attachmentPath);
          if (matcher.find()) {
            attachment.setType(matcher.group(1));
          }
          String description = (i < partDescriptions.length && partDescriptions[i] != null) ? partDescriptions[i] : "";
          attachment.setDescription(description);
          attachmentList.add(attachment);
        }
      }

      if (!attachmentList.isEmpty()) {
        rdao.insertAttachments(userReview.getReviewId(), attachmentList);
      }

    } catch (Exception e) {
      System.err.println(e);
    }

    resp.setHeader("refresh", "0.5;url=product-detail?id=" + productId);
  }

  @Override
  public String getServletInfo() {
    return "Short description";
  }

}
