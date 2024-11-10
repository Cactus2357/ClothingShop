/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.account;

import com.cso.shop.dao.UserDAO;
import com.cso.shop.util.Email;
import com.cso.shop.util.RandomString;
import com.cso.shop.util.Utils;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.sql.SQLException;

/**
 *
 * @author hi
 */
public class ResetPassword extends HttpServlet {

  private final int SESSION_DURATION = 60 * 15; // 10 mins
  private final int OTP_EXPIRY_DURATION = 60 * 10; // 5 mins
  private final int RESEND_LIMIT_TIME = 60; // 1 mins

  private final int MAX_OTP_ATTEMPTS = 5;
  private final int MAX_RESEND_ATTEMPTS = 3;

  private UserDAO udao = UserDAO.getInstance();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
//    resp.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
//    return;
    HttpSession session = req.getSession(false);
    if (session != null && session.getAttribute("user") != null) {
      resp.sendError(HttpServletResponse.SC_NOT_FOUND);
      return;
    }

    req.getRequestDispatcher("WEB-INF/misc/form-send-email.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
//    resp.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
//    return;
    String email = req.getParameter("email");
    String otp = req.getParameter("otp");

//    String csrfToken = req.getParameter("csrfToken");
    boolean hasEmail = email != null && !email.isBlank();
    boolean hasOtp = otp != null && !otp.isBlank();

    if (!(hasEmail ^ hasOtp)) {
      if ("resendotp".equals(req.getParameter("type").toLowerCase())) {
        handleResendOtp(req, resp);
      } else {
        resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
      }
      return;
    }

    if (hasEmail) {
      handleEmailPost(req, resp);
    } else {
      handleVerifyOtpPost(req, resp);
    }
  }

  private void handleResendOtp(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    HttpSession session = req.getSession(false);

    if (session == null
      || session.getAttribute("email") == null
      || session.getAttribute("otp") == null) {
      resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Session expired or OTP not generated.");
      return;
    }

    long currentTime = System.currentTimeMillis();
    Long lastResendTime = (Long) session.getAttribute("lastResendTime");
    if (lastResendTime != null && currentTime - lastResendTime < RESEND_LIMIT_TIME * 1000) {
      resp.sendError(429, "Please wait before resending OTP.");
      return;
    }

    Integer resendAttemps = (Integer) session.getAttribute("resendAttemps");
    if (resendAttemps == null) {
      resendAttemps = 0;
    }

    if (resendAttemps >= MAX_RESEND_ATTEMPTS) {
      resp.sendError(429, "Resend limit reached.");
      return;
    }
    session.setAttribute("resendAttemps", resendAttemps + 1);

    String email = (String) session.getAttribute("email");
    sendNewOTP(email, session);

    session.setAttribute("lastResendTime", currentTime);
  }

  private void handleEmailPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    String email = req.getParameter("email");

    boolean emailExist = false;

    try {
      emailExist = udao.selectByEmail(email) != null;
    } catch (SQLException e) {
      e.printStackTrace();
      emailExist = false;
    }

    if (emailExist) {
      HttpSession session = req.getSession();
      sendNewOTP(email, session);
    } else {
      log("Password reset request submitted for non-existent email.");
    }

    req.setAttribute("remainAttempts", MAX_OTP_ATTEMPTS);
    req.setAttribute("email", maskEmail(email));
    req.setAttribute("otpExpiry", OTP_EXPIRY_DURATION / 60);
    req.getRequestDispatcher("WEB-INF/misc/form-verify-otp.jsp").forward(req, resp);
  }

  private void handleVerifyOtpPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    String otp = req.getParameter("otp");
    HttpSession session = req.getSession(false);

    if (session == null || session.getAttribute("otp") == null || session.getAttribute("email") == null) {
      resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Session expired or no OTP found.");
      return;
    }

    Integer attempts = (Integer) session.getAttribute("attempts");
    if (attempts == null) {
      attempts = 0;
    }
    attempts++;
    session.setAttribute("attempts", attempts);

    String sessionOtpHash = (String) session.getAttribute("otp");
    Long otpExpiryTime = (Long) session.getAttribute("otpExpiryTime");

    long currentTime = System.currentTimeMillis();
    if (otpExpiryTime == null || currentTime > otpExpiryTime) {
      resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "OTP has expired. Please request a new one.");
      return;
    }

    boolean isOtpValid = sessionOtpHash.equals(Utils.hash(otp));

    if (isOtpValid) {
      String email = (String) session.getAttribute("email");
      session.invalidate();

      HttpSession newSession = req.getSession(true);
      newSession.setAttribute("authEmail", email);
      newSession.setMaxInactiveInterval(60 * 3);
      req.setAttribute("authEmail", email);
      req.getRequestDispatcher("WEB-INF/misc/form-reset-password.jsp").forward(req, resp);
    } else {

      if (attempts >= MAX_OTP_ATTEMPTS) {
        resp.sendError(429, "Attempt limit reached.");
        return;
      }

      req.setAttribute("remainAttempts", MAX_OTP_ATTEMPTS - attempts);
      req.setAttribute("email", maskEmail((String) session.getAttribute("email")));
      req.setAttribute("otpExpiry", OTP_EXPIRY_DURATION / 60);
      req.getRequestDispatcher("WEB-INF/misc/form-verify-otp.jsp").forward(req, resp);

    }
  }

  private void sendNewOTP(String email, HttpSession session) {
    String otp = new RandomString(6, new SecureRandom(), RandomString.digits).nextString();

    long optExpiryTime = System.currentTimeMillis() + (OTP_EXPIRY_DURATION * 1000);

    session.setAttribute("email", email);
    session.setAttribute("otp", Utils.hash(otp));
    session.setAttribute("otpExpiryTime", optExpiryTime);

    // Send email OTP
    Email.mail("Change password", Email.changePasswordContent(email, otp), email);

    session.setMaxInactiveInterval(Math.min(SESSION_DURATION, OTP_EXPIRY_DURATION));
  }

  private String maskEmail(String email) {
    int atIndex = email.indexOf("@");
    if (atIndex == -1) {
      throw new IllegalArgumentException("Invalid email format");
    }

    String localPart = email.substring(0, atIndex);
    String domainPart = email.substring(atIndex);

    String visiblePart = localPart.length() > 3 ? localPart.substring(0, 3) : localPart;

    return visiblePart + "***" + domainPart;
  }

}
