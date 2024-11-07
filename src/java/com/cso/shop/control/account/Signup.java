/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.account;

import com.cso.shop.dao.UserDAO;
import com.cso.shop.model.User;
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
public class Signup extends HttpServlet {

  private static final int OTP_EXPIRY_TIME = 3 * 60;
  private static final int SESSION_EXPIRY_TIME = 60 * 60;
  private static final int MAX_ATTEMPTS = 5;

  private static final UserDAO udao = UserDAO.getInstance();

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
    HttpSession session = req.getSession(false);
    String otp = req.getParameter("otp");

    if (session != null && otp != null
      && session.getAttribute("otp") != null
      && session.getAttribute("authUser") != null) {
      validateOtp(req, resp);
      return;
    }

    validateAndCreateUser(req, resp);
  }

  private void validateAndCreateUser(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    try {
      validateUserInput(req, resp);
      User tempUser = parseUser(req);

      if (isUserExist(tempUser)) {
        sendErrorAndRedirect(req, resp, "User already exists.");
      } else {
        sendOtp(req, resp, tempUser);
      }

    } catch (Exception e) {
      forwardUserInput(req);
      sendErrorAndRedirect(req, resp, e.getMessage());
    }
  }

  private boolean isUserExist(User user) throws SQLException {
    return udao.selectByName(user.getUserName()) != null || udao.selectByEmail(user.getEmail()) != null;
  }

  private void validateOtp(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    HttpSession session = req.getSession();
    String otpHash = (String) session.getAttribute("otp");
    String otp = req.getParameter("otp");

    Integer attempts = (Integer) session.getAttribute("otpAttempts");
    attempts = (attempts == null) ? 1 : attempts + 1;

    if (attempts >= MAX_ATTEMPTS) {
      session.invalidate();
      sendErrorAndRedirect(req, resp, "Maximum OTP attempts exceeded. Please sign up again.");
      return;
    }

    session.setAttribute("otpAttempts", attempts);

    if (otpHash.equals(Utils.hash(otp))) {
      session.removeAttribute("otpAttempts");
      createUserAccount(req, resp);
    } else {
      redirectVerifyForm(req, resp);
    }
  }

  private void createUserAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    try {
      HttpSession session = req.getSession();
      User user = (User) session.getAttribute("authUser");
      udao.insert(user);

      session.invalidate();
      session = req.getSession();
      session.setMaxInactiveInterval(SESSION_EXPIRY_TIME);
      session.setAttribute("user", user);

      resp.setHeader("refresh", "1.5;url=home");
      sendResponseAndRedirect(req, resp, "User sign up successfully. Redirecting...", true);

    } catch (SQLException e) {
      log("Error creating user account: " + e.getMessage());
      sendErrorAndRedirect(req, resp, "Internal server error. Please try again later.");
    }
  }

  private User parseUser(HttpServletRequest req) {
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
      throw new Exception("All fields are required.");
    }

    if (!name.matches("\\w{3,20}")) {
      throw new Exception("Username must be 3-20 characters long and can only contain alphanumeric characters and underscores.");
    }

    if (udao.selectByName(name) != null) {
      throw new Exception("Username is already taken");
    }

    if (password.length() < 8) {
      throw new Exception("Password must be at least 8 characters long.");
    }

    if (!password.equals(passwordCfm)) {
      throw new Exception("Password confirmation does not match.");
    }

    if (!(gender.equals("male") || gender.equals("female"))) {
      throw new Exception("Invalid gender selection.");
    }
    return true;
  }

  private void sendOtp(HttpServletRequest req, HttpServletResponse resp, User tempUser) throws ServletException, IOException {
    HttpSession session = req.getSession();
    String otp = new RandomString(6, new SecureRandom(), RandomString.digits).nextString();

    session.setAttribute("otp", Utils.hash(otp));
    session.setAttribute("authUser", tempUser);
    session.setMaxInactiveInterval(OTP_EXPIRY_TIME);

    Email.mail("Verify email", Email.verifyEmailContent(tempUser.getEmail(), otp), tempUser.getEmail());
    redirectVerifyForm(req, resp);
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

  private void redirectVerifyForm(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    HttpSession session = req.getSession();
    Integer attempt = (Integer) session.getAttribute("otpAttempts");
    if (attempt == null)
      attempt = 0;
//    session.setAttribute("otpAttempts", 0);

    req.setAttribute("otpExpiry", OTP_EXPIRY_TIME / 60);
    req.setAttribute("remainAttempts", MAX_ATTEMPTS - attempt);
    req.setAttribute("email", ((User) session.getAttribute("authUser")).getEmail());
    req.setAttribute("formDestination", "signup");

    req.getRequestDispatcher("WEB-INF/misc/form-verify-otp.jsp").forward(req, resp);
  }

  private void sendErrorAndRedirect(HttpServletRequest req, HttpServletResponse resp, String response) throws ServletException, IOException {
    sendResponseAndRedirect(req, resp, response, false);
  }

  private void sendResponseAndRedirect(HttpServletRequest req, HttpServletResponse resp, String response, boolean responseType) throws ServletException, IOException {
    req.setAttribute("response", response);
    req.setAttribute("responseType", responseType);
    req.getRequestDispatcher("WEB-INF/signup.jsp").forward(req, resp);
  }

}
