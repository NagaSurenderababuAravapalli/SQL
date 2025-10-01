-- ===================================================
-- OnlineBookstorea3 Database: CREATE + INSERT
-- ===================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS OnlineBookstorea3;
USE OnlineBookstorea3;

-- =========================
-- CREATE TABLES
-- =========================

-- Customer Table
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20)
);

-- Publisher Table
CREATE TABLE Publisher (
    PublisherID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

-- Author Table
CREATE TABLE Author (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Bio TEXT
);

-- Category Table
CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

-- Book Table
CREATE TABLE Book (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    PublisherID INT,
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
);

-- BookAuthor linking Table
CREATE TABLE BookAuthor (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);

-- BookCategory linking Table
CREATE TABLE BookCategory (
    BookID INT,
    CategoryID INT,
    PRIMARY KEY (BookID, CategoryID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Address Table
CREATE TABLE Address (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    Street VARCHAR(200),
    City VARCHAR(100),
    Country VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Cart Table
CREATE TABLE Cart (
    CartID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    CreatedDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- CartItem linking Table
CREATE TABLE CartItem (
    CartID INT,
    BookID INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (CartID, BookID),
    FOREIGN KEY (CartID) REFERENCES Cart(CartID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

-- Order Table
CREATE TABLE `Order` (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- OrderItem Table
CREATE TABLE OrderItem (
    OrderID INT,
    BookID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (OrderID, BookID),
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

-- Payment Table
CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    Amount DECIMAL(10,2) NOT NULL,
    Method ENUM('Credit', 'Debit', 'PayPal') NOT NULL,
    PaymentDate DATE NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID)
);

-- Review Table
CREATE TABLE Review (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    BookID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

-- Indexes
CREATE INDEX idx_book_title ON Book(Title);
CREATE INDEX idx_order_date ON `Order`(OrderDate);

-- =========================
-- INSERT SAMPLE DATA
-- =========================

-- Customers
INSERT INTO Customer (CustomerID, Name, Email, Phone) VALUES
(1, 'Alice Johnson', 'alice.johnson@example.com', '1234567890'),
(2, 'Bob Smith', 'bob.smith@example.com', '2345678901'),
(3, 'Carol Davis', 'carol.davis@example.com', '3456789012'),
(4, 'David Wilson', 'david.wilson@example.com', '4567890123'),
(5, 'Emma Brown', 'emma.brown@example.com', '5678901234');

-- Publishers
INSERT INTO Publisher (PublisherID, Name, Location) VALUES
(1, 'Bloomsbury', 'London, UK'),
(2, 'Bantam Books', 'New York, USA'),
(3, 'HarperCollins', 'London, UK'),
(4, 'Pan Macmillan', 'Berlin, Germany'),
(5, 'Penguin Books', 'Toronto, Canada');

-- Authors
INSERT INTO Author (AuthorID, Name, Bio) VALUES
(1, 'J.K. Rowling', 'Author of Harry Potter series'),
(2, 'George R.R. Martin', 'Author of A Song of Ice and Fire'),
(3, 'Agatha Christie', 'Famous mystery writer'),
(4, 'J.R.R. Tolkien', 'Author of The Hobbit and The Lord of the Rings'),
(5, 'Brandon Sanderson', 'Author of Mistborn series');

-- Categories
INSERT INTO Category (CategoryID, Name) VALUES
(1, 'Fantasy'),
(2, 'Mystery'),
(3, 'Science Fiction'),
(4, 'Non-Fiction'),
(5, 'Romance');

-- Books
INSERT INTO Book (BookID, Title, ISBN, Price, Stock, PublisherID) VALUES
(1, 'Harry Potter and the Sorcerer''s Stone', '9780747532699', 20.00, 50, 1),
(2, 'A Game of Thrones', '9780553103540', 25.00, 40, 2),
(3, 'Murder on the Orient Express', '9780007119318', 15.00, 30, 3),
(4, 'The Hobbit', '9780261102217', 18.00, 35, 1),
(5, 'The Winds of Winter', '9780553801477', 28.00, 20, 2);

-- BookAuthor
INSERT INTO BookAuthor (BookID, AuthorID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 2);

-- BookCategory
INSERT INTO BookCategory (BookID, CategoryID) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 1),
(5, 1);

-- Addresses
INSERT INTO Address (AddressID, CustomerID, Street, City, Country) VALUES
(1, 1, '123 Maple St', 'Berlin', 'Germany'),
(2, 2, '456 Oak St', 'Munich', 'Germany'),
(3, 3, '789 Pine St', 'Hamburg', 'Germany'),
(4, 4, '101 Birch St', 'Frankfurt', 'Germany'),
(5, 5, '202 Cedar St', 'Cologne', 'Germany');

-- Carts
INSERT INTO Cart (CartID, CustomerID, CreatedDate) VALUES
(1, 1, '2025-09-09'),
(2, 2, '2025-09-10'),
(3, 3, '2025-09-12'),
(4, 4, '2025-09-12'),
(5, 5, '2025-09-13');

-- CartItems
INSERT INTO CartItem (CartID, BookID, Quantity) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 4, 1),
(3, 5, 2),
(4, 2, 1),
(4, 4, 1),
(5, 1, 1),
(5, 5, 1);

-- Orders
INSERT INTO `Order` (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1, 1, '2025-09-10', 50.00),
(2, 2, '2025-09-11', 25.00),
(3, 3, '2025-09-12', 64.00),
(4, 4, '2025-09-13', 43.00),
(5, 5, '2025-09-13', 48.00);

-- OrderItems
INSERT INTO OrderItem (OrderID, BookID, Quantity, Price) VALUES
(1, 1, 1, 20.00),
(1, 3, 2, 15.00),
(2, 2, 1, 25.00),
(3, 4, 2, 18.00),
(3, 5, 1, 28.00),
(4, 2, 1, 25.00),
(4, 4, 1, 18.00),
(5, 1, 1, 20.00),
(5, 5, 1, 28.00);

-- Payments
INSERT INTO Payment (PaymentID, OrderID, Amount, Method, PaymentDate) VALUES
(1, 1, 50.00, 'Credit', '2025-09-10'),
(2, 2, 25.00, 'PayPal', '2025-09-11'),
(3, 3, 64.00, 'Debit', '2025-09-12'),
(4, 4, 43.00, 'Credit', '2025-09-13'),
(5, 5, 48.00, 'PayPal', '2025-09-13');

-- Reviews
INSERT INTO Review (ReviewID, CustomerID, BookID, Rating, Comment) VALUES
(1, 1, 1, 5, 'Amazing book!'),
(2, 2, 2, 4, 'Great story but a bit long'),
(3, 3, 3, 5, 'Classic mystery!'),
(4, 4, 4, 5, 'A timeless classic!'),
(5, 5, 5, 4, 'Exciting continuation of the series'),
(6, 5, 2, 5, 'Loved this book!');

-- Create SQL View

CREATE VIEW CustomerOrderSummary AS
SELECT 
    c.CustomerID,
    c.Name AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customer c
LEFT JOIN `Order` o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name;

SELECT * FROM CustomerOrderSummary;

-- Monthlysalestrend

CREATE VIEW MonthlySalesTrend AS
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    COUNT(OrderID) AS OrdersCount,
    SUM(TotalAmount) AS TotalSales
FROM `Order`
GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
ORDER BY Month;

SELECT * FROM MonthlySalesTrend;


-- Multi Table Joins: -

-- Top Customers by Total Spending

SELECT 
    c.CustomerID,
    c.Name AS CustomerName,
    SUM(o.TotalAmount) AS TotalSpent,
    RANK() OVER (ORDER BY SUM(o.TotalAmount) DESC) AS SpendingRank
FROM Customer c
JOIN `Order` o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name
ORDER BY TotalSpent DESC;

-- 2. Monthly Sales Trend by Category
SELECT 
    c.CustomerID,
    c.Name AS CustomerName,
    SUM(o.TotalAmount) AS TotalSpent,
    CASE 
        WHEN SUM(o.TotalAmount) >= 100 THEN 'Platinum'
        WHEN SUM(o.TotalAmount) >= 50 THEN 'Gold'
        ELSE 'Silver'
    END AS LoyaltyTier
FROM Customer c
LEFT JOIN `Order` o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name
ORDER BY TotalSpent DESC;

-- Customer Loyalty Tier

SELECT 
    c.CustomerID,
    c.Name AS CustomerName,
    SUM(o.TotalAmount) AS TotalSpent,
    CASE 
        WHEN SUM(o.TotalAmount) >= 100 THEN 'Platinum'
        WHEN SUM(o.TotalAmount) >= 50 THEN 'Gold'
        ELSE 'Silver'
    END AS LoyaltyTier
FROM Customer c
LEFT JOIN `Order` o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name
ORDER BY TotalSpent DESC;

-- Books Never Ordered

SELECT b.BookID, b.Title
FROM Book b
WHERE b.BookID NOT IN (
    SELECT DISTINCT BookID 
    FROM OrderItem
);

-- Top-3 best selling books

SELECT 
    b.BookID,
    b.Title,
    SUM(oi.Quantity) AS TotalSold,
    RANK() OVER (ORDER BY SUM(oi.Quantity) DESC) AS BookRank
FROM Book b
JOIN OrderItem oi ON b.BookID = oi.BookID
GROUP BY b.BookID, b.Title
ORDER BY BookRank
LIMIT 3;









