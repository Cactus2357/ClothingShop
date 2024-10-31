/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;
//import jakarta.activation.DataSource;
//import jakarta.activation.DataHandler;

import java.io.FileInputStream;
import java.util.Date;

/**
 * tutorial: https://www.youtube.com/watch?v=lVJvbo8Ssqw
 *
 * @author hi
 */
public class Email {

  private static String propertiesPath = "D:\\Code\\Apache NetBeans\\OnlineClothingShop\\OnlineClothingShop\\nbproject\\private\\private.properties";
  public static String siteLink = "";

  private static final String defaultMail = "se1864cso@gmail.com";
  private static final String defaultMailPass = "rsna flok golk btir";
  private static final String defaultContent = "Default mail content for testing";

  private static Properties properties = new Properties();

  static {
    try {
      properties.load(new FileInputStream(propertiesPath));
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  private static String getEmail() {
    return properties.getProperty("application.mail", defaultMail);
  }

  private static String getEmailPassword() {
    return properties.getProperty("application.mail.pass", defaultMailPass);
  }

  public static void main(String[] args) {
    Email.mail("Email verification code: 513463", verifyEmailContent(getEmail(), "513463"));
//    Email.mail("Change password", changePasswordContent(getEmail(), "513463"));

//    System.out.println(getEmail());
//    System.out.println(getEmailPassword());
  }

  public static void mail() {
    mail("Testing email", "Testing sending email feature");
  }

  public static void mail(String subject, String content) {
    mail(subject, content, getEmail());
  }

  public static void mail(String subject, String content, String to) {
    mail(subject, content, to, getEmail(), getEmailPassword());
  }

  private static void mail(String subject, String content, String to, String from, String pass) {
    Properties prop = new Properties();
    prop.put("mail.smtp.auth", "true");
    prop.put("mail.smtp.starttls.enable", "true");
    prop.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
    prop.put("mail.smtp.port", "587"); // TLS:587, SSL:465

    // Create authenticator
    Authenticator auth = new Authenticator() {
      @Override
      protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(from, pass);
      }
    };

    // Active session
    Session ses = Session.getInstance(prop, auth);

    try {
      // Send email
      MimeMessage msg = new MimeMessage(ses);
      msg.addHeader("content-type", "text/html; charset=UTF-8");
      msg.setFrom(from);
      msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
      msg.setSubject(subject);
      msg.setSentDate(new Date());
      msg.setReplyTo(InternetAddress.parse(from, false));
      msg.setContent(content, "text/html");

      Transport.send(msg);
      System.out.println("Email sent successfully to " + to);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public static String verifyEmailContent(String email, String pin) {
    return verifyEmailContent(email, pin, null, null);
  }

  public static String verifyEmailContent(String email, String pin, String site, String redirect) {
    String siteLink = site != null ? site : "#";
    String redirectLink = redirect != null ? " <a href=\"%s\">here</a>".formatted(redirect) : "";

    String content = """
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="UTF-8" />
          <title>Email verification code: %s</title>
          <style>* {margin: 0;padding: 0;box-sizing: border-box;}body {font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;}a {text-decoration: none;}.container {margin: auto;max-width: 600px;border: 2px solid lightgray;border-radius: 0.375rem;padding: 3rem;}h1 {font-size: 2.5rem;margin-bottom: 1rem;}h4 {font-size: 1.5rem;margin-bottom: 0.5rem;}h1,h4 {font-weight: 500;text-align: center;}hr {margin: 1.5rem 0;}p {margin-bottom: 1rem;color: #495057;}</style>
        </head>
        <body>
          <div class="container" style="max-width: 600px">
            <h4><a href="%s">CSO</a></h4>
            <h4>Verify your email address</h4><hr />
            <p>CSO has recieved a request to use <b>%s</b> as verified email for an account.</p>
            <p>Use this code to finish verifying your account%s.</p>
            <h1>%s</h1>
            <p>This code will expire in 60 mins.</p>
            <p>If you don't recognize this, you can safely ignore this email.</p>
          </div>
        </body>
      </html>""".formatted(pin, siteLink, email, redirectLink, pin);
    return content;
  }

  public static String changePasswordContent(String email, String pin) {
    return changePasswordContent(email, pin, null, null);
  }

  public static String changePasswordContent(String email, String pin, String site, String redirect) {
    String siteLink = site != null ? site : "#";
    String redirectLink = redirect != null ? " <a href=\"%s\">here</a>".formatted(redirect) : "";

    String content = """
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="UTF-8" />
          <title>Password Reset</title>
          <style>* {margin: 0;padding: 0;box-sizing: border-box;}body {font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;}a {text-decoration: none;}.container {margin: auto;max-width: 600px;border: 2px solid lightgray;border-radius: 0.375rem;padding: 3rem;}h1 {font-size: 2.5rem;margin-bottom: 1rem;}h4 {font-size: 1.5rem;margin-bottom: 0.5rem;}h1,h4 {font-weight: 500;text-align: center;}hr {margin: 1.5rem 0;}p {margin-bottom: 1rem;color: #495057;}</style>
        </head>
        <body>
          <div class="container" style="max-width: 600px">
            <h4><a href="%s">CSO</a></h4>
            <h4>Reset Your Password</h4><hr />
            <p>CSO has received a request to reset password for the account associated with <b>%s</b>.</p>
            <p>Use this code to to verify your action%s.</p>
            <h1>%s</h1>
            <p>If you don't recognize this, you can safely ignore this email.</p>
          </div>
        </body>
      </html>""".formatted(siteLink, email, redirectLink, pin);

    return content;
  }

}
