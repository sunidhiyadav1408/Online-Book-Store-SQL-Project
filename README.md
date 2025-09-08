# 📚 Online Bookstore SQL Project (MySQL)  

This project is a **SQL-based Online Bookstore Database System** built using **MySQL**.  
It demonstrates how relational databases are designed, populated, and queried to analyze and manage data.  

The project uses **dummy CSV data** for Books, Customers, and Orders. Data was imported into MySQL using the **MySQL Workbench Import Wizard**.  

The purpose of this project is to practice **database design, importing data, and writing SQL queries (basic and advanced)** to solve business-oriented problems.  

---

## 🚀 Project Overview  

- **Books Table** – Stores book details (title, author, genre, year, price, stock).  
- **Customers Table** – Stores customer details (name, email, phone, city, country).  
- **Orders Table** – Stores orders (order date, book purchased, quantity, total amount).  


---



## SQL Queries

```sql
-- ========================
-- 🔹 Basic Queries
-- ========================

-- Question 1: Retrieve all books in the "Fiction" genre
SELECT * FROM Books 
WHERE Genre = 'Fiction';

-- Question 2: Find books published after the year 1950
SELECT * FROM Books 
WHERE Published_Year > 1950;

-- Question 3: List all customers from Canada
SELECT * FROM Customers 
WHERE Country = 'Canada';

-- Question 4: Show orders placed in November 2023
SELECT * FROM Orders 
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- Question 5: Retrieve the total stock of books available
SELECT SUM(Stock) AS Total_Stock 
FROM Books;

-- Question 6: Find the details of the most expensive book
SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;

-- Question 7: Show all customers who ordered more than 1 quantity of a book
SELECT * FROM Orders 
WHERE Quantity > 1;

-- Question 8: Retrieve all orders where the total amount exceeds $20
SELECT * FROM Orders 
WHERE Total_Amount > 20;

-- Question 9: List all genres available in the Books table
SELECT DISTINCT Genre 
FROM Books;

-- Question 10: Find the book with the lowest stock
SELECT * FROM Books 
ORDER BY Stock 
LIMIT 1;

-- Question 11: Calculate the total revenue generated from all orders
SELECT SUM(Total_Amount) AS Revenue 
FROM Orders;


---


-- ========================
-- 🔹 Advanced Queries
-- ========================

-- Question 1: Retrieve the total number of books sold for each genre
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre;

-- Question 2: Find the average price of books in the "Fantasy" genre
SELECT AVG(Price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- Question 3: List customers who have placed at least 2 orders
SELECT o.Customer_ID, c.Name, COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- Question 4: Find the most frequently ordered book
SELECT o.Book_ID, b.Title, COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY Order_Count DESC 
LIMIT 1;

-- Question 5: Show the top 3 most expensive books of 'Fantasy' genre
SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC 
LIMIT 3;

-- Question 6: Retrieve the total quantity of books sold by each author
SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author;

-- Question 7: List the cities where customers who spent over $30 are located
SELECT DISTINCT c.City, o.Total_Amount
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Total_Amount > 30;

-- Question 8: Find the customer who spent the most on orders
SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS Total_Spent
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spent DESC 
LIMIT 1;

-- Question 9: Calculate the stock remaining after fulfilling all orders
SELECT b.Book_ID, b.Title, b.Stock, 
       COALESCE(SUM(o.Quantity), 0) AS Ordered_Quantity,
       b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Quantity
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID 
ORDER BY b.Book_ID;
