/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.dao;

import com.cso.shop.model.Category;
import java.sql.SQLException;
import java.util.List;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hi
 */
public class CategoryDAO extends BaseDAO<Category> {

  public static void main(String[] args) {
    CategoryDAO cdao = new CategoryDAO();
    try {
      cdao.selectAll(6).forEach(c
        -> System.out.println(c)
      );

      cdao.selectBatch(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12).forEach((i, l) -> {
        System.out.print("#" + i + " : ");
        l.forEach(c -> System.out.print(c + " "));
        System.out.println("");
      });
    } catch (SQLException ex) {
      Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
  }

  public CategoryDAO() {
    super("category");
  }

  @Override
  public List<Category> selectAll() throws SQLException {
    String sql = "SELECT * FROM " + TABLE;
    List<Category> list = new ArrayList<>();
    ps = getConnection().prepareStatement(sql);
    rs = ps.executeQuery();
    while (rs.next()) {
      list.add(construct(rs));
    }
    return list;
  }

  public List<Category> selectAll(int productId) throws SQLException {
    String sql = "SELECT c.* FROM " + TABLE + " c\n"
      + "LEFT JOIN productCategory pc ON c.categoryId = pc.categoryId\n"
      + "WHERE pc.productId = ?";
    List<Category> list = new ArrayList<>();
    ps = getConnection().prepareStatement(sql);
    ps.setInt(1, productId);
    rs = ps.executeQuery();
    while (rs.next()) {
      list.add(construct(rs));
    }
    return list;
  }

  public List<Category> selectBatch(String... names) throws SQLException {
    String sql = "SELECT categoryId, name FROM " + TABLE
      + " WHERE name IN ("
      + String.join(",", Collections.nCopies(names.length, "?")) + ")";

    List<Category> list = new ArrayList<>();
    try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
      for (int i = 0; i < names.length; i++) {
        ps.setString(i + 1, names[i]);
      }

      try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
          Category category = construct(rs);
          list.add(category);
        }
      }
    }

    return list;
  }

  public Map<Integer, List<Category>> selectBatch(int... pids) throws SQLException {
    String sql = "SELECT pc.productId, c.* FROM " + TABLE + " c "
      + "LEFT JOIN productCategory pc ON c.categoryId = pc.categoryId "
      + "WHERE pc.productId IN ("
      + String.join(",", Collections.nCopies(pids.length, "?")) + ")";

    Map<Integer, List<Category>> resultMap = new HashMap<>();
    try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
      // Set each productId parameter in the PreparedStatement
      for (int i = 0; i < pids.length; i++) {
        ps.setInt(i + 1, pids[i]);
      }

      try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
          Category category = construct(rs); // construct method to create a Category object from ResultSet
          int productId = rs.getInt("productId");

          // Add the category to the list associated with the productId
          resultMap
            .computeIfAbsent(productId, k -> new ArrayList<>())
            .add(category);
        }
      }
    }

    return resultMap;
  }

  private Category construct(ResultSet rs) throws SQLException {
    Category category = new Category();
    category.setId(rs.getInt("categoryId"));
    category.setName(rs.getString("name"));
    return category;
  }

  @Override
  public Category select(Category t) throws SQLException {
    String sql = "SELECT categoryId, name"
      + " FROM " + TABLE + " WHERE categoryId=?";
    ps = getConnection().prepareStatement(sql);
    ps.setInt(1, t.getId());
    Category p = null;
    rs = ps.executeQuery();
    if (rs.next()) {
      p = construct(rs);
    }
    return p;
  }

  public Category select(String name) throws SQLException {
    String sql = "SELECT categoryId, name"
      + " FROM " + TABLE + " WHERE name=?";
    ps = getConnection().prepareStatement(sql);
    ps.setString(1, name);
    Category p = null;
    rs = ps.executeQuery();
    if (rs.next()) {
      p = construct(rs);
    }
    return p;
  }

  @Override
  public void insert(Category t) throws SQLException {
    String sql = "INSERT INTO " + TABLE
      + " (name)"
      + " VALUES (?);";
    ps = getConnection().prepareStatement(sql);
    ps.setString(1, t.getName());
    int affectedRows = ps.executeUpdate();

    if (affectedRows == 0) {
      throw new SQLException("Creating category failed, no rows affected");
    }
  }

  public void insertProductCategories(int productId, int... categoryIds) throws SQLException {
    if (categoryIds.length == 0) {
      return;
    }
    deleteProductCategories(productId);
    String sql = "INSERT INTO productCategory"
      + " (productId, categoryId)"
      + " VALUES (?,?);";
    ps = getConnection().prepareStatement(sql);
    for (int categoryId : categoryIds) {
      ps.setInt(1, productId);
      ps.setInt(2, categoryId);
      ps.addBatch();
    }
    int[] rows = ps.executeBatch();
    for (int i : rows) {
      System.out.println(i);
    }
  }

  public void deleteProductCategories(int productId) throws SQLException {
    String sql = "DELETE FROM productCategory"
      + " WHERE productId=?;";
    ps = getConnection().prepareStatement(sql);
    ps.setInt(1, productId);
    ps.execute();
  }

  public void deleteProductCategories(int productId, int... categoryIds) throws SQLException {
    if (categoryIds.length == 0) {
      return;
    }
    String sql = "DELETE FROM productCategory"
      + " WHERE productId=? AND categoryId=?;";
    ps = getConnection().prepareStatement(sql);
    for (int categoryId : categoryIds) {
      ps.setInt(1, productId);
      ps.setInt(2, categoryId);
      ps.addBatch();
    }
    ps.executeBatch();
  }

  @Override
  public void update(Category t) throws SQLException {
    String sql = "UPDATE " + TABLE + " SET name=? WHERE categoryId=?;";
    ps = getConnection().prepareStatement(sql);
    ps.setString(1, t.getName());
    ps.setInt(2, t.getId());
    int affectedRows = ps.executeUpdate();
    if (affectedRows == 0) {
      throw new SQLException("Update category failed, no rows affected");
    }
  }

  @Override
  public void delete(Category t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

}
