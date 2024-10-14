/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.control.admin;

import com.cso.dao.CategoryDAO;
import com.cso.model.Category;
import com.cso.util.Utils;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hi
 */
public class CategoryControl extends HttpServlet {

  private CategoryDAO cdao = new CategoryDAO();

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    List<Category> list = new ArrayList<>();
    try {
      list = cdao.selectAll();
    } catch (SQLException ex) {
      Logger.getLogger(CategoryControl.class.getName()).log(Level.SEVERE, null, ex);
    }
    req.setAttribute("categoryList", list);
    req.getRequestDispatcher("WEB-INF/category-control.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    int id = Utils.tryParseInt(req.getParameter("category-id"), -1);
    String name = req.getParameter("category-name");
    try {
      if (name == null || name.isBlank()) {
        throw new Exception("invalid name");
      }
      Category c = new Category();
      c.setName(name);
      if (id != -1) {
        c.setId(id);
        cdao.update(c);
        req.setAttribute("response", "Updated category name");
      } else {
        cdao.insert(c);
        req.setAttribute("response", "Category created");
      }
      req.setAttribute("response_type", true);

    } catch (Exception e) {
      req.setAttribute("response", e.getMessage());
    }
    doGet(req, resp);
  }

  @Override
  public String getServletInfo() {
    return "Short description";
  }// </editor-fold>

  protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    resp.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = resp.getWriter()) {
      out.println("CategoryControl at " + req.getContextPath());
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
