CREATE DATABASE OnlineBookstore;
USE OnlineBookstore;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Books
WHERE Genre='Fiction';
SELECT * FROM Books
WHERE published_year>1950;
SELECT * FROM Customers
WHERE country='Canada';
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';
SELECT SUM(STOCK) AS Total_stock
FROM Books;
SELECT * FROM Books
ORDER BY price DESC LIMIT 1;
SELECT * FROM Orders
WHERE quantity > 1;
SELECT * FROM Orders
WHERE total_amount > 20;
SELECT DISTINCT genre FROM Books;
SELECT * FROM Books
ORDER BY stock
LIMIT 1 ;
SELECT SUM(total_amount) AS REVENUE
FROM Orders;
SELECT * FROM ORDERS;
SELECT b.genre, SUM(o.quantity) AS total_books_sold
FROM orders O
JOIN Books b ON O.book_id=b.book_id
GROUP BY b.genre
SELECT AVG(price) AS average_price
FROM books
WHERE genre = 'Fantasy';
SELECT customer_id , COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) >=2;
SELECT o.customer_id ,c.name, COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY customer_id, c.name
HAVING COUNT(order_id) >=2;
SELECT book_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY book_id
ORDER BY order_count DESC LIMIT 1;
SELECT o.book_id,b.title,COUNT(o.order_id) AS order_count
FROM orders o 
JOIN books b ON b.book_id=o.book_id
GROUP BY book_id,b.title
ORDER BY order_count DESC LIMIT 1;
SELECT *
FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC LIMIT 3;
SELECT b.author, SUM(o.quantity) AS total_books_sold
FROM orders o 
JOIN books b ON b.book_id=o.book_id
GROUP BY b.author;
SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE total_amount > 30;
SELECT c.customer_id,c.name,SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name 
ORDER BY total_spent DESC LIMIT 1;
SELECT b.book_id, b.title, b.stock, coalesce(SUM(o.quantity), 0) AS order_quantity,b.stock-coalesce(SUM(o.quantity), 0) AS ramaining_quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;