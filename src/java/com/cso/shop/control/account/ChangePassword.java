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

/**
 *
 * @author hi
 */
public class ChangePassword extends HttpServlet {

  private UserDAO udao = UserDAO.getInstance();

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
      validate2ndForm(req);
      User u = (User) session.getAttribute("user");
      User clone = new User();
      clone.setUserID(u.getUserID());
      clone.setPassword(req.getParameter("newPassword"));
      udao.updatePassword(clone);

      req.setAttribute("response", "Password updated successfully");
      req.setAttribute("responseType", true);
    } catch (Exception e) {
      req.setAttribute("response", e.getMessage());
    }

    req.getRequestDispatcher("profile").forward(req, resp);

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

}
