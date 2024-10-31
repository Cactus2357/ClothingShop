/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.util;

import jakarta.servlet.http.Part;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.Provider;
import java.security.Provider.Service;
import java.security.SecureRandom;
import java.security.Security;
import java.time.LocalDateTime;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hi
 */
public class Utils {

  private static String webFilePath = "file\\";

  public static String getWebFilePath() {
    return webFilePath;
  }

  public static void setWebFilePath(String webFilePath) {
    Utils.webFilePath = webFilePath;

  }

  public static void main(String[] args) {
  }

  /**
   * Hash with SHA-256
   */
  public static String hash(String string) {
    return hash(string, "SHA-256");
  }

  public static String hash(String string, String algorithm) {
    if (string == null) {
      return null;
    }
    try {
      MessageDigest md = MessageDigest.getInstance(algorithm);

      byte[] hashBytes = md.digest(string.getBytes(StandardCharsets.UTF_8));

      StringBuilder hexString = new StringBuilder();
      for (int i = 0; i < hashBytes.length; i++) {
        hexString.append(Integer.toString((hashBytes[i] & 0xff) + 0x100, 16).substring(1));
      }

      return hexString.toString();
    } catch (Exception e) {
      System.err.println(e);
      return null;
    }
  }

  public static int tryParseInt(String value, int defaultVal) {
    try {
      return Integer.parseInt(value);
    } catch (NumberFormatException e) {
      return defaultVal;
    }
  }

  public static float tryParseFloat(String value, float defaultVal) {
    try {
      return Float.parseFloat(value);
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

  public static String generateToken(int length) {
    byte[] bytes = new byte[20];
    try {
      SecureRandom.getInstanceStrong().nextBytes(bytes);
      String token = bytesToHex(bytes);
      return token;
    } catch (NoSuchAlgorithmException ex) {
      Logger.getLogger(Utils.class.getName()).log(Level.SEVERE, null, ex);
      return null;
    }
  }

  private static final byte[] HEX_ARRAY = "0123456789ABCDEF".getBytes(StandardCharsets.US_ASCII);

  public static String bytesToHex(byte[] bytes) {
    byte[] hexChars = new byte[bytes.length * 2];
    for (int j = 0; j < bytes.length; j++) {
      int v = bytes[j] & 0xFF;
      hexChars[j * 2] = HEX_ARRAY[v >>> 4];
      hexChars[j * 2 + 1] = HEX_ARRAY[v & 0x0F];
    }
    return new String(hexChars, StandardCharsets.UTF_8);
  }

  /**
   * config webFilePath with <code>setWebFilePath(String webFilePath);</code>
   * default at "file/"
   *
   * @param part File part
   * @param location Physical location on disk
   * @return <b>webFilePath</b> +  <b>relative file path</b> relative to
   * <b>location</b>
   * @throws IOException
   */
  public static String writeFile(Part part, String location) throws IOException {
    if (part == null || location == null || location.isBlank()) {
      return null;
    }

    String name = part.getSubmittedFileName();
    int dotIndex = name.lastIndexOf('.');
    String contentType = part.getContentType();

    String ext = (dotIndex > 0)
      ? name.substring(dotIndex)
      : contentType.substring(contentType.lastIndexOf('/') + 1);

    String timestamp = LocalDateTime.now().toString();
    String fileName = hash(timestamp + name);

    File directory = new File(
      location,
      contentType.substring(0, contentType.lastIndexOf('/'))
    );
    if (!directory.exists()) {
      directory.mkdirs();
    }

    File file = File.createTempFile(fileName, ext, directory);
    try (InputStream is = part.getInputStream()) {
      Files.copy(is, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
    }

    return webFilePath + directory.getParentFile().toPath().relativize(file.toPath()).toString();
  }

  private static void getAlgorithms() {
    Provider[] providers = Security.getProviders();
    for (Provider p : providers) {
      String providerStr = String.format("%s/%s/%f\n", p.getName(),
        p.getInfo(), p.getVersion());
      Set<Service> services = p.getServices();
      for (Service s : services) {
        if ("MessageDigest".equals(s.getType())) {
          System.out.printf("\t%s/%s/%s\n", s.getType(),
            s.getAlgorithm(), s.getClassName());
        }
      }
    }
  }
}
