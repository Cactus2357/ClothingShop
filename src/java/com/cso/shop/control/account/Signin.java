/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.account;

import com.cso.shop.dao.UserDAO;
import com.cso.shop.model.User;
import com.cso.shop.model.UserGoogle;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;

/**
 *
 * @author hi
 */
public class Signin extends HttpServlet {

  private static String GOOGLE_MANAGER = "https://console.cloud.google.com/apis/credentials/consent?authuser=1&organizationId=0&project=swp-cso";

  private static String propertiesPath = "D:\\Code\\Apache NetBeans\\OnlineClothingShop\\OnlineClothingShop\\nbproject\\private\\private.properties";
  private static String GOOGLE_SIGNIN_LINK = "https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=%s&client_id=%s&response_type=code&approval_prompt=force";
  private static Properties properties = new Properties();

  private UserDAO udao = UserDAO.getInstance();

  static {
    try {
      properties.load(new FileInputStream(propertiesPath));
      GOOGLE_SIGNIN_LINK = GOOGLE_SIGNIN_LINK.formatted(
        properties.getProperty("google.redirect_uri"),
        properties.getProperty("google.client.id")
      );
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    HttpSession session = req.getSession(false);
    if (session != null && session.getAttribute("user") != null) {
      resp.sendRedirect("profile");
      return;
    }

    String method = req.getParameter("method");
    if ("google".equals(method)) {
      signinGoogle(req, resp);
      return;
    }

    req.getRequestDispatcher("WEB-INF/signin.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    try {
      validateUserInput(req);

    } catch (Exception e) {
      req.setAttribute("sudoLogin", req.getParameter("sudoLogin"));
      req.setAttribute("response", e.getMessage());
      req.getRequestDispatcher("WEB-INF/signin.jsp").forward(req, resp);
      return;

    }

    try {
      String sudoLogin = req.getParameter("sudoLogin");
      String password = req.getParameter("password");
      String remember = req.getParameter("rememberMe");
      String redirectURL = req.getParameter("redirect");
      if (redirectURL == null) {
        redirectURL = "home";
      }

      User user = udao.authenticate(sudoLogin, password);
      if (user == null) {
        throw new Exception("Email/password is incorrect or your account does not have password authentication enabled");
      }

      if (remember != null) {
        rememberUser(req, resp, user);
      }

      req.getSession().setAttribute("user", user);

      resp.setHeader("refresh", "1.5;url=" + redirectURL);
      req.setAttribute("response", "Sign in successfully. Redirecting...");
      req.setAttribute("responseType", true);

    } catch (Exception e) {
      req.setAttribute("response", e.getMessage());

    }
    req.getRequestDispatcher("WEB-INF/signin.jsp").forward(req, resp);
  }

  private void signinGoogle(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    String code = req.getParameter("code");
    String error = req.getParameter("error");

    if (code == null && error == null) {
      resp.sendRedirect(GOOGLE_SIGNIN_LINK);
      return;
    }

    if (error != null && error.equals("access_denied")) {
      resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Access denied");
      return;
    }

    if (code == null || code.isBlank()) {
      resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Authorization code is missing");
      return;
    }

    try {
      String accessToken = getToken(code);
      UserGoogle userGoogle = getUserInfo(accessToken);

      User user = null;
      user = udao.selectByEmail(userGoogle.getEmail());

      if (user == null) {
        user = new User();
        user.setUserName(udao.generateUniqueUsername(udao.reduceUsername(userGoogle.getName())));
        user.setEmail(userGoogle.getEmail());
        user.setFamilyName(userGoogle.getFamily_name());
        user.setGivenName(userGoogle.getGiven_name());
        user.setAvatar(userGoogle.getPicture());
        udao.insert(user);
      }
      HttpSession session = req.getSession();
      session.setAttribute("user", user);
      log("User authenticated from Google");

//      System.out.println(userGoogle);
      rememberUser(req, resp, user);

      String redirectURL = req.getParameter("redirect");
      if (redirectURL == null) {
        redirectURL = "home";
      }
      resp.setHeader("refresh", "1.5;url=" + redirectURL);
      req.setAttribute("response", "Sign in successfully. Redirecting...");
      req.setAttribute("responseType", true);
    } catch (Exception e) {
      e.printStackTrace();
      req.setAttribute("response", "Sign in encountered error.");
//      resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
//      return;
    }

    req.getRequestDispatcher("WEB-INF/signin.jsp").forward(req, resp);
  }

  public static String getToken(final String code) throws ClientProtocolException, IOException {
    String response = Request.Post(properties.getProperty("google.link.get_token"))
      .bodyForm(Form.form()
        .add("client_id", properties.getProperty("google.client.id"))
        .add("client_secret", properties.getProperty("google.client.secret"))
        .add("redirect_uri", properties.getProperty("google.redirect_uri"))
        .add("grant_type", properties.getProperty("google.grant_type"))
        .add("code", code).build())
      .execute().returnContent().asString();

    JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
    String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");

    return accessToken;
  }

  public static UserGoogle getUserInfo(final String accessToken) throws ClientProtocolException, IOException {

    String link = properties.getProperty("google.link.get_user_info") + accessToken;
    String response = Request.Get(link).execute().returnContent().asString();
    UserGoogle googlePojo = null;
    googlePojo = new Gson().fromJson(response, UserGoogle.class);
    return googlePojo;
  }

  private void rememberUser(HttpServletRequest req, HttpServletResponse resp, User user) throws Exception {
    req.setAttribute("rememberMe", true);
    try {
      String authToken = udao.createAuthToken(user.getUserID());
      int tokenExpiry = 60 * 60 * 24 * 30; // 30 days
      Cookie authTokenCookie = new Cookie("rememberme", authToken);
      authTokenCookie.setMaxAge(tokenExpiry);
      authTokenCookie.setHttpOnly(true);
      authTokenCookie.setSecure(true);
      authTokenCookie.setPath("/");

      resp.addCookie(authTokenCookie);

    } catch (SQLException e) {
      throw new Exception("Persistent user sign in encountered a problem.", e);
    }
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
