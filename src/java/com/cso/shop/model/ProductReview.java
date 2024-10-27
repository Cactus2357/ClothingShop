/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.model;

import java.sql.Date;

/**
 *
 * @author hi
 */
public class ProductReview extends Review {

  private String userName;
  private String userAvatar;

  public ProductReview(String userName, String userAvatar) {
    this.userName = userName;
    this.userAvatar = userAvatar;
  }

  public ProductReview() {
  }

  public ProductReview(int reviewId, float rating, String comment, int productId, int userId, String userName, String userAvatar, Date createdAt, Date updatedAt, String status) {
    super(reviewId, rating, comment, productId, userId, createdAt, updatedAt, status);
    this.userName = userName;
    this.userAvatar = userAvatar;
  }

  public String getUserName() {
    return userName;
  }

  public void setUserName(String userName) {
    this.userName = userName;
  }

  public String getUserAvatar() {
    return userAvatar;
  }

  public void setUserAvatar(String userAvatar) {
    this.userAvatar = userAvatar;
  }

}
