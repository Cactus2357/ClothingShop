/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.validator;

/**
 *
 * @author hi
 */
public class Validator {

  public static ValidationResult isValidPassword(String password) {
    if (password == null) {
      return new ValidationResult(false, "password is missing.");
    }
    if (password.isEmpty()) {
      return new ValidationResult(false, "password is empty.");
    }
    if (password.length() < 8) {
      return new ValidationResult(false, "password must be at least 8 characters length.");
    }
    return new ValidationResult(true);
  }
}
