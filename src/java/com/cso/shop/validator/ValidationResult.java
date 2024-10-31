/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.validator;

/**
 *
 * @author hi
 */
public class ValidationResult {

  private boolean valid;
  private String message;

  public ValidationResult(boolean valid) {
    this.valid = valid;
  }

  public ValidationResult(boolean valid, String message) {
    this.valid = valid;
    this.message = message;
  }

  public boolean isValid() {
    return valid;
  }

  public void setValid(boolean valid) {
    this.valid = valid;
  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

}
