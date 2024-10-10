/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.account;

import com.cso.shop.dao.UserDAO;
import com.cso.shop.model.User;
import com.cso.shop.util.Utils;
import java.io.IOException;
import java.io.PrintWriter;
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
public class Profile extends HttpServlet {

  private UserDAO udao = new UserDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    HttpSession session = req.getSession(false);
    if (session == null || session.getAttribute("user") == null) {
      try (PrintWriter out = resp.getWriter()) {
        out.println("User not sign in.");
        resp.setHeader("refresh", "1.5;url=signin");
      }
      return;
    }

    req.getRequestDispatcher("WEB-INF/profile.jsp").forward(req, resp);

  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    HttpSession session = req.getSession(false);
    if (session == null || session.getAttribute("user") == null) {
      try (PrintWriter out = resp.getWriter()) {
        out.println("User not sign in.");
        resp.setHeader("refresh", "1.5;url=signin");
      }
      return;
    }

    try {
      validateUserInput(req, resp);

      User user = (User) session.getAttribute("user");
      user.setUserName(req.getParameter("username"));
      user.setFamilyName(req.getParameter("familyName"));
      user.setGivenName(req.getParameter("givenName"));
      user.setGender(req.getParameter("gender"));
      user.setPhone(req.getParameter("phone"));
      user.setAddress(req.getParameter("address"));

      udao.update(user);
      session.setAttribute("user", user);
      req.setAttribute("response", "Update successfully");
      req.setAttribute("responseType", true);
    } catch (Exception e) {
      req.setAttribute("response", e.getMessage());
    }

    doGet(req, resp);

  }

  @Override
  protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    HttpSession session = req.getSession(false);
    if (session == null || session.getAttribute("user") == null) {
      try (PrintWriter out = resp.getWriter()) {
        out.println("User not sign in.");
        resp.setHeader("refresh", "1.5;url=signin");
      }
      return;
    }

    try {
      validate2ndForm(req);
      User u = (User) session.getAttribute("user");
      User temp = new User();
      temp.setUserID(u.getUserID());
      temp.setPassword(req.getParameter("newPassword"));
      udao.updatePassword(temp);
      req.setAttribute("response", "Password updated successfully");
      req.setAttribute("responseType", true);

    } catch (Exception e) {
      req.setAttribute("response", e.getMessage());
    }

    doGet(req, resp);
  }

  private boolean validate2ndForm(HttpServletRequest req) throws Exception {
    String oldPassword = req.getParameter("oldPassword");
    String newPassword = req.getParameter("newPassword");
    String newPassword2 = req.getParameter("newPassword2");
    if (oldPassword == null || newPassword == null || newPassword2 == null) {
      throw new Exception("user input missing");
    }
    HttpSession session = req.getSession(false);
    User user = (User) session.getAttribute("user");

    if (user.getPassword() == null) {
      throw new Exception("Account have not enabled password authentication.");
    }

    if (!user.getPassword().equals(Utils.hash(oldPassword))) {
      throw new Exception("Old password is incorrect");
    }

    if (oldPassword.equals(newPassword)) {
      throw new Exception("New password must be different to old password");
    }

    if (!newPassword.equals(newPassword2)) {
      throw new Exception("Password confirm is not match");
    }

    return true;
  }

  private boolean validateUserInput(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, Exception {
    String name = req.getParameter("username");
    String familyName = req.getParameter("familyName");
    String givenName = req.getParameter("givenName");
    String gender = req.getParameter("gender");
    String phone = req.getParameter("phone");
    String address = req.getParameter("address");

    if (name == null || givenName == null || gender == null || phone == null || address == null) {
      throw new Exception("user input missing");
    }

    if (!name.matches("\\w{3,20}")) {
      throw new Exception("invalid username. can only contain alphanumeric & underscore, between 3 and 20 characters.");
    }

    if (udao.selectByName(name) != null) {
      throw new Exception("username already taken");
    }

    if (!(gender.equals("male") || gender.equals("female"))) {
      throw new Exception("invalid gender");
    }

    return true;
  }

}
