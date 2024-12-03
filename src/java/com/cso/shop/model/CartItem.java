/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.model;

/**
 *
 * @author hi
 */
public class CartItem {

  private int cartItemId;
  private int cartId;
  private int productId;
  private int quantity;
  private String status;

  public CartItem() {
  }

  public CartItem(int cartItemId, int cartId, int productId, int quantity, String status) {
    this.cartItemId = cartItemId;
    this.cartId = cartId;
    this.productId = productId;
    this.quantity = quantity;
    this.status = status;
  }

  @Override
  public String toString() {
    return "CartItem{" + "cartItemId=" + cartItemId + ", cartId=" + cartId + ", productId=" + productId + ", quantity=" + quantity + ", status=" + status + '}';
  }

  public int getCartItemId() {
    return cartItemId;
  }

  public void setCartItemId(int cartItemId) {
    this.cartItemId = cartItemId;
  }

  public int getCartId() {
    return cartId;
  }

  public void setCartId(int cartId) {
    this.cartId = cartId;
  }

  public int getProductId() {
    return productId;
  }

  public void setProductId(int productId) {
    this.productId = productId;
  }

  public int getQuantity() {
    return quantity;
  }

  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

}
