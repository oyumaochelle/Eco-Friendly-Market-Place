-- Create a database
CREATE DATABASE IF NOT EXISTS eco_friendly_marketplace;

-- Use the created database
USE eco_friendly_marketplace;

-- Create a users table for both buyers and sellers
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    user_type ENUM('buyer', 'seller') NOT NULL
);

-- Create a products table to store eco-friendly products
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    seller_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(20) NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES users(user_id)
);

-- Create an orders table to store buyer's purchase history
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    buyer_id INT NOT NULL,
    product_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (buyer_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample users (you can remove these in a real application)
INSERT INTO users (email, password, user_type) VALUES
('buyer@example.com', 'hashed_password', 'buyer'),
('seller@example.com', 'hashed_password', 'seller');

-- Insert sample product (you can remove this in a real application)
INSERT INTO products (seller_id, product_name, description, price, contact_email, contact_phone) VALUES
(2, 'Eco-Friendly Product 1', 'Description of the product 1', 29.99, 'seller@example.com', '+123456789');
