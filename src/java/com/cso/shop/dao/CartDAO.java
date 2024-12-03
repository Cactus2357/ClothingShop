/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.dao;

import com.cso.shop.model.CartItem;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hi
 */
public class CartDAO extends BaseDAO<CartItem> {

  public CartDAO() {
    super("cartItem");
  }

  @Override
  public List<CartItem> selectAll() throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

  public List<CartItem> selectAll(int userId) throws SQLException {
    String sql = "SELECT ci.cartItemId, ci.cartId, ci.productId, ci.quantity, ci.status"
      + " FROM " + TABLE + " ci"
      + " LEFT JOIN cart c ON c.cartId = ci.cartId"
      + " WHERE c.userId = ? AND ci.status = ?";

    List<CartItem> list = new ArrayList<>();

    try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
      int paramIndex = 1;

      ps.setInt(paramIndex++, userId);
      ps.setString(paramIndex++, "active");
      try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
          list.add(constructProductReview(rs));
        }
      }
    }

    return list;
  }

  @Override
  public CartItem select(CartItem t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

  @Override
  public void insert(CartItem t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

  @Override
  public void update(CartItem t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

  @Override
  public void delete(CartItem t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

  public void delete(int cartItemId) throws SQLException {
    String sql = "DELETE FROM " + TABLE
      + " WHERE cartItemId = ?";
    try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
      int paramIndex = 1;

      ps.setInt(paramIndex++, cartItemId);
      ps.execute();
    }
  }

  public void deleteAll(int userId) throws SQLException {
    String sql = "DELETE FROM " + TABLE + " ci"
      + " LEFT JOIN cart c ON c.cartId = ci.cartId"
      + " WHERE c.userId = ?";
    try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
      int paramIndex = 1;

      ps.setInt(paramIndex++, userId);
      ps.execute();
    }
  }

  private CartItem constructProductReview(ResultSet rs) throws SQLException {
    CartItem item = new CartItem();

    item.setCartItemId(rs.getInt("cartItemId"));
    item.setCartId(rs.getInt("cartId"));
    item.setProductId(rs.getInt("productId"));
    item.setQuantity(rs.getInt("quantity"));
    item.setStatus(rs.getString("status"));

    return item;
  }

}
