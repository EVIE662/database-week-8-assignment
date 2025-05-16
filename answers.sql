-- Create the database
CREATE DATABASE GasManagement;
USE GasManagement;

-- Create Suppliers table
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(255),
    UNIQUE(name)
);

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    address VARCHAR(255) NOT NULL
);

-- Create Gas Cylinders table
CREATE TABLE GasCylinders (
    cylinder_id INT AUTO_INCREMENT PRIMARY KEY,
    cylinder_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,  -- Capacity in liters
    price DECIMAL(10, 2) NOT NULL,
    supplier_id INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE CASCADE,
    UNIQUE(cylinder_type, supplier_id)  -- Ensure a cylinder type from the same supplier is unique
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- Create OrderDetails table (to track which cylinders are ordered in an order)
CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    cylinder_id INT NOT NULL,
    quantity INT NOT NULL,
    price_each DECIMAL(10, 2) NOT NULL,  -- Price per cylinder
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (cylinder_id) REFERENCES GasCylinders(cylinder_id) ON DELETE CASCADE
);

-- Create Deliveries table
CREATE TABLE Deliveries (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    delivery_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,  -- e.g., Pending, Delivered, Cancelled
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);

-- Create Payments table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50),  -- e.g., Credit Card, Cash, Bank Transfer
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);

