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
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hi
 */
public class Signup extends HttpServlet {

  private UserDAO udao = new UserDAO();

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    req.getRequestDispatcher("WEB-INF/signup.jsp").forward(req, resp);
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
      validateUserInput(req, resp);
    } catch (Exception e) {

      repopulateUserInput(req);
      req.setAttribute("response", e.getMessage());
      doGet(req, resp);

      return;
    }

    try {
      User user = udao.insert(parse(req));
      if (user != null) {
        HttpSession session = req.getSession();
        session.setAttribute("user", user);
        session.setMaxInactiveInterval(60 * 60);
      } else {
        throw new SQLException("user = null");
      }

      req.setAttribute("response_ok", "User sign up successfully. redirecting...");
      resp.setHeader("refresh", "1.5;url=home");

    } catch (SQLException e) {
      req.setAttribute("response", "Internal sevre error");
      log(e.getMessage());
    }

    doGet(req, resp);

  }

  private User parse(HttpServletRequest req) {
    User user = new User();
    user.setName(req.getParameter("name"));
    user.setEmail(req.getParameter("email"));
    user.setPassword(req.getParameter("password"));
    user.setFullName(req.getParameter("fullName"));
    user.setGender(req.getParameter("gender").equals("male"));
    user.setPhone(req.getParameter("phone"));
    user.setAddress(req.getParameter("address"));
    return user;
  }

  private boolean validateUserInput(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, Exception {
    String name = req.getParameter("name");
    String email = req.getParameter("email");
    String password = req.getParameter("password");
    String passwordCfm = req.getParameter("passwordCfm");
    String fullname = req.getParameter("fullName");
    String gender = req.getParameter("gender");
//    String phone = req.getParameter("phone");
//    String address = req.getParameter("address");

    if (name == null || email == null || password == null
      || passwordCfm == null || fullname == null || gender == null) {
      throw new Exception("user input missing");
    }

    if (!name.matches("\\w{3,20}")) {
      throw new Exception("invalid username. can only contain alphanumeric & underscore, between 3 and 20 characters.");
    }

    if (udao.selectByName(name) != null) {
      throw new Exception("username already taken");
    }

    if (!password.equals(passwordCfm)) {
      throw new Exception("confirm password not match");
    }

    if (!(gender.equals("male") || gender.equals("female"))) {
      throw new Exception("invalid gender");
    }

//    PrintWriter out = resp.getWriter();
//    resp.setContentType("text/html;charset=UTF-8");
//    out.printf("%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",
//      name, email, password, passwordCfm, fullname, gender, phone, address);
    return true;
  }

  private void repopulateUserInput(HttpServletRequest req) {
    req.setAttribute("name", req.getParameter("name"));
    req.setAttribute("email", req.getParameter("email"));
    req.setAttribute("password", req.getParameter("password"));
    req.setAttribute("passwordCfm", req.getParameter("passwordCfm"));
    req.setAttribute("fullname", req.getParameter("fullName"));
    req.setAttribute("gender", req.getParameter("gender"));
    req.setAttribute("phone", req.getParameter("phone"));
    req.setAttribute("address", req.getParameter("address"));
  }
}
