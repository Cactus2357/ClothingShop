/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.account;

import com.cso.shop.model.User;
import com.cso.shop.util.Utils;
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
public class AuthOtpServlet extends HttpServlet {

  private final int MAX_OTP_ATTEMPTS = 5;
  private final int OTP_EXPIRY_DURATION = 60 * 10; // 10 mins

  /**
   * session: - otp (hash) - email - redirect
   *
   * @param req
   * @param resp
   * @throws ServletException
   * @throws IOException
   */
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    String otp = req.getParameter("otp");
    HttpSession session = req.getSession(false);

    if (session != null || session.getAttribute("otp") == null || session.getAttribute("email") == null) {
      resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Session expired or no OTP provided");
      return;
    }

    Integer attempts = (Integer) session.getAttribute("attempts");
    attempts = (attempts == null) ? 0 : attempts + 1;
    session.setAttribute("attempts", attempts);

    String sessionOtpHash = (String) session.getAttribute("otp");
    Long otpExpiryTime = (Long) session.getAttribute("otpExpiryTime");
    long currentTime = System.currentTimeMillis();

    if (otpExpiryTime == null || currentTime > otpExpiryTime) {
      resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Otp has expired. Please request a new one");
      return;
    }

    boolean isOtpValid = sessionOtpHash.equals(Utils.hash(otp));

    if (!isOtpValid) {
      User user = (User) session.getAttribute("authUser");
      if (attempts >= MAX_OTP_ATTEMPTS) {
        resp.sendError(429, "Attempts limit reached.");
        return;
      }

      req.setAttribute("remainAttempts", MAX_OTP_ATTEMPTS - attempts);
      req.setAttribute("email", maskEmail((String) session.getAttribute("email")));
      req.setAttribute("otpExpiry", OTP_EXPIRY_DURATION / 60);
      req.getRequestDispatcher("WEB-INF/misc/form-verify-otp.jsp").forward(req, resp);
      return;
    }

    String email = (String) session.getAttribute("email");
    String redirect = (String) session.getAttribute("redirect");

    session = req.getSession(true);
    session.setAttribute("authEmail", email);
    session.setMaxInactiveInterval(60 * 3);
    req.setAttribute("authEmail", email);

    session.removeAttribute("attempts");
    session.removeAttribute("otpExpiryTime");

    switch (redirect) {
      case "/signup" -> {
        resp.sendRedirect("/signup");
      }
      case "/reset-password" ->
        req.getRequestDispatcher("WEB-INF/misc/form-reset-password.jsp").forward(req, resp);
      default ->
        resp.sendRedirect(req.getContextPath() + "/home");
    }
  }

  @Override
  public String getServletInfo() {
    return "Authenticate user";
  }

  private String maskEmail(String email) {
    int atIndex = email.indexOf("@");
    if (atIndex == -1) {
      throw new IllegalArgumentException("Invalid email format");
    }

    String localPart = email.substring(0, atIndex);
    String domainPart = email.substring(atIndex);
    String visiblePart = localPart.length() > 3 ? localPart.substring(0, 3) : localPart;

    return visiblePart + "***";
  }

}
