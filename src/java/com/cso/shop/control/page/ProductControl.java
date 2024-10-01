/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.page;

import com.cso.shop.dao.ProductDAO;
import com.cso.shop.model.Product;
import com.cso.shop.util.Utils;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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

  private static String webImagePath = "asset/img/";
  private ProductDAO pdao = new ProductDAO();

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
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
    String name = req.getParameter("title");
    String originalPrice = req.getParameter("original-price");
    String sellingPrice = req.getParameter("selling-price");
    String quantity = req.getParameter("quantity");
    String description = req.getParameter("description");
    Part imagePart = req.getPart("image");

    try {
      if (name == null || name.isBlank()) {
        throw new Exception("Invalid name");
      }
      double unitPrice = Double.parseDouble(originalPrice);
      double salePrice = Double.parseDouble(sellingPrice);
      int quantityInt = Integer.parseInt(quantity);
      String image = createImage(imagePart, webImagePath);

      log(imagePart.getContentType());
      log(imagePart.getName());
      log(imagePart.getSubmittedFileName());

//      Product p = new Product();
//      p.setName(name);
//      p.setUnitPrice(unitPrice);
//      p.setSalePrice(salePrice);
//      p.setQuantity(quantityInt);
//      p.setDescription(description);
//      p.setImage(image);
//
//      pdao.insert(p);
      resp.sendRedirect(req.getRequestURI());

    } catch (Exception e) {
      log(e.getMessage());
      resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Bad request");
      return;
    }

  }

  /**
   *
   * @param image Image part
   * @param webImageDir directory on web server (ends with '/')
   * @return A relative URL string to image on server
   *
   */
  private String createImage(Part image, String webImageDir) throws IOException {
    if (image == null || webImageDir == null) {
      return null;
    }
    String name = image.getSubmittedFileName();
    String contentType = image.getContentType();
    String extension = contentType.substring(contentType.lastIndexOf('/') + 1);

    String timestamp = LocalDateTime.now()
      .format(DateTimeFormatter.ofPattern("yyyyMMdd_hhmmss"));
    String new_name = Utils.hash(timestamp + name) + extension;

    String img_dir = getServletContext().getRealPath(webImageDir);
    String web_path = webImageDir + new_name;
    String physical_path = img_dir + new_name;

    File dir = new File(img_dir);
    if (!dir.exists()) {
      dir.mkdirs();
    }

    image.write(physical_path);
    return web_path;
  }

  private String createUniqueName(String name, String extension) {
    String timestamp = LocalDateTime.now()
      .format(DateTimeFormatter.ofPattern("yyyyMMddhhmmss"));
    String newName = Utils.hash(timestamp + name) + extension;
    return newName;
  }

}
