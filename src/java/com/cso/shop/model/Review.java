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
public class Review extends BaseBean {

  private int reviewId;
  private float rating;
  private String comment;
  private int productId;
  private int userId;
  private Date createdAt;
  private Date updatedAt;
  private String status;

  public Review() {
  }

  public Review(int reviewId, float rating, String comment, int productId, int userId, Date createdAt, Date updatedAt, String status) {
    this.reviewId = reviewId;
    this.rating = rating;
    this.comment = comment;
    this.productId = productId;
    this.userId = userId;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.status = status;
  }

  @Override
  public String toString() {
    return "Review{" + "reviewId=" + reviewId + ", rating=" + rating + ", comment=" + comment + ", productId=" + productId + ", userId=" + userId + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", status=" + status + '}';
  }

  public int getReviewId() {
    return reviewId;
  }

  public void setReviewId(int reviewId) {
    this.reviewId = reviewId;
  }

  public float getRating() {
    return rating;
  }

  public void setRating(float rating) {
    this.rating = rating;
  }

  public String getComment() {
    return comment;
  }

  public void setComment(String comment) {
    this.comment = comment;
  }

  public int getProductId() {
    return productId;
  }

  public void setProductId(int productId) {
    this.productId = productId;
  }

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  public Date getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Date createdAt) {
    this.createdAt = createdAt;
  }

  public Date getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(Date updatedAt) {
    this.updatedAt = updatedAt;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

}
