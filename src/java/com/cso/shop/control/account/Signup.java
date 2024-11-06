/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.account;

import com.cso.shop.dao.UserDAO;
import com.cso.shop.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

/**
 *
 * @author hi
 */
public class Signup extends HttpServlet {

  private UserDAO udao = UserDAO.getInstance();

  // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
  // + sign on the left to edit the code.">
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    req.getRequestDispatcher("WEB-INF/signup.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {

    validateUserForm(req, resp);
  }

  protected void validateUserForm(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    User tempUser;

    try {
      validateUserInput(req, resp);
      tempUser = parse(req);

      if (udao.selectByName(tempUser.getUserName()) != null
        || udao.selectByEmail(tempUser.getEmail()) != null) {
        throw new Exception("User already exists.");
      }

    } catch (Exception e) {
      forwardUserInput(req);
      req.setAttribute("response", e.getMessage());
      req.getRequestDispatcher("WEB-INF/signup.jsp").forward(req, resp);
      return;
    }

    processCreatingUserAccount(req, resp);
//    req.getRequestDispatcher("WEB-INF/signup.jsp").forward(req, resp);
  }

  private void processCreatingUserAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    try {
      User user = parse(req);
      udao.insert(user);

      HttpSession session = req.getSession();
      session.setAttribute("user", user);
      session.setMaxInactiveInterval(60 * 60);

      resp.setHeader("refresh", "1.5;url=home");
      req.setAttribute("response", "User sign up successfully. Redirecting...");
      req.setAttribute("responseType", true);

    } catch (SQLException e) {
      req.setAttribute("response", "Internal sevre error");
      log(e.getMessage());
    }
    req.getRequestDispatcher("WEB-INF/signup.jsp").forward(req, resp);

  }

  private User parse(HttpServletRequest req) {
    User user = new User();
    user.setUserName(req.getParameter("name"));
    user.setEmail(req.getParameter("email"));
    user.setPassword(req.getParameter("password"));
    user.setFamilyName(req.getParameter("familyName"));
    user.setGivenName(req.getParameter("givenName"));
    user.setGender(req.getParameter("gender"));
    user.setPhone(req.getParameter("phone"));
    user.setAddress(req.getParameter("address"));
    return user;
  }

  private boolean validateUserInput(HttpServletRequest req, HttpServletResponse resp)
    throws IOException, SQLException, Exception {
    String name = req.getParameter("name");
    String email = req.getParameter("email");
    String password = req.getParameter("password");
    String passwordCfm = req.getParameter("passwordCfm");
    // String familyName = req.getParameter("familyName");
    String givenName = req.getParameter("givenName");
    String gender = req.getParameter("gender");
    String phone = req.getParameter("phone");
    String address = req.getParameter("address");

    if (name == null || email == null || password == null
      || passwordCfm == null || givenName == null || gender == null || phone == null || address == null) {
      throw new Exception("User input missing");
    }

    if (!name.matches("\\w{3,20}")) {
      throw new Exception("Username can only contain alphanumeric & underscore, between 3 and 20 characters.");
    }

    if (udao.selectByName(name) != null) {
      throw new Exception("Username already taken");
    }

    if (password.length() < 8) {
      throw new Exception("Password must be at least 8 characters long");
    }

    if (!password.equals(passwordCfm)) {
      throw new Exception("Confirm password does not match");
    }

    if (!(gender.equals("male") || gender.equals("female"))) {
      throw new Exception("Invalid gender");
    }

    return true;
  }

  private void forwardUserInput(HttpServletRequest req) {
    req.setAttribute("name", req.getParameter("name"));
    req.setAttribute("email", req.getParameter("email"));
    req.setAttribute("familyName", req.getParameter("familyName"));
    req.setAttribute("givenName", req.getParameter("givenName"));
    req.setAttribute("gender", req.getParameter("gender"));
    req.setAttribute("phone", req.getParameter("phone"));
    req.setAttribute("address", req.getParameter("address"));
  }
}
