/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.dao;

import com.cso.shop.dao.DBContext;
import java.util.List;
import java.sql.*;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ColumnListHandler;

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
public abstract class DAO<T> extends DBContext {

  public final String TABLE;

  protected final ResultSetHandler<T> h;
  protected final ResultSetHandler<List<T>> hl;
  protected final ColumnListHandler ch;

  protected final QueryRunner run;

  protected PreparedStatement ps;
  protected ResultSet rs;

  protected DAO(String table, Class<T> type) {
    this.TABLE = table;
    this.h = new BeanHandler<>(type);
    this.hl = new BeanListHandler<>(type);
    this.ch = new ColumnListHandler();
    this.run = new QueryRunner();
  }

  public final List<T> selectAll() throws SQLException {
    return run.query(connection, "SELECT * FROM " + TABLE, hl);
  }

  public abstract T select(T t) throws SQLException;

  public abstract T insert(T t) throws SQLException;

  public abstract int update(T t) throws SQLException;

  public abstract int delete(T t) throws SQLException;

}
