/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.dao;

import com.cso.shop.model.User;
import com.cso.shop.util.Utils;
import java.sql.SQLException;
import java.sql.*;

import java.util.List;

/**
 *
 * @author hi
 */
public class UserDAO extends BaseDAO<User> {

  private String SQL_INSERT = "INSERT INTO " + TABLE
    + " (UserName, Password, Email, Phone, Role, Address, GivenName, FamilyName, Status, Avatar, Gender)"
    + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

  private String SQL_SELECT = "SELECT * FROM " + TABLE + " WHERE UserID=?";

  private String SQL_UPDATE = "UPDATE " + TABLE
    + " SET UserName=?, Phone=?, Address=?, GivenName=?, FamilyName=?, Gender=?"
    + " WHERE UserID=?";

  private String SQL_DELETE = "DELETE FROM " + TABLE
    + " WHERE UserID=?";

  public UserDAO() {
    super("User");
  }

  public static void main(String[] args) {
    try {
      UserDAO udao = new UserDAO();
      User user = new User(
        0, // UserID (0 for auto-increment)
        "haha", // UserName
        "haha", // Password
        "user@email.com", // Email
        "12345678", // Phone
        "customer", // Role
        "123 Street", // Address
        "John", // GivenName
        "Doe", // FamilyName
        "active", // Status
        "avatar_url", // Avatar
        "male", // Gender
        null
      );
      udao.insert(user);
      System.out.println(user);

    } catch (Exception e) {
      System.err.println(e);
    }
  }

  private User parse(ResultSet rs) {
    try {
      return new User(
        rs.getInt("UserID"),
        rs.getString("UserName"),
        rs.getString("Password"),
        rs.getString("Email"),
        rs.getString("Phone"),
        rs.getString("Role"),
        rs.getString("Address"),
        rs.getNString("GivenName"),
        rs.getNString("FamilyName"),
        rs.getString("Status"),
        rs.getString("Avatar"),
        rs.getString("Gender"),
        rs.getDate("CreatedAt")
      );
    } catch (Exception e) {
      return null;
    }
  }

  @Override
  public User select(User t) throws SQLException {
    try (PreparedStatement ps = connection.prepareStatement(SQL_SELECT)) {
      ps.setInt(1, t.getUserID());
      ResultSet rs = ps.executeQuery();
      if (rs.next()) {
        return parse(rs);
      } else {
        return null;
      }
    }
  }

  @Override
  public void insert(User t) throws SQLException {
    try (PreparedStatement ps = connection.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS);) {
      String hashedPassword = Utils.hash(t.getPassword());
      ps.setString(1, t.getUserName());
      ps.setString(2, hashedPassword);
      ps.setString(3, t.getEmail());
      ps.setString(4, t.getPhone());
      ps.setString(5, t.getRole());
      ps.setString(6, t.getAddress());
      ps.setNString(7, t.getGivenName());
      ps.setNString(8, t.getFamilyName());
      ps.setString(9, t.getStatus());
      ps.setString(10, t.getAvatar());
      ps.setString(11, t.getGender());

      int affectedRows = ps.executeUpdate();

      if (affectedRows == 0) {
        throw new SQLException("Creating user failed, no rows affected");
      }

      try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
        if (generatedKeys.next()) {
          t.setUserID(generatedKeys.getInt(1));
          t.setPassword(hashedPassword);
        } else {
          throw new SQLException("Creating user failed, no ID obtained");
        }
      }
    }
  }

  /**
   *
   * @param sudoLogin
   * @param password
   * @return user or null
   * @throws SQLException
   */
  public User authorize(final String sudoLogin, final String password) throws SQLException {
    String sql = "SELECT * FROM " + TABLE + " WHERE %s=?"
      .formatted(sudoLogin.contains("@") ? "Email" : "UserName");
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setString(1, sudoLogin);
      ResultSet rs = ps.executeQuery();
      if (!rs.next()) {
        return null;
      }
      User user = parse(rs);
      if (user.getPassword() == null) {
        throw new SQLException("account does not have password authentication enabled");
      } else if (!user.getPassword().equals(Utils.hash(password))) {
        return null;
      }

      return user;
    }
  }

  /**
   *
   * @param email (authenticated email)
   * @return user or null
   */
  public User selectByEmail(final String email) throws SQLException {
    String sql = "SELECT * FROM " + TABLE + " WHERE email=?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setString(1, email);
      ResultSet rs = ps.executeQuery();
      return parse(rs);
    }
  }

  public User selectByName(String name) throws SQLException {
    String sql = "SELECT * FROM " + TABLE + " WHERE UserName=?";
    try (PreparedStatement ps = connection.prepareStatement(sql);) {
      ps.setString(1, name);
      ResultSet rs = ps.executeQuery();
      return parse(rs);
    }
  }

  public void updatePassword(User t) throws SQLException {
    String sql = "UPDATE " + TABLE
      + " SET Password=?"
      + " WHERE UserID=?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
      String hashedPassword = Utils.hash(t.getPassword());
      ps.setString(1, hashedPassword);
      ps.setInt(2, t.getUserID());
      int affectedRows = ps.executeUpdate();

      if (affectedRows == 0) {
        throw new SQLException("Update user password failed, no rows affected");
      }

      t.setPassword(hashedPassword);
    }
  }

  @Override
  public void update(User t) throws SQLException {
    try (PreparedStatement ps = connection.prepareStatement(SQL_UPDATE)) {
      ps.setString(1, t.getUserName());
      ps.setString(2, t.getPhone());
      ps.setString(3, t.getAddress());
      ps.setNString(4, t.getGivenName());
      ps.setNString(5, t.getFamilyName());
      ps.setString(6, t.getGender());
      ps.setInt(7, t.getUserID());

      if (selectByName(t.getUserName()) != null) {
        throw new SQLException("Updating user failed, username is taken");
      }

      int affectedRows = ps.executeUpdate();

      if (affectedRows == 0) {
        throw new SQLException("Updating user failed, no rows affected");
      }

    }
  }

  @Override
  public void delete(User t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

  @Override
  public List<User> selectAll() throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

}
