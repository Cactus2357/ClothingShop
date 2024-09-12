/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.account;

import com.cso.shop.dao.UserDAO;
import com.cso.shop.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author hi
 */
public class Signin extends HttpServlet {

  private UserDAO udao = new UserDAO();

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    req.getRequestDispatcher("WEB-INF/signin.jsp").forward(req, resp);
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

    try {
      validateUserInput(req);
    } catch (Exception e) {

      req.setAttribute("sudoLogin", req.getParameter("sudoLogin"));
      req.setAttribute("response", e.getMessage());
      doGet(req, resp);

      return;
    }

    try {
      String sudoLogin = req.getParameter("sudoLogin");
      String password = req.getParameter("password");
      User user = udao.authorize(sudoLogin, password);
      if (user == null) {
        req.setAttribute("response", "Email/password is incorrect or your account does not have password authentication enabled");
      } else {
        HttpSession session = req.getSession();
        session.setAttribute("user", user);
        resp.setHeader("refresh", "1.5;url=home");
        req.setAttribute("response_ok", "Sign in successfully. Redirecting...");
      }

    } catch (Exception e) {
      req.setAttribute("response", "Internal server error");
    }

    doGet(req, resp);

  }

  private boolean validateUserInput(HttpServletRequest req) throws Exception {
    String sudoLogin = req.getParameter("sudoLogin");
    String password = req.getParameter("password");

    if (sudoLogin == null || password == null) {
      throw new Exception("user input missing");
    }

    return true;
  }

}
