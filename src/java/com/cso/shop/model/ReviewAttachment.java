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
public class ReviewAttachment {

  private int id;
  private int reviewId;
  private String attachment;
  private String description;
  private String type;
  private String status;
  private Date createdAt;
  private Date updatedAt;

  public ReviewAttachment() {
  }

  public ReviewAttachment(int id, int reviewId, String attachment, String description, String type, String status, Date createdAt, Date updatedAt) {
    this.id = id;
    this.reviewId = reviewId;
    this.attachment = attachment;
    this.description = description;
    this.type = type;
    this.status = status;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }

  @Override
  public String toString() {
    return "ReviewAttachment{" + "id=" + id + ", reviewId=" + reviewId + ", attachment=" + attachment + ", description=" + description + ", type=" + type + ", status=" + status + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getReviewId() {
    return reviewId;
  }

  public void setReviewId(int reviewId) {
    this.reviewId = reviewId;
  }

  public String getAttachment() {
    return attachment;
  }

  public void setAttachment(String attachment) {
    this.attachment = attachment;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
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

}
