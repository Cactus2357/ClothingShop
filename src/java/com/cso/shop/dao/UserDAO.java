/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.dao;

import com.cso.shop.model.User;
import com.cso.shop.util.Utils;
import java.math.BigInteger;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.commons.dbutils.handlers.ScalarHandler;

/**
 *
 * @author hi
 */
public class UserDAO extends DAO<User> {

  public UserDAO() {
    super("user", User.class);
  }

  public static void main(String[] args) {
    try {
      UserDAO udao = new UserDAO();
      User u = new User(0, "haha", "haha", null,
        "user@email.com", "12345678", null, null,
        true, 1, "active");
      System.out.println(udao.insert(u));
    } catch (Exception e) {
      System.err.println(e);
    }
  }

  @Override
  public User select(User t) throws SQLException {
    String sql = "SELECT * FROM " + TABLE + " WHERE userId=?";
    User user = run.query(connection, sql, h, t.getUserId());
    return user;
  }

  @Override
  public User insert(User t) throws SQLException {
    String sql = "INSERT INTO " + TABLE
      + " (name, fullName, avatar, email, password, phone, address, gender, status)"
      + " VALUES (?,?,?,?,?,?,?,?,?)";

    String hashedPassword = Utils.hash(t.getPassword());

    BigInteger generatedId = run.insert(connection, sql, new ScalarHandler<>(),
      t.getName(), t.getFullName(), t.getAvatar(), t.getEmail(), hashedPassword,
      t.getPhone(), t.getAddress(), t.getGender(), "active");

    User user = run.query(connection, "SELECT * FROM " + TABLE + " WHERE userId = ?", h, generatedId);

    return user;
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
      .formatted(sudoLogin.contains("@") ? "email" : "name");
    final User user = run.query(connection, sql, h, sudoLogin);

    if (user == null || user.getPassword() == null) {
//      throw new Exception("account does not have password authentication enabled");
      return null;
    }

    if (user.getPassword().equals(Utils.hash(password))) {
      return user;
    } else {
      return null;
    }

  }

  /**
   *
   * @param email (authenticated email)
   * @return user or null
   */
  public User auth2(final String email) throws SQLException {
    String sql = "SELECT * FROM " + TABLE + " WHERE email=?";
    final User user = run.query(connection, sql, h, email);
    return user;
  }

  public User selectByName(String name) throws SQLException {
    String sql = "SELECT * FROM " + TABLE + " WHERE name=?";
    return run.query(connection, sql, h, name);
  }

  @Override
  public int update(User t) throws SQLException {
    String sql = "UPDATE " + TABLE
      + " SET fullName=?, phone=?, address=?, gender=?"
      + " WHERE userId=?";
    int rows = run.update(connection, sql, h,
      t.getFullName(), t.getPhone(), t.getAddress(), t.getGender(), t.getUserId());
    return rows;
  }

  @Override
  public int delete(User t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

}
