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

  public static void main(String[] args) {
    ProductDAO pdao = new ProductDAO();
    try {
      pdao.selectAll(null, 0, 0, 20, 0);
//        .forEach(p -> System.out.println(p));

    } catch (SQLException ex) {
      Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
  }

  public ProductDAO() {
    super("product");
  }

  @Override
  public List<Product> selectAll() throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

  public int countSelectAll(String name, int categoryId) {
    StringBuilder sql = new StringBuilder(
      "SELECT COUNT(p.productId) AS count FROM " + TABLE + " p"
    );
    boolean categoryIdCondition = categoryId > 0;
    boolean nameCondition = (name != null && !name.isBlank());

    if (categoryIdCondition) {
      sql.append(" RIGHT JOIN productCategory pc ON pc.productId = p.productId");
    }

    if (nameCondition || categoryIdCondition) {
      sql.append(" WHERE");
    }

    if (nameCondition) {
      sql.append(" p.name LIKE ?");
    }

    if (categoryIdCondition) {
      if (nameCondition) {
        sql.append(" AND");
      }
      sql.append(" pc.categoryId = ?");
    }

    try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
      int paramIndex = 1;

      if (nameCondition) {
        ps.setString(paramIndex++, '%' + name.trim() + '%');
      }

      if (categoryIdCondition) {
        ps.setInt(paramIndex, categoryId);
      }

      try (ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
          return rs.getInt("count");
        }
      }

    } catch (SQLException ex) {
      Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
    return 0;
  }

  public List<Product> selectAll(String name, int categoryId, int sortBy, int limit, int offset) throws SQLException {
    StringBuilder sql = new StringBuilder(
      "SELECT p.productId, p.name, p.image, p.description, p.quantity, p.unitPrice,"
      + " p.salePrice, p.importDate, p.updateDate, p.status"
      + " FROM " + TABLE + " p"
    );

    boolean categoryIdCondition = categoryId >= 1;
    boolean nameCondition = name != null && !name.isBlank();
    boolean sortByCondition = sortBy >= 0 && sortBy <= 3;
    boolean limitCondition = limit >= 1 && limit <= 20;
    boolean offsetCondition = offset >= 0;

    if (categoryIdCondition) {
      sql.append(" RIGHT JOIN productCategory pc ON pc.productId = p.productId");
    }

    if (nameCondition || categoryIdCondition) {
      sql.append(" WHERE");
    }

    if (nameCondition) {
      sql.append(" p.name LIKE ?");
    }

    if (categoryIdCondition) {
      if (nameCondition) {
        sql.append(" AND");
      }
      sql.append(" pc.categoryId = ?");
    }

    if (sortByCondition) {
      switch (sortBy) {
        case 1 ->
          sql.append(" ORDER BY p.salePrice ASC");
        case 2 ->
          sql.append(" ORDER BY p.salePrice DESC");
        default ->
          sql.append(" ORDER BY p.importDate DESC");
      }
    } else {
      sql.append(" ORDER BY p.importDate DESC");
    }

    sql.append(" LIMIT ").append(limitCondition ? limit : 9);

    if (offsetCondition) {
      sql.append(" OFFSET ").append(offset);
    }

    List<Product> list = new ArrayList<>();
    try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
      int paramIndex = 1;

      if (nameCondition) {
        ps.setString(paramIndex++, '%' + name.trim() + '%');
      }

      if (categoryIdCondition) {
        ps.setInt(paramIndex++, categoryId);
      }

      try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
          list.add(construct(rs));
        }
      }

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
    p.setImportDate(new Date(rs.getTimestamp("importDate").getTime()));
    p.setUpdateDate(new Date(rs.getTimestamp("updateDate").getTime()));
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

    try (PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
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

      try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
        if (generatedKeys.next()) {
          t.setId(generatedKeys.getInt(1));
        } else {
          throw new SQLException("Creating product failed, no ID obtained");
        }
      }
    } catch (SQLException e) {
      e.printStackTrace();
      throw e;
    }

  }

  @Override
  public void update(Product t) throws SQLException {
    StringBuilder sql = new StringBuilder("UPDATE " + TABLE);
    sql.append(" SET name = ?, description = ?, quantity = ?, unitPrice = ?, salePrice = ?, image = ?")
      .append(" WHERE productId = ?;");

    try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
      ps.setString(1, t.getName());
      ps.setString(2, t.getDescription());
      ps.setInt(3, t.getQuantity());
      ps.setDouble(4, t.getUnitPrice());
      ps.setDouble(5, t.getSalePrice());
      ps.setString(6, t.getImage());
      ps.setInt(7, t.getId());

      int affectedRows = ps.executeUpdate();

      if (affectedRows == 0) {
        throw new SQLException("Updating product failed, no rows affected.");
      }
    } catch (SQLException e) {
      e.printStackTrace();
      throw e;
    }
  }

  @Override
  public void delete(Product t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

}
