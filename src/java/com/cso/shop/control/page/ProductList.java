/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.page;

import com.cso.shop.dao.CategoryDAO;
import com.cso.shop.dao.ProductDAO;
import com.cso.shop.model.Category;
import com.cso.shop.model.Product;
import com.cso.shop.util.Utils;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 *
 * @author hi
 */
public class ProductList extends HttpServlet {

  private ProductDAO pdao = new ProductDAO();
  private CategoryDAO cdao = new CategoryDAO();

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    List<Product> productList = null;
    List<Category> categoryList = null;

    String query = req.getParameter("query");
    int order = Utils.tryParseInt(req.getParameter("order"), 0);
    int size = Utils.tryParseInt(req.getParameter("size"), 9);
    int page = Utils.tryParseInt(req.getParameter("page"), 1);
    int display = Utils.tryParseInt(req.getParameter("display"), 2);
    int categoryId = Utils.tryParseInt(req.getParameter("category-id"), -1);

    if (size <= 4) {
      size = 5;
    } else if (size >= 21) {
      size = 20;
    }

    if (query != null && !query.isBlank()) {
      req.setAttribute("query", query);
    }
    req.setAttribute("order", order);
    req.setAttribute("size", size);
    req.setAttribute("page", page);
    if (display >= 1 && display <= 3) {
      req.setAttribute("display", display);
    }

    try {
      productList = pdao.selectAll(query, categoryId, order, size, (page - 1) * size);

      int[] productIds = new int[productList.size()];
      for (int i = 0; i < productIds.length; i++) {
        productIds[i] = productList.get(i).getId();
      }

      Map<Integer, List<Category>> productCategoryMap = cdao.selectBatch(productIds);
      req.setAttribute("productCategoryMap", productCategoryMap);

      categoryList = cdao.selectAll();

      req.setAttribute("suggestions", cdao.selectBatch("Men's Clothing", "Women's Clothing", "Accessories"));
    } catch (Exception e) {
      System.err.println(e);
      log(e.getMessage());
    }

    int totalItems = pdao.countSelectAll(query, categoryId);
    int pageCount = (int) Math.ceil((double) totalItems / (double) size);

    req.setAttribute("totalItems", totalItems);
    req.setAttribute("totalPages", pageCount);
    req.setAttribute("productList", productList);
    req.setAttribute("categoryList", categoryList);

    req.getRequestDispatcher("WEB-INF/product-list.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    processRequest(req, resp);
  }

  @Override
  public String getServletInfo() {
    return "Short description";
  }// </editor-fold>

  protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    resp.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = resp.getWriter()) {
      out.println("ProductList at " + req.getContextPath());
    }
  }

//  private int tryParseInt(String value, int defaultVal) {
//    try {
//      return Integer.parseInt(value);
//    } catch (NumberFormatException e) {
//      return defaultVal;
//    }
//  }
}
