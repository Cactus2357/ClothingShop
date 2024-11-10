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
import java.util.logging.Level;
import java.util.logging.Logger;

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
    String sql = "SELECT * FROM " + TABLE;
    List<Product> products = new ArrayList<>();
    try (Statement stmt = getConnection().createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
      while (rs.next()) {
        products.add(construct(rs));
      }
    } catch (SQLException ex) {
//      logger.log(Level.SEVERE, "Failed to select all products", ex);
      ex.printStackTrace();
      throw ex;
    }
    return products;

  }

  public int countSelectAll(String name, int categoryId) {
    String sql = buildCountQuery(name, categoryId);
    try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
      setFilterParams(ps, name, categoryId);
      try (ResultSet rs = ps.executeQuery()) {
        if (rs.next())
          return rs.getInt("count");
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return 0;
  }

  public List<Product> selectAll(String name, int categoryId, int sortBy, int limit, int offset) throws SQLException {
    String sql = buildSelectQuery(name, categoryId, sortBy, limit, offset);
    List<Product> products = new ArrayList<>();
    try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
      setFilterParams(ps, name, categoryId);
      try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
          products.add(construct(rs));
        }
      }
    }
    return products;
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
    p.setImportDate(new Date(rs.getTimestamp("importDate").getTime()));
    p.setUpdateDate(new Date(rs.getTimestamp("updateDate").getTime()));
    p.setStatus(rs.getString("status"));
    return p;
  }

  private String buildCountQuery(String name, int categoryId) {
    StringBuilder sql = new StringBuilder("SELECT COUNT(p.productId) AS count FROM " + TABLE + " p");
    if (categoryId > 0)
      sql.append(" JOIN productCategory pc ON pc.productId = p.productId");
    appendWhereClause(sql, name, categoryId);
    return sql.toString();
  }

  private String buildSelectQuery(String name, int categoryId, int sortBy, int limit, int offset) {
    StringBuilder sql = new StringBuilder(
      "SELECT p.productId, p.name, p.image, p.description, p.quantity, p.unitPrice, "
      + "p.salePrice, p.importDate, p.updateDate, p.status FROM " + TABLE + " p"
    );
    if (categoryId > 0)
      sql.append(" JOIN productCategory pc ON pc.productId = p.productId");
    appendWhereClause(sql, name, categoryId);
    appendOrderClause(sql, sortBy);
    sql.append(" LIMIT ").append(Math.min(limit, 20)).append(" OFFSET ").append(Math.max(offset, 0));
    return sql.toString();
  }

  private void appendWhereClause(StringBuilder sql, String name, int categoryId) {
    boolean isValidName = name != null && !name.isBlank();
    boolean isValidCategory = categoryId > 0;

    if (isValidName || isValidCategory)
      sql.append(" WHERE");

    if (isValidName)
      sql.append(" p.name LIKE ?");

    if (isValidCategory) {
      if (isValidName)
        sql.append(" AND");
      sql.append(" pc.categoryId = ?");
    }
  }

  private void appendOrderClause(StringBuilder sql, int sortBy) {
    switch (sortBy) {
      case 1 ->
        sql.append(" ORDER BY p.salePrice ASC");
      case 2 ->
        sql.append(" ORDER BY p.salePrice DESC");
      default ->
        sql.append(" ORDER BY p.importDate DESC");
    }
  }

  private void setFilterParams(PreparedStatement ps, String name, int categoryId) throws SQLException {
    boolean validName = name != null && !name.isBlank();
    boolean validCategoryId = categoryId > 0;
    int paramIndex = 1;
    if (validName)
      ps.setString(paramIndex++, "%" + name.trim() + "%");
    if (validCategoryId)
      ps.setInt(paramIndex, categoryId);
  }

  private void setProductParams(PreparedStatement ps, Product product) throws SQLException {
    ps.setString(1, product.getName());
    ps.setString(2, product.getImage());
    ps.setString(3, product.getDescription());
    ps.setInt(4, product.getQuantity());
    ps.setDouble(5, product.getUnitPrice());
    ps.setDouble(6, product.getSalePrice());
  }

  @Override
  public Product select(Product t) throws SQLException {
    String sql = "SELECT productId, name, image, description, quantity, unitPrice, salePrice, importDate, updateDate, status"
      + " FROM " + TABLE + " WHERE productId=?";
    try (PreparedStatement ps = getConnection().prepareStatement(sql);) {
      Product p = null;
      ps.setInt(1, t.getId());
      try (ResultSet rs = ps.executeQuery();) {
        if (rs.next())
          p = construct(rs);
        return p;
      }
    }
  }

  @Override
  public void insert(Product t) throws SQLException {
    String sql = "INSERT INTO " + TABLE
      + " (name, image, description, quantity, unitPrice, salePrice)"
      + " VALUES (?,?,?,?,?,?);";

    try (PreparedStatement ps = getConnection().prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
      setProductParams(ps, t);
      int affectedRows = ps.executeUpdate();
      if (affectedRows == 0)
        throw new SQLException("Creating product failed, no rows affected");

      try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
        if (generatedKeys.next()) {
          t.setId(generatedKeys.getInt(1));
        } else {
          throw new SQLException("Creating product failed, no ID obtained");
        }
      }
    }
  }

  @Override
  public void update(Product t) throws SQLException {
    StringBuilder sql = new StringBuilder("UPDATE " + TABLE);
    sql.append(" SET name = ?, description = ?, quantity = ?, unitPrice = ?, salePrice = ?, image = ?")
      .append(" WHERE productId = ?;");

    try (PreparedStatement ps = getConnection().prepareStatement(sql.toString())) {
      setProductParams(ps, t);
      ps.setInt(7, t.getId());
      int affectedRows = ps.executeUpdate();

      if (affectedRows == 0) {
        throw new SQLException("Updating product failed, no rows affected.");
      }
    }
  }

  @Override
  public void delete(Product t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

}
