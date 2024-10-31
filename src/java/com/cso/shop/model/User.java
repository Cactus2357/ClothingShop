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

  private int userID;
  private String userName;
  private String password;
  private String email;
  private String phone;
  private String role = "customer";
  private String address;
  private String givenName;
  private String familyName;
  private String status = "active";
  private String avatar;
  private String gender = "male";
  private Date createdAt;

  public User() {
  }

  public User(int UserID, String UserName, String Password, String Email, String Phone, String Role, String Address, String GivenName, String FamilyName, String Status, String Avatar, String Gender, Date CreatedAt) {
    this.userID = UserID;
    this.userName = UserName;
    this.password = Password;
    this.email = Email;
    this.phone = Phone;
    this.role = Role;
    this.address = Address;
    this.givenName = GivenName;
    this.familyName = FamilyName;
    this.status = Status;
    this.avatar = Avatar;
    this.gender = Gender;
    this.createdAt = CreatedAt;
  }

  @Override
  public String toString() {
    return "User{" + "UserID=" + userID + ", UserName=" + userName + ", Password=" + password + ", Email=" + email + ", Phone=" + phone + ", Role=" + role + ", Address=" + address + ", GivenName=" + givenName + ", FamilyName=" + familyName + ", Status=" + status + ", Avatar=" + avatar + ", Gender=" + gender + ", CreatedAt=" + createdAt + '}';
  }

  public int getUserID() {
    return userID;
  }

  public void setUserID(int userID) {
    this.userID = userID;
  }

  public String getUserName() {
    return userName;
  }

  public void setUserName(String userName) {
    this.userName = userName;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getRole() {
    return role;
  }

  public void setRole(String role) {
    this.role = role;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public String getGivenName() {
    return givenName;
  }

  public void setGivenName(String givenName) {
    this.givenName = givenName;
  }

  public String getFamilyName() {
    return familyName;
  }

  public void setFamilyName(String familyName) {
    this.familyName = familyName;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getAvatar() {
    return avatar;
  }

  public void setAvatar(String avatar) {
    this.avatar = avatar;
  }

  public String getGender() {
    return gender;
  }

  public void setGender(String gender) {
    this.gender = gender;
  }

  public Date getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Date createdAt) {
    this.createdAt = createdAt;
  }

}
