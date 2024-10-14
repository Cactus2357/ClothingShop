/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.util;

import java.security.SecureRandom;
import java.util.Locale;
import java.util.Objects;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

/**
 *
 * @author hi
 */
public class RandomString {

  public static void main(String[] args) {
    RandomString gen = new RandomString(8, ThreadLocalRandom.current());
    RandomString session = new RandomString();
    String easy = RandomString.digits + RandomString.upper + RandomString.lower;
    RandomString tickets = new RandomString(23, new SecureRandom(), easy);

    RandomString custom = new RandomString(20);
    for (int i = 0; i < 10; i++) {
      String token = custom.toString();
      String hashedToken = Utils.hash(token);
      System.out.println(token.length() + ":" + token);
      System.out.println(hashedToken.length() + ":" + hashedToken);
    }
    System.out.println(gen);
    System.out.println(session);
    System.out.println(tickets);
  }

  /**
   * Generate a random string.
   */
  public String nextString() {
    for (int idx = 0; idx < buf.length; ++idx) {
      buf[idx] = symbols[random.nextInt(symbols.length)];
    }
    return new String(buf);
  }

  public static final String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  public static final String lower = upper.toLowerCase(Locale.ROOT);

  public static final String digits = "0123456789";

  public static final String alphanum = upper + lower + digits;

  private final Random random;

  private final char[] symbols;

  private final char[] buf;

  public RandomString(int length, Random random, String symbols) {
    if (length < 1) {
      throw new IllegalArgumentException();
    }
    if (symbols.length() < 2) {
      throw new IllegalArgumentException();
    }
    this.random = Objects.requireNonNull(random);
    this.symbols = symbols.toCharArray();
    this.buf = new char[length];
  }

  /**
   * Create an alphanumeric string generator.
   */
  public RandomString(int length, Random random) {
    this(length, random, alphanum);
  }

  /**
   * Create an alphanumeric strings from a secure generator.
   */
  public RandomString(int length) {
    this(length, new SecureRandom());
  }

  /**
   * Create session identifiers.
   */
  public RandomString() {
    this(21);
  }

  @Override
  public String toString() {
    return nextString();
  }

}
