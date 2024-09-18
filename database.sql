DROP DATABASE IF EXISTS `cso`;
CREATE DATABASE IF NOT EXISTS `cso`;
USE `cso`;

CREATE TABLE Product
(
  ProductID INT NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  Description TEXT NOT NULL,
  Quantity INT NOT NULL,
  ImportPrice DECIMAL(10,2) NOT NULL,
  SellingPrice DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (ProductID)
);

CREATE TABLE Brand
(
  BrandID INT NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  PRIMARY KEY (BrandID)
);

CREATE TABLE Category
(
  CategoryID INT NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  PRIMARY KEY (CategoryID)
);

CREATE TABLE ProductBrand
(
  ProductID INT NOT NULL,
  BrandID INT NOT NULL,
  PRIMARY KEY (ProductID, BrandID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
  FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);

CREATE TABLE ProductCategory
(
  ProductID INT NOT NULL,
  CategoryID INT NOT NULL,
  PRIMARY KEY (ProductID, CategoryID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
  FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE User
(
  UserID INT NOT NULL,
  UserName NVARCHAR(255) NOT NULL,
  Password VARCHAR(255),
  Email VARCHAR(255) NOT NULL,
  Phone VARCHAR(20) NOT NULL,
  Role ENUM('customer', 'staff', 'manager', 'admin') NOT NULL,
  Address VARCHAR(255) NOT NULL,
  GivenName NVARCHAR(255) NOT NULL,
  FamilyName NVARCHAR(255) NOT NULL,
  Status ENUM('active', 'inactive', 'blocked') NOT NULL,
  Avatar TEXT NOT NULL,
  Gender ENUM('male', 'female') NOT NULL,
  CreatedAt DATETIME NOT NULL,
  PRIMARY KEY (UserID),
  UNIQUE KEY (Email)
);

CREATE TABLE Cart
(
  CartID INT NOT NULL,
  UserID INT NOT NULL,
  Price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (CartID),
  FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE CartDetail
(
  CartDetailID INT NOT NULL,
  ProductID INT NOT NULL,
  Quantity INT NOT NULL,
  CartID INT NOT NULL,
  PRIMARY KEY (CartDetailID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
  FOREIGN KEY (CartID) REFERENCES Cart(CartID)
);

CREATE TABLE Review
(
  ReviewID INT NOT NULL,
  Rating FLOAT NOT NULL,
  Comment TEXT NOT NULL,
  ProductID INT NOT NULL,
  UserID INT NOT NULL,
  PRIMARY KEY (ReviewID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
  FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Blog
(
  BlogID INT NOT NULL,
  Image TEXT NOT NULL,
  Brief TEXT NOT NULL,
  Description TEXT NOT NULL,
  Status ENUM('active','inactive') NOT NULL,
  UpdateAt DATETIME NOT NULL,
  UserID INT NOT NULL,
  PRIMARY KEY (BlogID),
  FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Slide
(
  SlideID INT NOT NULL,
  Title VARCHAR(255) NOT NULL,
  Image TEXT NOT NULL,
  BackLink TEXT NOT NULL,
  Status ENUM('active','inactive') NOT NULL,
  UserID INT NOT NULL,
  PRIMARY KEY (SlideID),
  FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE `Order`
(
  OrderID INT NOT NULL,
  OrderDate DATETIME NOT NULL,
  Status ENUM('cancelled','completed','pending') NOT NULL,
  Revenues DECIMAL(10,2) NOT NULL,
  UserID INT NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE OrderDetail
(
  OrderDetailID INT NOT NULL,
  Quantity INT NOT NULL,
  OrderID INT NOT NULL,
  ProductID INT NOT NULL,
  PRIMARY KEY (OrderDetailID),
  FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
