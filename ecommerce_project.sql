Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> DROP DATABASE IF EXISTS ecommerce_db;
Query OK, 5 rows affected (0.06 sec)

mysql> CREATE DATABASE ecommerce_db;
Query OK, 1 row affected (0.01 sec)

mysql> USE ecommerce_db;CREATE TABLE users (
Database changed
    ->     user_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(100) NOT NULL,
    ->     email VARCHAR(100) UNIQUE NOT NULL,
    ->     password VARCHAR(100) NOT NULL,
    ->     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE categories (
    ->     category_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     category_name VARCHAR(100) NOT NULL UNIQUE
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE products (
    ->     product_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     product_name VARCHAR(150) NOT NULL,
    ->     price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    ->     stock INT NOT NULL CHECK (stock >= 0),
    ->     category_id INT,
    ->     FOREIGN KEY (category_id) REFERENCES categories(category_id)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE orders (
    ->     order_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     user_id INT,
    ->     order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ->     FOREIGN KEY (user_id) REFERENCES users(user_id)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE order_items (
    ->     order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     order_id INT,
    ->     product_id INT,
    ->     quantity INT NOT NULL CHECK (quantity > 0),
    ->     price DECIMAL(10,2) NOT NULL,
    ->     FOREIGN KEY (order_id) REFERENCES orders(order_id),
    ->     FOREIGN KEY (product_id) REFERENCES products(product_id)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> INSERT INTO users (name, email, password) VALUES
    -> ('Shiva', 'shiva@gmail.com', '123'),
    -> ('Ram', 'ram@gmail.com', '456'),
    -> ('Krishna', 'krishna@gmail.com', '789');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO categories (category_name) VALUES
    -> ('Clothing'),
    -> ('Electronics'),
    -> ('Arts');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO products (product_name, price, stock, category_id) VALUES
    -> ('T-Shirt', 25.00, 50, 1),
    -> ('Laptop', 800.00, 10, 2),
    -> ('Painting Kit', 40.00, 20, 3);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> INSERT INTO orders (user_id) VALUES (1);
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO order_items (order_id, product_id, quantity, price)
    -> VALUES
    -> (1, 2, 1, 800.00),
    -> (1, 3, 2, 40.00);
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> UPDATE products SET stock = stock - 1 WHERE product_id = 2;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE products SET stock = stock - 2 WHERE product_id = 3;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> COMMIT;SELECT o.order_id, u.name, o.order_date
Query OK, 0 rows affected (0.01 sec)

    -> FROM orders o
    -> INNER JOIN users u ON o.user_id = u.user_id;
+----------+-------+---------------------+
| order_id | name  | order_date          |
+----------+-------+---------------------+
|        1 | Shiva | 2026-02-21 20:35:30 |
+----------+-------+---------------------+
1 row in set (0.00 sec)

mysql> SELECT u.name, o.order_id
    -> FROM users u
    -> LEFT JOIN orders o ON u.user_id = o.user_id;
+---------+----------+
| name    | order_id |
+---------+----------+
| Shiva   |        1 |
| Ram     |     NULL |
| Krishna |     NULL |
+---------+----------+
3 rows in set (0.00 sec)

mysql> SELECT u.name, p.product_name, oi.quantity, oi.price
    -> FROM order_items oi
    -> JOIN orders o ON oi.order_id = o.order_id
    -> JOIN users u ON o.user_id = u.user_id
    -> JOIN products p ON oi.product_id = p.product_id;
+-------+--------------+----------+--------+
| name  | product_name | quantity | price  |
+-------+--------------+----------+--------+
| Shiva | Laptop       |        1 | 800.00 |
| Shiva | Painting Kit |        2 |  40.00 |
+-------+--------------+----------+--------+
2 rows in set (0.00 sec)

mysql> SELECT user_id, COUNT(order_id) AS total_orders
    -> FROM orders
    -> GROUP BY user_id;
+---------+--------------+
| user_id | total_orders |
+---------+--------------+
|       1 |            1 |
+---------+--------------+
1 row in set (0.00 sec)

mysql> SELECT user_id, COUNT(order_id) AS total_orders
    -> FROM orders
    -> GROUP BY user_id
    -> HAVING COUNT(order_id) > 0;
+---------+--------------+
| user_id | total_orders |
+---------+--------------+
|       1 |            1 |
+---------+--------------+
1 row in set (0.00 sec)

mysql> CREATE INDEX idx_user_email ON users(email);
Query OK, 0 rows affected (0.07 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>