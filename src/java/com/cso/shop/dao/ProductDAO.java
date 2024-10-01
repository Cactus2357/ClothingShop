/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.dao;

import com.cso.shop.model.Product;
import java.sql.SQLException;
import java.util.List;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author hi
 */
public class ProductDAO extends BaseDAO<Product> {

  public ProductDAO() {
    super("product");
  }

  @Override
  public List<Product> selectAll() throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

  public List<Product> selectAll(String name, Integer sortBy, Integer limit, Integer offset) throws SQLException {
    StringBuilder sql = new StringBuilder(
      "SELECT productId, name, image, description, quantity, unitPrice, salePrice, importDate, updateDate, status FROM "
      + TABLE
    );
    boolean nameCondition = (name != null && !name.isBlank());
    boolean sortByCondition = (sortBy != null && sortBy >= 0 && sortBy <= 3);
    boolean limitCondition = (limit != null && limit >= 5 && limit <= 20);
    boolean offsetCondition = (offset != null && limitCondition && offset >= 2);
    if (nameCondition) {
      sql.append(" WHERE name LIKE ?");
    }
    if (sortByCondition) {
      switch (sortBy) {
        case 0:
          sql.append(" ORDER BY importDate DESC");
          break;
        case 1:
          sql.append(" ORDER BY salePrice ASC");
          break;
        case 2:
          sql.append(" ORDER BY salePrice DESC");
          break;
      }
    }
    if (limitCondition) {
      sql.append(" LIMIT ").append(limit);
    } else {
      sql.append(" LIMIT 9");
    }
    if (offsetCondition) {
      sql.append(" OFFSET ").append((offset - 1) * (limitCondition ? limit : 9));
    }

    List<Product> list = new ArrayList<>();
    ps = connection.prepareStatement(sql.toString());
    if (nameCondition) {
      ps.setString(1, '%' + name.trim() + '%');
    }
    rs = ps.executeQuery();
    while (rs.next()) {
      list.add(construct(rs));
    }
    return list;
  }

  private Product construct(ResultSet rs) throws SQLException {
    Product p = new Product();
    p.setId(rs.getInt("productId"));
    p.setName(rs.getString("name"));
    p.setImage(rs.getString("image"));
    p.setDescription(rs.getString("description"));
    p.setQuantity(rs.getInt("quantity"));
    p.setUnitPrice(rs.getDouble("unitPrice"));
    p.setSalePrice(rs.getDouble("salePrice"));
    p.setImportDate(rs.getDate("importDate"));
    p.setUpdateDate(rs.getDate("updateDate"));
    p.setStatus(rs.getString("status"));
    return p;
  }

  @Override
  public Product select(Product t) throws SQLException {
    String sql = "SELECT productId, name, image, description, quantity, unitPrice, salePrice, importDate, updateDate, status"
      + " FROM " + TABLE + " WHERE productId=?";
    ps = connection.prepareStatement(sql);
    ps.setInt(1, t.getId());
    Product p = null;
    rs = ps.executeQuery();
    if (rs.next()) {
      p = construct(rs);
    }
    return p;
  }

  @Override
  public void insert(Product t) throws SQLException {
    String sql = "INSERT INTO " + TABLE
      + " (name, image, description, quantity, unitPrice, salePrice)"
      + " VALUES (?,?,?,?,?,?);";
    ps = connection.prepareStatement(sql);
    ps.setString(1, t.getName());
    ps.setString(2, t.getImage());
    ps.setString(3, t.getDescription());
    ps.setInt(4, t.getQuantity());
    ps.setDouble(5, t.getUnitPrice());
    ps.setDouble(6, t.getSalePrice());
    int affectedRows = ps.executeUpdate();

    if (affectedRows == 0) {
      throw new SQLException("Creating product failed, no rows affected");
    }
  }

  @Override
  public void update(Product t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

  @Override
  public void delete(Product t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

}
