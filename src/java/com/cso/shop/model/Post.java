/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.model;

/**
 *
 * @author ADMIN
 */
public class Post {
    private int id;
    private int userId;
    private String image;
    private int categoryId;
    private String briefInfo;
    private String description;
    private String status;
    private String updateAt;

    public Post(int id, int userId, String image, int categoryId, String briefInfo, String description, String status, String updateAt) {
        this.id = id;
        this.userId = userId;
        this.image = image;
        this.categoryId = categoryId;
        this.briefInfo = briefInfo;
        this.description = description;
        this.status = status;
        this.updateAt = updateAt;
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getImage() {
        return image;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getBriefInfo() {
        return briefInfo;
    }

    public String getDescription() {
        return description;
    }

    public String getStatus() {
        return status;
    }

    public String getUpdateAt() {
        return updateAt;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setBriefInfo(String briefInfo) {
        this.briefInfo = briefInfo;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setUpdateAt(String updateAt) {
        this.updateAt = updateAt;
    }
    
    
}


