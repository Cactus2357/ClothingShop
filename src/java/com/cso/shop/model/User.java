/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.model;

import java.util.Date;

/**
 *
 * @author hi
 */
public class User extends BaseBean {

  private int UserID;
  private String UserName;
  private String Password;
  private String Email;
  private String Phone;
  private String Role = "customer";
  private String Address;
  private String GivenName;
  private String FamilyName;
  private String Status = "active";
  private String Avatar;
  private String Gender;
  private Date CreatedAt;

  public User() {
  }

  public User(int UserID, String UserName, String Password, String Email, String Phone, String Role, String Address, String GivenName, String FamilyName, String Status, String Avatar, String Gender, Date CreatedAt) {
    this.UserID = UserID;
    this.UserName = UserName;
    this.Password = Password;
    this.Email = Email;
    this.Phone = Phone;
    this.Role = Role;
    this.Address = Address;
    this.GivenName = GivenName;
    this.FamilyName = FamilyName;
    this.Status = Status;
    this.Avatar = Avatar;
    this.Gender = Gender;
    this.CreatedAt = CreatedAt;
  }

  @Override
  public String toString() {
    return "User{" + "UserID=" + UserID + ", UserName=" + UserName + ", Password=" + Password + ", Email=" + Email + ", Phone=" + Phone + ", Role=" + Role + ", Address=" + Address + ", GivenName=" + GivenName + ", FamilyName=" + FamilyName + ", Status=" + Status + ", Avatar=" + Avatar + ", Gender=" + Gender + ", CreatedAt=" + CreatedAt + '}';
  }

  public int getUserID() {
    return UserID;
  }

  public void setUserID(int UserID) {
    this.UserID = UserID;
  }

  public String getUserName() {
    return UserName;
  }

  public void setUserName(String UserName) {
    this.UserName = UserName;
  }

  public String getPassword() {
    return Password;
  }

  public void setPassword(String Password) {
    this.Password = Password;
  }

  public String getEmail() {
    return Email;
  }

  public void setEmail(String Email) {
    this.Email = Email;
  }

  public String getPhone() {
    return Phone;
  }

  public void setPhone(String Phone) {
    this.Phone = Phone;
  }

  public String getRole() {
    return Role;
  }

  public void setRole(String Role) {
    this.Role = Role;
  }

  public String getAddress() {
    return Address;
  }

  public void setAddress(String Address) {
    this.Address = Address;
  }

  public String getGivenName() {
    return GivenName;
  }

  public void setGivenName(String GivenName) {
    this.GivenName = GivenName;
  }

  public String getFamilyName() {
    return FamilyName;
  }

  public void setFamilyName(String FamilyName) {
    this.FamilyName = FamilyName;
  }

  public String getStatus() {
    return Status;
  }

  public void setStatus(String Status) {
    this.Status = Status;
  }

  public String getAvatar() {
    return Avatar;
  }

  public void setAvatar(String Avatar) {
    this.Avatar = Avatar;
  }

  public String getGender() {
    return Gender;
  }

  public void setGender(String Gender) {
    this.Gender = Gender;
  }

  public Date getCreatedAt() {
    return CreatedAt;
  }

  public void setCreatedAt(Date CreatedAt) {
    this.CreatedAt = CreatedAt;
  }

}
