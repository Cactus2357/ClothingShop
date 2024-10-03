/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.page;

import com.cso.shop.dao.ProductDAO;
import com.cso.shop.model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author hi
 */
public class ProductList extends HttpServlet {

  private ProductDAO pdao = new ProductDAO();

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    List<Product> productList = null;

    String query = req.getParameter("query");
//    String sortByString = req.getParameter("s");
//    String sizeString = req.getParameter("n");
//    String pageString = req.getParameter("p");
    int order = tryParseInt(req.getParameter("order"), 0);
    int size = tryParseInt(req.getParameter("size"), 9);
    if (size <= 4) {
      size = 5;
    } else if (size >= 21) {
      size = 20;
    }
    int page = tryParseInt(req.getParameter("page"), 1);

    if (query != null && !query.isBlank()) {
      req.setAttribute("query", query);
    }
//    if (order != 0) {
    req.setAttribute("order", order);
//    }
//    if (size != 9) {
    req.setAttribute("size", size);
//    }
//    if (page != 1) {
    req.setAttribute("page", page);
//    }

    try {

      productList = pdao.selectAll(query, order, size, page);
    } catch (Exception e) {
      System.err.println(e);
      log(e.getMessage());
    }

    int totalItems = pdao.countSelectAll(query);
    req.setAttribute("totalItems", totalItems);
    req.setAttribute("totalPages", (int) Math.ceil((double) totalItems / (double) size));
    req.setAttribute("productList", productList);
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

  private int tryParseInt(String value, int defaultVal) {
    try {
      return Integer.parseInt(value);
    } catch (NumberFormatException e) {
      return defaultVal;
    }
  }

}
