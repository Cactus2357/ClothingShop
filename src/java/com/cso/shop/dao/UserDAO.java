/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.dao;

import com.cso.shop.model.User;
import com.cso.shop.util.RandomString;
import com.cso.shop.util.Utils;
import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;

import java.util.List;

/**
 *
 * @author hi
 */
public class UserDAO extends BaseDAO<User> {

  private UserDAO() {
    super("User");
  }

//  private static volatile UserDAO instance;
//  public static UserDAO getInstance() {
//    UserDAO result = instance;
//    if (result == null) {
//      synchronized (UserDAO.class) {
//        result = instance;
//        if (result == null) {
//          instance = result = new UserDAO();
//        }
//      }
//    }
//    return result;
//  }
  private static class Holder {

    private static final UserDAO INSTANCE = new UserDAO();
  }

  public static UserDAO getInstance() {
    return Holder.INSTANCE;
  }

  private String SQL_INSERT = "INSERT INTO " + TABLE + " (name, password, email, phone, role, address, givenName, familyName, status, avatar, gender)" + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
  private String SQL_SELECT = "SELECT * FROM " + TABLE + " WHERE UserID=?";
  private String SQL_UPDATE = "UPDATE " + TABLE + " SET name=?, phone=?, address=?, givenName=?, familyName=?, gender=?" + " WHERE userID=?";
  private String SQL_DELETE = "DELETE FROM " + TABLE + " WHERE userID=?";

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

  private User construct(ResultSet rs) {
    try {
      return new User(
        rs.getInt("userID"),
        rs.getString("name"),
        rs.getString("password"),
        rs.getString("email"),
        rs.getString("phone"),
        rs.getString("role"),
        rs.getString("address"),
        rs.getNString("givenName"),
        rs.getNString("familyName"),
        rs.getString("status"),
        rs.getString("avatar"),
        rs.getString("gender"),
        new Date(rs.getTimestamp("createdAt").getTime())
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
        return construct(rs);
      } else {
        return null;
      }
    }
  }

  @Override
  public void insert(User t) throws SQLException {
    try (PreparedStatement ps = connection.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS);) {
      String hashedPassword = Utils.hash(t.getPassword());
      if (hashedPassword == null) {
        throw new SQLException("Hashing password encountered problem");
      }
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
  public User authenticate(final String sudoLogin, final String password) throws SQLException {
    String sql = "SELECT * FROM " + TABLE + " WHERE %s = ?"
      .formatted(sudoLogin.contains("@") ? "email" : "name");

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setString(1, sudoLogin);

      ResultSet rs = ps.executeQuery();

      if (!rs.next()) {
        return null;
      }

      User user = construct(rs);

      if (user.getPassword() == null) {
        throw new SQLException("Account does not have password authentication enabled");
      }

      if (!user.getPassword().equals(Utils.hash(password))) {
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
      return construct(rs);
    }
  }

  public User selectByName(String name) throws SQLException {
    String sql = "SELECT * FROM " + TABLE + " WHERE name=?";
    try (PreparedStatement ps = connection.prepareStatement(sql);) {
      ps.setString(1, name);
      ResultSet rs = ps.executeQuery();
      return construct(rs);
    }
  }

  public void updatePassword(User t) throws SQLException {
    String sql = "UPDATE " + TABLE
      + " SET password=?"
      + " WHERE userID=?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
      String hashedPassword = Utils.hash(t.getPassword());
      ps.setString(1, hashedPassword);
      ps.setInt(2, t.getUserID());
      int affectedRows = ps.executeUpdate();

      if (affectedRows == 0) {
        throw new SQLException("Update user password failed, no rows affected");
      }

      t.setPassword(hashedPassword);
      invalidateUserTokens(t.getUserID());
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
    String sql = "SELECT * FROM " + TABLE;
    List<User> list = new ArrayList<>();
    try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
      while (rs.next()) {
        list.add(construct(rs));
      }
      return list;
    }
  }

