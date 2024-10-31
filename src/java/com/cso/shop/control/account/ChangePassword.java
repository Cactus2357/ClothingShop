/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.account;

import com.cso.shop.dao.UserDAO;
import com.cso.shop.model.User;
import com.cso.shop.util.Utils;
import com.cso.shop.validator.Validator;
import java.io.IOException;
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
    if (session == null) {
      resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
      return;
    }
    User user = (User) session.getAttribute("user");
    String email = (String) session.getAttribute("email");

    try {
      if (email == null) {
        if (user.getPassword() != null) {
          validateChangePasswordRequest(req);
        }

        email = user.getEmail();
      }

      User clone = udao.selectByEmail(email);
      clone.setEmail(email);
      clone.setPassword(req.getParameter("newPassword"));
      udao.updatePassword(clone);

      session.invalidate();
      req.setAttribute("response", "Password updated successfully");
      req.setAttribute("responseType", true);

    } catch (Exception e) {
      req.setAttribute("response", e.getMessage());
      e.printStackTrace();
    }

//    req.setAttribute("sudoLogin", email);
    req.getRequestDispatcher("WEB-INF/signin.jsp").forward(req, resp);
//    resp.setHeader("refresh", "2;url=signin");
//    if (user != null) {
//      req.getRequestDispatcher("WEB-INF/profile.jsp").forward(req, resp);
//    } else {
//      req.getRequestDispatcher("WEB-INF/misc/form-reset-password.jsp").forward(req, resp);
//    }
  }

  private boolean validateChangePasswordRequest(HttpServletRequest req) throws Exception {
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

    var passwordValidator = Validator.isValidPassword(newPassword);
    if (!passwordValidator.isValid()) {
      throw new Exception(passwordValidator.getMessage());
    }

//    if (oldPassword.equals(newPassword)) {
//      throw new Exception("New password must be different to old password");
//    }
    if (!newPassword.equals(newPassword2)) {
      throw new Exception("Password confirm is not match");
    }

    return true;
  }

}
