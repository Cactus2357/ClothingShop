/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.model;

/**
 *
 * @author hi
 */
public class User {

  private int userId;
  private String name;
  private String fullName;
  private String avatar;
  private String email;
  private String password;
  private String phone;
  private String address;
  private boolean gender;
  private int roleId;
  private String status;

  public User() {
  }

  public User(int userId, String name, String fullName, String avatar, String email, String password, String phone, String address, boolean gender, int roleId, String status) {
    this.userId = userId;
    this.name = name;
    this.fullName = fullName;
    this.avatar = avatar;
    this.email = email;
    this.password = password;
    this.phone = phone;
    this.address = address;
    this.gender = gender;
    this.roleId = roleId;
    this.status = status;
  }

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getFullName() {
    return fullName;
  }

  public void setFullName(String fullName) {
    this.fullName = fullName;
  }

  public String getAvatar() {
    return avatar;
  }

  public void setAvatar(String avatar) {
    this.avatar = avatar;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public boolean getGender() {
    return gender;
  }

  public void setGender(boolean gender) {
    this.gender = gender;
  }

  public int getRoleId() {
    return roleId;
  }

  public void setRoleId(int roleId) {
    this.roleId = roleId;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  @Override
  public String toString() {
    return "User{" + "userId=" + userId + ", name=" + name + ", fullName=" + fullName + ", avatar=" + avatar + ", email=" + email + ", password=" + password + ", phone=" + phone + ", address=" + address + ", gender=" + gender + ", roleId=" + roleId + ", status=" + status + '}';
  }

}
