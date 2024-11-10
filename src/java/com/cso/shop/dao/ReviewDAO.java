/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cso.shop.dao;

import com.cso.shop.model.ProductReview;
import com.cso.shop.model.Review;
import com.cso.shop.model.ReviewAttachment;
//import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.tomcat.jakartaee.commons.lang3.tuple.ImmutablePair;
import org.apache.tomcat.jakartaee.commons.lang3.tuple.Pair;

/**
 *
 * @author hi
 */
public class ReviewDAO extends BaseDAO<Review> {

  private String SQL_INSERT = "INSERT INTO " + TABLE + " (rating, comment, productId, userId) VALUES (?,?,?);";
  private String SQL_SELECT = "SELECT * FROM " + TABLE + " WHERE ...=?";
  private String SQL_UPDATE = "UPDATE " + TABLE + " SET ...=?, ...=? WHERE ...=?;";
  private String SQL_DELETE = "DELETE FROM " + TABLE + " WHERE ...=?;";

  public ReviewDAO() {
    super("review");
  }

  public static void main(String[] args) {
    ReviewDAO rdao = new ReviewDAO();
  }

  @Override
  public List<Review> selectAll() throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

  public List<ProductReview> selectAll(int productId) throws SQLException {
    return selectAll(productId, 0);
  }

  public List<ProductReview> selectAll(int productId, int limit) throws SQLException {
    return selectAll(productId, limit, 0);
  }

  public List<ProductReview> selectAll(int productId, int limit, int offset) throws SQLException {
    StringBuilder sql = new StringBuilder(
      "SELECT r.reviewId, r.rating, r.comment, r.productId, r.createdAt, r.updatedAt, r.status,"
      + " u.userId, u.name AS userName, u.avatar AS userAvatar"
      + " FROM " + TABLE + " r"
      + " LEFT JOIN user u ON u.userId = r.userId"
      + " WHERE r.productId = ? AND r.status = 'active'"
      + " ORDER BY r.createdAt DESC"
    );

    boolean limitCondition = limit > 0;
    boolean offsetCondition = offset >= 0;

    if (limitCondition) {
      sql.append(" LIMIT ?");
    }

    if (offsetCondition) {
      sql.append(" OFFSET ?");
    }

    List<ProductReview> list = new ArrayList<>();
    try (PreparedStatement ps = getConnection().prepareStatement(sql.toString())) {
      int paramIndex = 1;

      ps.setInt(paramIndex++, productId);
      if (limitCondition) {
        ps.setInt(paramIndex++, limit);
      }
      if (offsetCondition) {
        ps.setInt(paramIndex++, offset);
      }

      try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
          list.add(constructProductReview(rs));
        }
      }

    }
    return list;
  }

  public List<Float> selectAllRatings(int productId) throws SQLException {
    StringBuilder sql = new StringBuilder(
      "SELECT rating FROM " + TABLE + " WHERE productId = ?"
    );

    List<Float> ratingList = new ArrayList<>();
    try (PreparedStatement ps = getConnection().prepareStatement(sql.toString())) {
      ps.setInt(1, productId);

      try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
          ratingList.add(rs.getFloat("rating"));
        }
      }
    }
    return ratingList;
  }

