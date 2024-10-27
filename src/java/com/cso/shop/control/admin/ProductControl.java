/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.admin;

import com.cso.shop.dao.CategoryDAO;
import com.cso.shop.dao.ProductDAO;
import com.cso.shop.model.Category;
import com.cso.shop.model.Product;
import com.cso.shop.util.Utils;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hi
 */
@MultipartConfig(
  //  location = "/tmp/upload/",
  fileSizeThreshold = 1024 * 1024 * 2, // 2MiB
  maxFileSize = 1024 * 1024 * 10, // 10MiB
  maxRequestSize = 1024 * 1024 * 50 // 50MiB
)
public class ProductControl extends HttpServlet {

  private ProductDAO pdao = new ProductDAO();
  private CategoryDAO cdao = new CategoryDAO();

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    try {
      req.setAttribute("categoryList", cdao.selectAll());

      int productId = Utils.tryParseInt(req.getParameter("id"), -1);
      if (productId != -1) {
        List<Category> productCategory = cdao.selectAll(productId);
        Map<Integer, Boolean> map = new HashMap<>();
        productCategory.forEach(c -> map.put(c.getId(), true));
        Product p = new Product();
        p.setId(productId);

        req.setAttribute("productCategory", map);
        req.setAttribute("product", pdao.select(p));
      }
    } catch (SQLException ex) {
      Logger.getLogger(ProductControl.class.getName()).log(Level.SEVERE, null, ex);
    }
    req.getRequestDispatcher("WEB-INF/product-control.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    processRequest(req, resp);
  }

  @Override
  public String getServletInfo() {
    return "Products";
  }// </editor-fold>

  protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {

    int productId = Utils.tryParseInt(req.getParameter("id"), -1);
    String name = req.getParameter("title");
    double unitPrice = Utils.tryParseDouble(req.getParameter("original-price"), -1.0);
    double salePrice = Utils.tryParseDouble(req.getParameter("selling-price"), -1.0);
    int quantity = Utils.tryParseInt(req.getParameter("quantity"), -1);
    String[] categoryIdStrings = req.getParameterValues("category");
    int[] categoryIds = new int[0];

    if (categoryIdStrings != null && categoryIdStrings.length != 0) {
      categoryIds = new int[categoryIdStrings.length];
      for (int i = 0; i < categoryIds.length; i++) {
        categoryIds[i] = Utils.tryParseInt(categoryIdStrings[i], -1);
      }
    }

    String description = req.getParameter("description");
    String imagePath = req.getParameter("image-path");
    Part imagePart = req.getPart("image");

    try {
      if (name == null || name.isBlank()) {
        throw new Exception("Invalid product name");
      }
      if (unitPrice < 0.0) {
        throw new Exception("Invalid product unit price");
      }

      if (salePrice < 0.0) {
        throw new Exception("Invalid product sale price");
      }

      if (quantity < 0) {
        throw new Exception("Invalid product product quantity");
      }

      String fileLocation = getServletContext().getInitParameter("file.location");
      String image = Utils.writeFile(imagePart, fileLocation);

      Product p = new Product();
      p.setName(name);
      p.setUnitPrice(unitPrice);
      p.setSalePrice(salePrice);
      p.setQuantity(quantity);
      p.setDescription(description);
      if (image != null) {
        p.setImage(image);
      } else if (imagePath != null && !imagePath.isBlank()) {
        p.setImage(imagePath);
      }
      String out = "";
      if (categoryIdStrings != null) {
        for (String s : categoryIdStrings) {
          out += s + " ";
        }
      }
      req.setAttribute("response", out);

      if (productId > 0) {
        p.setId(productId);
        pdao.update(p);
        cdao.insertProductCategories(productId, categoryIds);
        req.setAttribute("response", "Product updated successfully");
      }

      req.setAttribute("responseType", true);
      req.setAttribute("id", p.getId());
    } catch (Exception e) {
      log(e.getMessage());
      req.setAttribute("response", e.getMessage());
      req.setAttribute("responseType", false);
    }

    doGet(req, resp);
  }

//  /**
//   *
//   * @param image Image part
//   * @param webImageDir directory on web server (ends with '/')
//   * @return A relative URL string to image on server
//   */
//  private String createImage(Part image, String webImageDir) throws IOException {
//    if (image == null || webImageDir == null) {
//      return null;
//    }
//    String name = image.getSubmittedFileName();
//    int dotIndex = name.lastIndexOf('.');
//    String extension = (dotIndex > 0) ? name.substring(dotIndex) : "";
//    if (extension.isBlank()) {
//      return null;
//    }
//
//    String timestamp = LocalDateTime.now()
//      .format(DateTimeFormatter.ofPattern("yyyyMMddhhmmss"));
//    String new_name = Utils.hash(timestamp + name) + extension;
//
//    String img_dir = getServletContext().getRealPath(webImageDir);
//    String web_path = webImageDir + new_name;
//    String physical_path = img_dir + new_name;
//
//    File dir = new File(img_dir);
//    if (!dir.exists()) {
//      dir.mkdirs();
//    }
//
//    image.write(physical_path);
//    return web_path;
//  }
//  private String createUniqueName(String name, String extension) {
//    String timestamp = LocalDateTime.now()
//      .format(DateTimeFormatter.ofPattern("yyyyMMddhhmmss"));
//    String newName = Utils.hash(timestamp + name) + extension;
//    return newName;
//  }
}
