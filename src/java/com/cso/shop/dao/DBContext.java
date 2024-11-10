package com.cso.shop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

// Change the USERNAME, PASWORD and DÂTBASE to connect your own database
public class DBContext {

  private final static String USERNAME = "root";
  private final static String PASSWORD = "123456";
  private final static String DATABASE = "cso";
  private final static Integer PORT = 3306;
  private final static String URL = "jdbc:mysql://localhost:%d/%s".formatted(PORT, DATABASE);

  private Connection connection;

  public DBContext() {
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
//      connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

    } catch (ClassNotFoundException ex) {
      Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "MySQL JDBC Driver not found", ex);
    }
  }

  private Connection createConnection() {
    try {
      return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    } catch (SQLException e) {
      Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Failed to create connection", e);
      return null;
    }
  }

  public Connection getConnection() {
    try {
      if (connection == null || connection.isClosed()) {
        connection = createConnection();
      }
      return connection;
    } catch (SQLException e) {
      Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Failed to check connection", e);
      return null;
    }
  }

  public static void main(String[] args) {
    Connection con = new DBContext().getConnection();
    try {
      System.out.println((con != null && con.isValid(10)) ? "connected" : "not connected");
    } catch (SQLException ex) {
      System.err.println(ex);
    }
  }

}