//  /**
//   *
//   * @param productId
//   * @return return a <code>Pair<Float, Integer></code> of rating and count
//   * @throws SQLException
//   */
//  public Pair<Float, Integer> selectRating(int productId) throws SQLException {
//    String sql = "SELECT AVG(rating) AS rating, COUNT(rating) AS count FROM " + TABLE
//      + " WHERE productId = ?";
//    try (PreparedStatement ps = connection.prepareStatement(sql)) {
//      ps.setInt(1, productId);
//
//      try (ResultSet rs = ps.executeQuery()) {
//        if (rs.next()) {
//          return new ImmutablePair<>(rs.getFloat("rating"), rs.getInt("count"));
//        } else {
//          return new ImmutablePair<>(0f, 0);
//        }
//      }
//    }
//  }
  public Map<Integer, List<ReviewAttachment>> mapAllReviewAttachment(int... reviewIds) throws SQLException {
    if (reviewIds == null || reviewIds.length == 0) {
      return Collections.emptyMap();
    }

    StringBuilder sql = new StringBuilder(
      "SELECT reviewId, attachment, description, type"
      + " FROM reviewAttachment"
      + " WHERE reviewId IN ("
    );

    sql.append(String.join(",", Collections.nCopies(reviewIds.length, "?")))
      .append(") AND status = 'active'");
    Map<Integer, List<ReviewAttachment>> attachmentMap = new HashMap<>();

    try (PreparedStatement ps = getConnection().prepareStatement(sql.toString())) {
      for (int i = 0; i < reviewIds.length; i++) {
        ps.setInt(i + 1, reviewIds[i]);
      }

      try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
          int reviewId = rs.getInt("reviewId");

          ReviewAttachment attachment = new ReviewAttachment();
          attachment.setReviewId(reviewId);
          attachment.setAttachment(rs.getString("attachment"));
          attachment.setDescription(rs.getString("description"));
          attachment.setType(rs.getString("type"));

          attachmentMap.computeIfAbsent(reviewId, k -> new ArrayList<>())
            .add(attachment);
        }
      }
    }

    return attachmentMap;
  }

  public void insertAttachments(int reviewId, List<ReviewAttachment> attachments) throws SQLException {
    String sql = "INSERT INTO reviewAttachment (reviewId, attachment, description, type)"
      + " VALUES (?, ?, ?, ?)";

    try (PreparedStatement ps = getConnection().prepareStatement(sql)) {
      for (ReviewAttachment attachment : attachments) {
        ps.setInt(1, reviewId);
        ps.setString(2, attachment.getAttachment());
        ps.setString(3, attachment.getDescription());
        ps.setString(4, attachment.getType());
        ps.addBatch();
      }

      ps.executeBatch();
    }

  }

  private ProductReview constructProductReview(ResultSet rs) throws SQLException {
    ProductReview productReview = new ProductReview();
    productReview.setReviewId(rs.getInt("reviewId"));
    productReview.setRating(rs.getFloat("rating"));
    productReview.setComment(rs.getString("comment"));
    productReview.setProductId(rs.getInt("productId"));
    productReview.setUserId(rs.getInt("userId"));
    productReview.setUserName(rs.getString("userName"));
    productReview.setUserAvatar(rs.getString("userAvatar"));
    productReview.setCreatedAt(new Date(rs.getTimestamp("createdAt").getTime()));
    productReview.setUpdatedAt(new Date(rs.getTimestamp("updatedAt").getTime()));
    productReview.setStatus(rs.getString("status"));
    return productReview;
  }

  private Review construct(ResultSet rs) throws SQLException {
    Review review = new Review();
    review.setReviewId(rs.getInt("reviewId"));
    review.setRating(rs.getFloat("rating"));
    review.setComment(rs.getString("comment"));
    review.setProductId(rs.getInt("productId"));
    review.setUserId(rs.getInt("userId"));
    review.setCreatedAt(new Date(rs.getTimestamp("createdAt").getTime()));
    review.setUpdatedAt(new Date(rs.getTimestamp("updatedAt").getTime()));
    review.setStatus(rs.getString("status"));
    return review;
  }

  @Override
  public Review select(Review t) throws SQLException {
    String sql = "SELECT reviewId, rating, comment, productId, userId, createdAt, updatedAt, status"
      + " FROM " + TABLE + " WHERE reviewId=?";
    ps = getConnection().prepareStatement(sql);
    ps.setInt(1, t.getReviewId());
    Review review = null;
    rs = ps.executeQuery();
    if (rs.next()) {
      review = construct(rs);
    }
    return review;
  }

  @Override
  public void insert(Review t) throws SQLException {
    String sql = "INSERT INTO " + TABLE
      + " (rating, comment, productId, userId)"
      + " VALUES (?,?,?,?);";

    try (PreparedStatement ps = getConnection().prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
      ps.setFloat(1, t.getRating());
      ps.setString(2, t.getComment());
      ps.setInt(3, t.getProductId());
      ps.setInt(4, t.getUserId());

      int affectedRows = ps.executeUpdate();
      if (affectedRows == 0) {
        throw new SQLException("Creating review failed, no rows affected");
      }

      try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
        if (generatedKeys.next()) {
          t.setReviewId(generatedKeys.getInt(1));
        } else {
          throw new SQLException("Creating review failed, no ID obtained");
        }
      }
    } catch (SQLException e) {
      e.printStackTrace();
      throw e;
    }
  }

  @Override
  public void update(Review t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

  @Override
  public void delete(Review t) throws SQLException {
    throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
  }

}

//record ProductReview(
//  int reviewId, float rating, String comment, int productId,
//  int userId, String userName, String avatar,
//  Date createdAt, Date updatedAt, String status) {
//
//}
