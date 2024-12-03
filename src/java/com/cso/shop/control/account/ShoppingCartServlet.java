/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.account;

import com.cso.shop.dao.CartDAO;
import com.cso.shop.dao.ProductDAO;
import com.cso.shop.model.CartItem;
import com.cso.shop.model.Product;
import com.cso.shop.model.User;
import com.cso.shop.util.Utils;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
@WebServlet(name = "ShoppingCartServlet", urlPatterns = {"/cart"})
public class ShoppingCartServlet extends HttpServlet {

  private CartDAO cdao = new CartDAO();
  private ProductDAO pdao = new ProductDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {

    HttpSession session = req.getSession();
    User user = (User) session.getAttribute("user");

    try {
      List<CartItem> cartItems = cdao.selectAll(user.getUserID());
      int[] productIds = cartItems
        .stream()
        .map(CartItem::getProductId)
        .distinct()
        .mapToInt(Integer::intValue)
        .toArray();
      List<Product> productList = pdao.selectAll(productIds);
      Map<Integer, Product> productMap = new HashMap<>();
      productList.forEach(p -> productMap.put(p.getId(), p));

      req.setAttribute("cartItems", cartItems);
      req.setAttribute("productMap", productMap);
      req.getRequestDispatcher("WEB-INF/cart.jsp").forward(req, resp);

    } catch (SQLException ex) {
//      resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//      resp.getWriter().write("{\"error\": \"An error occurred\"}");
      resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred");
      ex.printStackTrace();
    }

  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    processRequest(req, resp);
  }

  @Override
  protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    resp.setCharacterEncoding("UTF-8");
    resp.setContentType("application/json");
    resp.setHeader("access-control-allow-headers", "content-type");
    resp.setHeader("access-control-allow-origin", "*");
    resp.setHeader("access-control-allow-methods", "DELETE, GET, POST, OPTIONS");

    Map<String, Object> response = new HashMap<>();
    try {
      String cartIdString = req.getParameter("cartItemId");

      if (cartIdString == null || cartIdString.isEmpty()) {
        resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.put("error", "Missing 'cartItemId' parameter.");
      } else if ("all".equals(cartIdString)) {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
          resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
          response.put("error", "User not logged in.");
        } else {
          cdao.deleteAll(user.getUserID());
          response.put("response", "All cart items deleted.");
        }
      } else {
        int cartItemId = Utils.tryParseInt(cartIdString, 0);
        if (cartItemId > 0) {
          cdao.delete(cartItemId);
          response.put("response", "Cart item deleted.");
        } else {
          resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
          response.put("error", "Invalid 'cartItemId' parameter.");
        }
      }
    } catch (SQLException e) {
      resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      response.put("error", "An internal server error occurred.");
      e.printStackTrace();
    } catch (Exception e) {
      resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      response.put("error", "Unexpected error occurred.");
      e.printStackTrace();
    }

    // Send the JSON response
    Gson gson = new Gson();
    String json = gson.toJson(response);
    resp.getWriter().write(json);
  }

  protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    resp.setContentType("text/html;charset=UTF-8");
    try (PrintWriter out = resp.getWriter()) {
      out.println("ShoppingCartServlet at " + req.getContextPath());
    }
  }

}
