package com.cso.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

// Change the USERNAME, PASWORD and DÂTBASE to connect your own database
public class DBContext {

  private final String USERNAME = "root";
  private final String PASSWORD = "123456";
  private final String DATABASE = "cso";
  private final Integer PORT = 3306;

  public Connection connection;

  public DBContext() {
    try {
      String URL = "jdbc:mysql://localhost:%d/%s".formatted(PORT, DATABASE);

      Class.forName("com.mysql.cj.jdbc.Driver");
      connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

    } catch (ClassNotFoundException | SQLException ex) {
      Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
  }

  public static void main(String[] args) {
    Connection con = new DBContext().connection;
    try {
      System.out.println((con != null && con.isValid(10)) ? "connected" : "not connected");
    } catch (SQLException ex) {
      System.err.println(ex);
    }
  }

}
