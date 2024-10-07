/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.util;

import java.io.ByteArrayInputStream;
import java.security.MessageDigest;

/**
 *
 * @author hi
 */
public class Utils {

  /**
   * Hash with SHA-256
   */
  public static String hash(String string) {
    try {
      MessageDigest md = MessageDigest.getInstance("SHA-256");
      ByteArrayInputStream fis = new ByteArrayInputStream(string.getBytes());

      byte[] dataBytes = new byte[1024];

      int nread = 0;
      while ((nread = fis.read(dataBytes)) != -1) {
        md.update(dataBytes, 0, nread);
      };
      byte[] mdbytes = md.digest();

      //convert the byte to hex format method 1
      StringBuffer sb = new StringBuffer();
      for (int i = 0; i < mdbytes.length; i++) {
        sb.append(Integer.toString((mdbytes[i] & 0xff) + 0x100, 16).substring(1));
      }
//    System.out.println("Hex format : " + sb.toString());
//convert the byte to hex format method 2
//    StringBuffer hexString = new StringBuffer();
//    for (int i = 0; i < mdbytes.length; i++) {
//      hexString.append(Integer.toHexString(0xFF & mdbytes[i]));
//    }
//    System.out.println("Hex format : " + hexString.toString());
      return sb.toString();
    } catch (Exception e) {
      System.err.println(e);
      return string;
    }
  }

  public static int tryParseInt(String value, int defaultVal) {
    try {
      return Integer.parseInt(value);
    } catch (NumberFormatException e) {
      return defaultVal;
    }
  }

  public static double tryParseDouble(String value, double defaultVal) {
    try {
      return Double.parseDouble(value);
    } catch (NumberFormatException e) {
      return defaultVal;
    }
  }
}
