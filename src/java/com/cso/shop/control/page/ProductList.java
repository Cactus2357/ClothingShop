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
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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
    String query = req.getParameter("q");
    String sortBy = req.getParameter("s");
    String size = req.getParameter("n");
    String page = req.getParameter("p");
    List<Product> productList = null;

    try {
      Integer sortByInteger = Integer.parseInt(sortBy);
      Integer sizeInteger = Integer.parseInt(size);
      Integer pageInteger = Integer.parseInt(page);
      productList = pdao.selectAll(query, sortByInteger, sizeInteger, pageInteger);
    } catch (Exception e) {
      System.err.println(e);
    }

    req.setAttribute("product-list", productList);
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

}