  /* ******************** */
  public String createAuthToken(int userId) throws SQLException {
    int tokenTTL = 30; // in days
    String sql = "INSERT INTO authToken"
      + " (hashedToken, userId, expiry)"
      + " VALUES (?, ?, ?)";

    try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);) {
      RandomString random = new RandomString(20);
      String token = random.nextString();
      String hashedToken = Utils.hash(token, "SHA-256");

      Calendar calendar = Calendar.getInstance();
      calendar.setTimeInMillis(System.currentTimeMillis());
      calendar.add(Calendar.DAY_OF_MONTH, tokenTTL);
      Timestamp expiry = new Timestamp(calendar.getTimeInMillis());

      if (hashedToken == null) {
        throw new SQLException("Hashing token encountered problem");
      }

      ps.setString(1, hashedToken);
      ps.setInt(2, userId);
      ps.setTimestamp(3, expiry);

      int affectedRows = ps.executeUpdate();

      if (affectedRows == 0) {
        throw new SQLException("Creating token failed, no rows affected");
      }

      try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
        if (!generatedKeys.next()) {
          throw new SQLException("Creating token failed, no ID obtained");
        }

        long authTokenId = generatedKeys.getInt(1);
        StringBuilder userToken = new StringBuilder();
        userToken.append(authTokenId).append(":").append(token);
        return userToken.toString();
      }
    }
  }

  public User fetchUserByToken(String userToken) throws Exception {

    if (!validateUserToken(userToken)) {
      throw new Exception("Invalid user token");
    }

    String[] params = userToken.split(":", -1);

    int authTokenId = Integer.parseInt(params[0]);
    String token = params[1];

    String sql = "SELECT * FROM authToken WHERE authTokenId = ?";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
      ps.setInt(1, authTokenId);

      try (ResultSet resultSet = ps.executeQuery()) {
        if (!resultSet.next()) {
          return null;
        }

        String hashedToken = Utils.hash(token, "SHA-256");

        AuthToken authToken = AuthToken.construct(resultSet);
        if (!authToken.isValid(hashedToken)) {
          return null;
        }

        User user = new User();
        user.setUserID(authToken.userId);
        return select(user);
      }
    } catch (SQLException e) {
      System.err.println(e);
      return null;
    }
  }

  public int invalidateUserToken(int userId, int authTokenId) {

    if (userId <= 0) {
      throw new IllegalArgumentException("Invalid user ID");
    }

    if (authTokenId <= 0) {
      throw new IllegalArgumentException("Invalid auth token ID");
    }

    String sql = "UPDATE authToken SET status=? WHERE userId=? AND authTokenId=? AND status=?;";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {

      ps.setString(1, AuthToken.STATUS_EXPIRED);
      ps.setInt(2, userId);
      ps.setInt(3, authTokenId);
      ps.setString(4, AuthToken.STATUS_ACTIVE);

      int rowsAffected = ps.executeUpdate();

      return rowsAffected;
    } catch (SQLException e) {
      System.err.println("SQL error while invalidating user tokens: " + e.getMessage());
      return 0;
    }
  }

  public int invalidateUserTokens(int userId) {

    if (userId <= 0) {
      throw new IllegalArgumentException("Invalid user ID");
    }

    String sql = "UPDATE authToken SET status = ? WHERE userId=? AND status = ?;";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {

      ps.setString(1, AuthToken.STATUS_REVOKED);
      ps.setInt(2, userId);
      ps.setString(3, AuthToken.STATUS_ACTIVE);

      int rowsAffected = ps.executeUpdate();

      return rowsAffected;
    } catch (SQLException e) {
      System.err.println("SQL error while invalidating user tokens: " + e.getMessage());
      return 0;
    }
  }

  public boolean validateUserToken(String userToken) {
    String[] params = userToken.split(":", -1);
    try {
      Integer.parseInt(params[0]);

      boolean isValidParams = params != null && params.length == 2;
      if (!isValidParams || params[1].length() != 20) {
        throw new Exception();
      }

      return true;
    } catch (Exception e) {
      return false;
    }
  }

  private record AuthToken(int authTokenId, String hashedToken, int userId, Date expiry, String status) {

    public static final String STATUS_ACTIVE = "active";
    public static final String STATUS_EXPIRED = "expired";
    public static final String STATUS_REVOKED = "revoked";

    public static AuthToken construct(ResultSet rs) throws SQLException {
      return new AuthToken(
        rs.getInt("authTokenId"),
        rs.getString("hashedToken"),
        rs.getInt("userId"),
        new java.sql.Date(rs.getTimestamp("expiry").getTime()),
        rs.getString("status")
      );
    }

    public boolean isValid(String hashedToken) {
      if (!this.hashedToken.equals(hashedToken)) {
        return false;
      }

      if (!expiry.after(new Date(System.currentTimeMillis()))) {
        /* expiry <= now; token expired */
        // may be change token status to expired
        return false;
      }

      if (!status.equals(STATUS_ACTIVE)) {
        return false;
      }

      return true;
    }
  }

}

/*

authTokenId int AI PK 
hashedToken char(64) 
userId int 
expiry datetime 
status enum('active','expired','revoked')

 */
