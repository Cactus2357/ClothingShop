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
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author hi
 */
public class Signout extends HttpServlet {

  private static final String defaultPage = "home";

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {

    signout(req, resp);

    resp.setHeader("refresh", "1.5;url=" + defaultPage);
  }

  private void signout(HttpServletRequest req, HttpServletResponse resp) {
    Cookie authTokenCookie = new Cookie("rememberme", null);
    authTokenCookie.setMaxAge(0);
    authTokenCookie.setHttpOnly(true);
    authTokenCookie.setSecure(true);
    authTokenCookie.setPath("/");
    resp.addCookie(authTokenCookie);

    HttpSession session = req.getSession(false);
    if (session == null) {
      return;
    }

    User user = (User) session.getAttribute("user");
    String authToken = (String) session.getAttribute("authToken");

    if (user == null || authToken == null) {
      session.invalidate();
      return;
    }

    int userId = user.getUserID();
    int authTokenId = Utils.tryParseInt(authToken.split(":")[0], -1);

    UserDAO udao = UserDAO.getInstance();
    if (authTokenId != -1) {
      udao.invalidateUserToken(userId, authTokenId);
    }

    session.invalidate();
  }

}
