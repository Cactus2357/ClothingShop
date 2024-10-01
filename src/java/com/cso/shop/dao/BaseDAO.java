/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.dao;

import java.util.List;
import java.sql.*;

/**
 * <ul>
 * <li><code><b>INSERT</b> = "INSERT INTO " + TABLE + " (...) VALUES
 * (?,?,?);";</code></li>
 * <li><code><b>SELECT</b> = "SELECT * FROM " + TABLE + " WHERE
 * ...=?";</code></li>
 * <li><code><b>UPDATE</b> = "UPDATE " + TABLE + " SET ...=?, ...=? WHERE
 * ...=?;";</code></li>
 * <li><code><b>DELETE</b> = "DELETE FROM " + TABLE + " WHERE
 * ...=?;";</code></li>
 * </ul>
 *
 * @author hi
 * @param <T>
 */
public abstract class BaseDAO<T> extends DBContext {

  public final String TABLE;

  protected PreparedStatement ps;
  protected ResultSet rs;

  protected BaseDAO(String table) {
    this.TABLE = table;
  }

  public abstract List<T> selectAll() throws SQLException;

  public abstract T select(T t) throws SQLException;

  public abstract void insert(T t) throws SQLException;

  public abstract void update(T t) throws SQLException;

  public abstract void delete(T t) throws SQLException;

}
