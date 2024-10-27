DROP DATABASE IF EXISTS `cso`;
CREATE DATABASE IF NOT EXISTS `cso`;
USE `cso`;

CREATE TABLE product (
  productId INT AUTO_INCREMENT PRIMARY KEY,
  name NVARCHAR(255) NOT NULL,
  image TEXT NOT NULL,
  description TEXT NOT NULL,
  quantity INT NOT NULL CHECK (quantity >= 0),
  unitPrice DECIMAL(10,2) NOT NULL CHECK (unitPrice >= 0.00),
  salePrice DECIMAL(10,2) NOT NULL CHECK (salePrice >= 0.00),
  importDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updateDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status ENUM('active', 'inactive', 'restocked', 'out of stock', 'discontinued') DEFAULT 'active'
);

DESCRIBE product;

CREATE TABLE category (
  categoryId INT AUTO_INCREMENT PRIMARY KEY,
  name NVARCHAR(255) NOT NULL
);

CREATE TABLE productCategory (
  productId INT,
  categoryId INT,
  FOREIGN KEY (productId) REFERENCES product(productId),
  FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE user (
  userId INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) UNIQUE,  
  email VARCHAR(255) UNIQUE,
  password VARCHAR(255),
  familyName NVARCHAR(100),
  givenName NVARCHAR(100),
  phone VARCHAR(20),
  address VARCHAR(255),
  avatar TEXT,
  role ENUM('customer', 'staff', 'manager', 'admin') DEFAULT 'customer',
  status ENUM('active', 'inactive', 'blocked') DEFAULT 'active',
  gender ENUM('male', 'female') NOT NULL,
  createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  note TEXT
);

CREATE TABLE cart (
  cartId INT AUTO_INCREMENT PRIMARY KEY,
  userId INT,
  status ENUM('active', 'inactive', 'pending') DEFAULT 'pending',
  FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE
);

CREATE TABLE cartItem (
  cartItemId INT AUTO_INCREMENT PRIMARY KEY,
  cartId INT,
  productId INT,
  quantity INT,
  status ENUM('active', 'inactive', 'removed') DEFAULT 'active',
  FOREIGN KEY (cartId) REFERENCES cart(cartId),
  FOREIGN KEY (productId) REFERENCES product(productId)
);

CREATE TABLE review (
  reviewId INT AUTO_INCREMENT PRIMARY KEY,
  rating FLOAT NOT NULL,
  comment TEXT,
  productId INT,
  userId INT,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  status ENUM('active', 'inactive', 'deleted') DEFAULT 'active',
  FOREIGN KEY (productId) REFERENCES product(productId),
  FOREIGN KEY (userId) REFERENCES user(userId)
);

CREATE TABLE reviewAttachment (
	reviewAttachmentId INT AUTO_INCREMENT PRIMARY KEY,
    reviewId INT,
    attachment TEXT NOT NULL,
    status ENUM('active', 'inactive', 'removed') DEFAULT 'active',
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (reviewId) REFERENCES review(reviewId)
);

CREATE TABLE post (
  postId INT AUTO_INCREMENT PRIMARY KEY,
  userId INT,
  brief VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  image TEXT NOT NULL,
  featuring ENUM('on', 'off') DEFAULT 'off',
  status ENUM('active', 'inactive') DEFAULT 'active',
  FOREIGN KEY (userId) REFERENCES user(userId)
);

CREATE TABLE slider (
  sliderId INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  image TEXT NOT NULL,
  backLink TEXT NOT NULL,
  status ENUM('active', 'inactive') DEFAULT 'active',
  userId INT,
  FOREIGN KEY (userId) REFERENCES user(userId)
);

CREATE TABLE `order` (
  orderId INT AUTO_INCREMENT PRIMARY KEY,
  userId INT,
  orderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
  status ENUM('pending', 'processing', 'shipped', 'delivered', 'canceled') DEFAULT 'pending',
  FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE
);

CREATE TABLE orderItem (
  orderItemId INT AUTO_INCREMENT PRIMARY KEY,
  quantity INT NOT NULL,
  orderId INT,
  productId INT,
  FOREIGN KEY (orderId) REFERENCES `order`(orderId),
  FOREIGN KEY (productId) REFERENCES product(productId)
);

CREATE TABLE setting (
  settingId INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  value VARCHAR(255) NOT NULL,
  type VARCHAR(100) NOT NULL,
  description TEXT,
  status ENUM('active', 'inactive') DEFAULT 'active'
);

CREATE TABLE authToken (
  authTokenId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  hashedToken CHAR(64) NOT NULL,
  userId INT NOT NULL,
  expiry DATETIME NOT NULL,
  status ENUM('active', 'expired', 'revoked') DEFAULT 'active',
  FOREIGN KEY (userId) REFERENCES user(userId)
);


