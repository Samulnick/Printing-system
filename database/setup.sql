-- PrintPro Database Setup Script
-- Run this SQL to create all required tables for the PrintPro e-commerce system

-- Create database
CREATE DATABASE IF NOT EXISTS printpro_db;
USE printpro_db;

-- Drop existing tables if they exist (for fresh setup)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;

-- Create categories table
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create products table
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image VARCHAR(255),
    stock_quantity INT DEFAULT 0,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    INDEX idx_category (category_id),
    INDEX idx_status (status)
);

-- Create customers table
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email)
);

-- Create orders table
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id VARCHAR(100) UNIQUE NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    tax DECIMAL(10, 2) NOT NULL,
    shipping DECIMAL(10, 2) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE INDEX idx_order_id (order_id),
    INDEX idx_email (email),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
);

-- Create order_items table
CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id VARCHAR(100) NOT NULL,
    product_id INT,
    product_name VARCHAR(200) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    INDEX idx_order_id (order_id)
);

-- Insert sample categories
INSERT INTO categories (name, description) VALUES
('Business Cards', 'Professional business card printing'),
('Flyers', 'Eye-catching flyer designs and printing'),
('Brochures', 'Tri-fold and multi-page brochures'),
('Labels', 'Custom label printing for products'),
('Banners', 'Large format banner printing'),
('Posters', 'High-quality poster printing');

-- Insert sample products
INSERT INTO products (category_id, product_name, description, price, stock_quantity, status) VALUES
(1, 'Standard Business Cards', '500 business cards with premium cardstock', 5000, 50, 'active'),
(1, 'Luxury Business Cards', 'Premium embossed business cards with foil stamping', 12000, 30, 'active'),
(2, 'A4 Flyers (100 pcs)', '100 A4 flyers with glossy finish', 3000, 75, 'active'),
(2, 'A5 Flyers (250 pcs)', '250 A5 flyers with matte finish', 4500, 60, 'active'),
(3, 'A4 Tri-fold Brochure', 'Professional tri-fold brochure printing', 8000, 40, 'active'),
(3, 'A5 Booklet', '20-page A5 booklet with staple binding', 15000, 25, 'active'),
(4, 'Product Labels (Sheet)', 'Custom product labels on adhesive sheets', 2000, 100, 'active'),
(4, 'Roll Labels', 'Continuous roll labels for high-volume printing', 6000, 50, 'active'),
(5, 'Small Banner (3x2ft)', '3 feet by 2 feet vinyl banner', 10000, 20, 'active'),
(5, 'Large Banner (6x4ft)', '6 feet by 4 feet vinyl banner with grommets', 25000, 15, 'active'),
(6, 'A3 Poster (20 pcs)', '20 A3 size posters with vibrant colors', 5000, 45, 'active'),
(6, 'A2 Poster (10 pcs)', '10 A2 size posters premium quality', 8000, 30, 'active');

-- Create indexes for better query performance
CREATE INDEX idx_orders_customer_email ON orders(email);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_active ON products(status);

-- Display confirmation
SELECT 'Database setup completed successfully!' as Status;
