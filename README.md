E-Commerce Database Project (MySQL)

## Project Overview
This project is a fully normalized E-Commerce Database built using MySQL.  
It demonstrates relational database design, transactions, joins, indexing, and aggregation queries.

This project is created for SQL practice and job preparation.

## Database Design (3NF)

The database is designed using Third Normal Form (3NF) to avoid redundancy and maintain data integrity.

### Tables Included:
- **users** – Stores customer information
- **categories** – Stores product categories
- **products** – Stores product details
- **orders** – Stores customer orders
- **order_items** – Breaks many-to-many relationship between orders and products

## Key Features

✔ Database Creation  
✔ 3NF Normalization  
✔ Primary & Foreign Keys  
✔ Many-to-Many Relationship Handling  
✔ Transactions (ACID Properties)  
✔ INNER JOIN  
✔ LEFT JOIN  
✔ Multiple Table JOIN  
✔ GROUP BY & HAVING  
✔ Indexing for Performance  

## Transaction Example

The project includes a transaction to:

1. Insert a new order
2. Insert order items
3. Update product stock
4. Commit changes

Ensures **Atomicity** — either all steps succeed or none.

## Sample Queries Included

### ✔ INNER JOIN
Retrieve orders with user details.

### ✔ LEFT JOIN
Show all users even if they have no orders.

### ✔ GROUP BY
Count total orders per user.

### ✔ HAVING
Filter users based on number of orders.

## How To Run The Project

1. Open MySQL Command Line Client
2. Run.
