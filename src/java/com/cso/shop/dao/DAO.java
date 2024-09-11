/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * <ul><li><code><b>CREATE</b> = "INSERT INTO " + table + " (...) VALUES
 * (?,?,?);";</code></li>
 * <li><code><b>READ</b> = "SELECT * FROM " + table + " WHERE
 * ...=?";</code></li>
 * <li><code><b>UPDATE</b> = "UPDATE " + table + " SET ...=?, ...=? WHERE
 * ...=?;";</code></li>
 * <li><code><b>DELETE</b> = "DELETE FROM " + table + " WHERE
 * ...=?;";</code></li></ul>
 *
 * @author hi
 */
public abstract class DAO<T> extends DBContext {

  protected final String table;
//  private String CREATE = "INSERT INTO " + table + " (...) VALUES (?,?,?);";
//  private String READ = "SELECT * FROM " + table + " WHERE ...=?";
//  private String UPDATE = "UPDATE " + table + " SET ...=?, ...=? WHERE ...=?;";
//  private String DELETE = "DELETE FROM " + table + " WHERE ...=?;";

  public DAO(String table) {
    this.table = table;
  }

  protected PreparedStatement ps;
  protected ResultSet rs;

  //<editor-fold defaultstate="collapsed" desc="SQL Abstract Methods">
  protected PreparedStatement setupStatement(String query, Object... params) throws SQLException {
    ps = connection.prepareStatement(query);
    for (int i = 0; i < params.length; i++) {
      ps.setObject(i + 1, params[i]);
    }
    return ps;
  }

  public List<T> getAll() throws SQLException {
    rs = setupStatement("SELECT * FROM " + table).executeQuery();
    List<T> list = new ArrayList<>();
    while (rs.next()) {
      list.add(construct(rs));
    }
    return list;
  }

  protected abstract T construct(ResultSet rs) throws SQLException;

  public abstract T read(T t) throws SQLException;

  public abstract int create(T t) throws SQLException;

  public abstract int update(T n) throws SQLException;

  public abstract int delete(T t) throws SQLException;

//  public abstract T get(int id) throws SQLException;
//  public abstract int delete(int id) throws SQLException;
//  public abstract int update(T o, T n) throws SQLException;
  //</editor-fold>
}
