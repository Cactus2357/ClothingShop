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
import java.sql.SQLException;
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
        populateProductAttributes(req, productId);
      }

    } catch (SQLException ex) {
      Logger.getLogger(ProductControl.class.getName()).log(Level.SEVERE, null, ex);
      req.setAttribute("response", "Eror retrieving product information.");
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
    int[] categoryIds = parseCategoryIds(req.getParameterValues("category"));
    String description = req.getParameter("description");

    String imagePath = req.getParameter("image-path");
    Part imagePart = req.getPart("image");

    try {
      validateUserInput(name, unitPrice, salePrice, quantity);

      String imageLocation = saveImage(imagePart, imagePath);

//      String fileLocation = getServletContext().getInitParameter("file.location");
//      String image = Utils.writeFile(imagePart, fileLocation);
      Product product = createProduct(productId, name, unitPrice, salePrice, quantity, description, imageLocation);

      if (productId > 0) {
        updateProduct(req, product, categoryIds);
      } else {
        addNewProduct(req, product, categoryIds);
      }

      req.setAttribute("responseType", true);
    } catch (Exception e) {
      log(e.getMessage());
      req.setAttribute("response", e.getMessage());
    }

    doGet(req, resp);

  }

  private void validateUserInput(String name, double unitPrice, double salePrice, int quantity) throws Exception {
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
  }

  private void populateProductAttributes(HttpServletRequest req, int productId) throws SQLException {
    List<Category> productCategory = cdao.selectAll(productId);
    Map<Integer, Boolean> map = new HashMap<>();
    productCategory.forEach(c -> map.put(c.getId(), true));

    Product product = new Product();
    product.setId(productId);
    product = pdao.select(product);

    req.setAttribute("productCategory", map);
    req.setAttribute("product", product);
  }

  private int[] parseCategoryIds(String[] categoryIdStrings) {
    if (categoryIdStrings == null || categoryIdStrings.length == 0) {
      return new int[0];
    }

    int[] categoryIds = new int[categoryIdStrings.length];
    for (int i = 0; i < categoryIds.length; i++) {
      categoryIds[i] = Utils.tryParseInt(categoryIdStrings[i], -1);
    }
    return categoryIds;

  }

  private String saveImage(Part imagePart, String imagePath) throws IOException {
    if (imagePart != null && imagePart.getSize() > 0) {
      String fileLocation = getServletContext().getInitParameter("file.location");
      return Utils.writeFile(imagePart, fileLocation);
    }
    return imagePath != null && !imagePath.isBlank() ? imagePath : null;
  }

  private Product createProduct(int productId, String name, double unitPrice, double salePrice, int quantity, String description, String imageLocation) {
    Product product = new Product();
    product.setId(productId);
    product.setName(name);
    product.setUnitPrice(unitPrice);
    product.setSalePrice(salePrice);
    product.setQuantity(quantity);
    product.setDescription(description);
    product.setImage(imageLocation);
    return product;
  }

  private void updateProduct(HttpServletRequest req, Product product, int[] categoryIds) throws SQLException {
    pdao.update(product);
    cdao.insertProductCategories(product.getId(), categoryIds);
    req.setAttribute("response", "Product updated successfully");
  }

  private void addNewProduct(HttpServletRequest req, Product product, int[] categoryIds) throws SQLException {
    pdao.insert(product);
    cdao.insertProductCategories(product.getId(), categoryIds);
    req.setAttribute("response", "Product added successfully");

  }

}
