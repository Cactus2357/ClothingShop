/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.util;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Date;

/**
 *
 * @author hi
 */
public class Email {

  private static final String defaultMail = "se1864cso@gmail.com";
  private static final String defaultMailPass = "rsna flok golk btir";
  private static final String defaultContent = "Default mail content for testing";

  public static void main(String[] args) {
    Email.mail();
  }

  public static void mail() {
    mail(defaultContent);
  }

  public static void mail(String content) {
    mail(content, defaultMail);
  }

  public static void mail(String content, String to) {
    mail(content, to, defaultMail, defaultMailPass);
  }

  public static void mail(String content, String to, String from, String pass) {
    Properties prop = new Properties();
    prop.put("mail.smtp.host", "smtp.gmail.com");
    prop.put("mail.smtp.port", "587"); // TLS:587, SSL:465
    prop.put("mail.smtp.auth", true);
    prop.put("mail.smtp.starttls.enable", true);

    // Create authenticator
    Authenticator auth = new Authenticator() {
      @Override
      protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(from, pass);
      }
    };

    // Active session
    Session ses = Session.getInstance(prop, auth);

    // Send email
    MimeMessage msg = new MimeMessage(ses);

    try {
      msg.addHeader("content-type", "text/html; charset=UTF-8");
      msg.setFrom(from);
      msg.setRecipients(
        Message.RecipientType.TO,
        InternetAddress.parse(to, false)
      );
      msg.setSubject("Verify email address");
      msg.setSentDate(new Date());
      msg.setReplyTo(InternetAddress.parse(from, false));
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
      System.out.println("Email sent without exception");
    } catch (Exception e) {
      System.err.println(e);
    }
  }
}
