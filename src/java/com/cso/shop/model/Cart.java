/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.model;

/**
 *
 * @author hi
 */
public class Cart {

  private int cartId;
  private int userId;
  private String status;

  public Cart() {
  }

  public Cart(int cartId, int userId, String status) {
    this.cartId = cartId;
    this.userId = userId;
    this.status = status;
  }

  @Override
  public String toString() {
    return "Cart{" + "cartId=" + cartId + ", userId=" + userId + ", status=" + status + '}';
  }

  public int getCartId() {
    return cartId;
  }

  public void setCartId(int cartId) {
    this.cartId = cartId;
  }

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

}
