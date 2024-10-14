/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.model;

import java.sql.Date;

/**
 *
 * @author hi
 */
public class Product extends BaseBean {

  private int id;
  private String name;
  private String image;
  private String description;
  private int quantity;
  private double unitPrice;
  private double salePrice;
  private Date importDate;
  private Date updateDate;
  private String status;

  public Product() {
  }

  public Product(int id, String name, String image, String description, int quantity, double unitPrice, double salePrice, Date importDate, Date updateDate, String status) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.description = description;
    this.quantity = quantity;
    this.unitPrice = unitPrice;
    this.salePrice = salePrice;
    this.importDate = importDate;
    this.updateDate = updateDate;
    this.status = status;
  }

  @Override
  public String toString() {
    return "Product{" + "id=" + id + ", name=" + name + ", image=" + image + ", description=" + description + ", quantity=" + quantity + ", unitPrice=" + unitPrice + ", salePrice=" + salePrice + ", importDate=" + importDate + ", updateDate=" + updateDate + ", status=" + status + '}';
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getImage() {
    return image;
  }

  public void setImage(String image) {
    this.image = image;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public int getQuantity() {
    return quantity;
  }

  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }

  public double getUnitPrice() {
    return unitPrice;
  }

  public void setUnitPrice(double unitPrice) {
    this.unitPrice = unitPrice;
  }

  public double getSalePrice() {
    return salePrice;
  }

  public void setSalePrice(double salePrice) {
    this.salePrice = salePrice;
  }

  public Date getImportDate() {
    return importDate;
  }

  public void setImportDate(Date importDate) {
    this.importDate = importDate;
  }

  public Date getUpdateDate() {
    return updateDate;
  }

  public void setUpdateDate(Date updateDate) {
    this.updateDate = updateDate;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

}
