/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.control.page;

import com.cso.dao.CategoryDAO;
import com.cso.dao.ProductDAO;
import com.cso.model.Product;
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
public class ProductDetail extends HttpServlet {

  private ProductDAO pdao = new ProductDAO();
  private CategoryDAO cdao = new CategoryDAO();

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    try {
      String productIdString = req.getParameter("id");
      int productId = Integer.parseInt(productIdString);

      Product p = new Product();
      p.setId(productId);
      p = pdao.select(p);
      if (p == null) {
        throw new Exception("no product found");
      }

      List list = cdao.selectAll(productId);
      req.setAttribute("categoryList", list);
      req.setAttribute("product", p);
      req.getRequestDispatcher("WEB-INF/product-detail.jsp").forward(req, resp);
      return;
    } catch (SQLException e) {
      log(e.getMessage());
    } catch (Exception e) {
      log(e.getMessage());
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