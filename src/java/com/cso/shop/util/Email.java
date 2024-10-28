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

  private static final String defaultMail = "se1864cso@gmail.com";
  private static final String defaultMailPass = "rsna flok golk btir";
  private static final String defaultContent = "Default mail content for testing";

  private static Properties properties = new Properties();

  static {
    try {
      properties.load(new FileInputStream("nbproject/private/private.properties"));
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
    Email.mail();
//    System.out.println(getEmail());
//    System.out.println(getEmailPassword());
  }

  public static void mail() {
    mail("Testing email", generateEmailContent("000000", defaultContent, "Testing send email"));
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
      msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
      msg.setSubject(subject);
      msg.setSentDate(new Date());
      msg.setReplyTo(InternetAddress.parse(from));
//      String emailContent
//        = """
//          <!DOCTYPE html>
//          <html lang="en">
//            <body>
//              <h2>Verify email</h2>
//              <p>Verification code : <b>%s</b></p>
//              <p><small><i>Code expires in 3 minutes.</i></small></p>
//            </body>
//          </html>
//        """;
      msg.setContent(content, "text/html");

      Transport.send(msg);
      System.out.println("Email sent successfully to " + to);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public static String generateEmailContent(String pinCode, String messageBody, String emailSubject) {
    String emailTemplate = """
      <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <title>%s</title>
          <style>body {font-family: Arial, sans-serif;background-color: #f4f4f4;margin: 0;padding: 0;}
            .container {max-width: 600px;margin: 20px auto;background-color: #fff;padding: 20px;border-radius: 8px;box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);text-align: center;}
            .header {background-color: #007bff;color: #fff;padding: 15px 0;border-radius: 8px 8px 0 0;font-size: 24px;}
            .content {padding: 20px;}
            .pin {font-size: 32px;font-weight: bold;color: #007bff;letter-spacing: 4px;margin: 20px 0;}
            .footer {font-size: 14px;color: #777;}
          </style>
        </head>
        <body>
          <div class="container">
            <div class="header">%s</div>
            <div class="content"><p>%s</p><div class="pin">%s</div><p><small>This code will expire in 10 minutes.</small></p></div>
            <div class="footer"><p>If you didn't request this, please ignore this email.</p></div>
          </div>
        </body>
      </html>""";

    return String.format(emailTemplate, emailSubject, emailSubject, messageBody, pinCode);
  }

}
