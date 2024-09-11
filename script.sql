DROP DATABASE IF EXISTS `cso`;
CREATE DATABASE IF NOT EXISTS `cso`;
USE `cso`;

CREATE TABLE `userRole` (
	roleId INT AUTO_INCREMENT,
    name VARCHAR(20),
    PRIMARY KEY (roleId)
);
-- INSERT INTO `userRole` (name)
-- VALUES ('guest'), ('customer'), ('staff'), ('manager'), ('admin');

CREATE TABLE `user` (
	userId INT AUTO_INCREMENT,
    name VARCHAR(100),
    fullName NVARCHAR(100),
    avatar VARCHAR(255),
    email VARCHAR(100),
    password VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(100),
    gender BIT,
    roleId INT,
    status VARCHAR(20),
    PRIMARY KEY (userId),
    FOREIGN KEY (roleId) REFERENCES userRole(roleId)
);

CREATE TABLE `category` (
	categoryId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE `post` (
	postId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT,
    image VARCHAR(255),
    categoryId INT,
    briefInfo VARCHAR(100),
    description TEXT,
    featurning VARCHAR(100),
    status VARCHAR(100),
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES user(userId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE `product` (
	productId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    image VARCHAR(255),
    description TEXT,
    categoryId INT,
    quantity INT,
    unitPrice DECIMAL,
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE `cart` (
	cartId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT,
    FOREIGN KEY (userId) REFERENCES user(userId)
);

CREATE TABLE `cartItem` (
	cartId INT,
    productId INT,
    quantity INT,
    FOREIGN KEY (cartId) REFERENCES cart(cartId),
    FOREIGN KEY (productId) REFERENCES product(productId)
);

CREATE TABLE `order` (
	orderId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT,
    quantity INT,
    revenue DECIMAL,
    orderDate DATETIME,
    status VARCHAR(100),
    FOREIGN KEY (userId) REFERENCES user(userId)
);

CREATE TABLE `orderItem` (
	orderId INT,
    productId INT,
    quantity INT,
    FOREIGN KEY (orderId) REFERENCES `order`(orderId),
    FOREIGN KEY (productId) REFERENCES product(productId)
);
 
CREATE TABLE `review` (
	reviewId INT AUTO_INCREMENT PRIMARY KEY,
    comment TEXT,
    rating FLOAT,
    orderId INT,
    FOREIGN KEY (orderId) REFERENCES `order`(orderId)
);



