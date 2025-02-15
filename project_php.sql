CREATE DATABASE ecommerce;
USE ecommerce;


CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    address TEXT
);


INSERT INTO customers 
VALUES 
    (NULL, 'mohammad', 'mohammad@gmail.com', 'mohammad@#123AA', '123-546-9995', NULL, NULL, 'Aqaba/Jordan'),
    (NULL, 'ahmed', 'ahmed@gmail.com', 'ahmed@#123AA', '173-854-2295', NULL, NULL, 'Aqaba/Jordan'),
    (NULL, 'omar', 'omar@gmail.com', 'omar@#993AA', '173-994-2315', NULL, NULL, 'Amman/Jordan'),
    (NULL, 'ali', 'ali@gmail.com', 'ali@%99FA', '122-324-7655', NULL, NULL, 'Amman/Jordan'),
    (NULL, 'hamed', 'hamed@gmail.com', 'hamed@%9LLA', '131-314-7886', NULL, NULL, 'Amman/Jordan'),
    (NULL, 'saba', 'saba@gmail.com', 'saba@#ddA', '139-424-7996', NULL, NULL, 'Aqaba/Jordan'),
    (NULL, 'eyad', 'eyad@gmail.com', 'eyad&54A', '188-422-1116', NULL, NULL, 'Aqaba/Jordan'),
    (NULL, 'abd', 'abd@gmail.com', 'abd!45A', '186-985-7356', NULL, NULL, 'Aqaba/Jordan'),
    (NULL, 'kamal', 'kamal@gmail.com', 'kamal!45A', '186-876-1252', NULL, NULL, 'Irbid/Jordan'),
    (NULL, 'sanad', 'sanad@gmail.com', 'sanad&%gF', '186-666-7676', NULL, NULL, 'Irbid/Jordan');



/*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_method VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Payment (payment_method, amount) VALUES 
('Credit Card', 150.75),
('PayPal', 200.00),
('Bank Transfer', 500.50),
('Cash', 100.00),
('Debit Card', 75.25);



/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    description TEXT
);

INSERT INTO Categories (category_name, description) VALUES 
('Classic Suits', 'Elegant formal suits for business and special occasions'),
('Casual Blazers', 'Stylish and comfortable blazers for a smart-casual look'),
('Tuxedos', 'Premium tuxedos for weddings and black-tie events'),
('Shirts', 'High-quality dress shirts in various styles and colors'),
('Ties & Bowties', 'A variety of ties and bowties to complete the perfect look'),
('Shoes', 'Formal leather shoes, loafers, and dress shoes'),
('Accessories', 'Cufflinks, pocket squares, and stylish belts'),
('Winter Collection', 'Wool suits, overcoats, and scarves for the cold season'),
('Summer Collection', 'Lightweight suits and breathable fabrics for warm weather'),
('Wedding Packages', 'Complete suit sets for grooms and groomsmen');

 
 
 /*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    stock_quantity INT NOT NULL,
    image_url VARCHAR(255),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

INSERT INTO Product (name, price, description, stock_quantity, image_url, category_id)
VALUES
('Slim Fit Suit', 199.99, 'Elegant slim fit suit, perfect for formal occasions.', 50, 'images/slim_fit_suit.jpg', 1),
('Classic Black Suit', 249.99, 'Timeless black suit with premium fabric.', 40, 'images/classic_black_suit.jpg', 1),
('Formal Dress Shirt', 49.99, 'Cotton dress shirt with a crisp finish.', 100, 'images/formal_dress_shirt.jpg', 2),
('Tuxedo Jacket', 299.99, 'Luxury tuxedo jacket for special events.', 30, 'images/tuxedo_jacket.jpg', 1),
('Tailored Blazer', 179.99, 'Modern tailored blazer with a sleek fit.', 60, 'images/tailored_blazer.jpg', 1),
('Dress Pants', 89.99, 'Classic formal pants for office and events.', 80, 'images/dress_pants.jpg', 3),
('Waistcoat Vest', 69.99, 'Stylish waistcoat to complete your suit.', 70, 'images/waistcoat_vest.jpg', 1),
('Silk Tie', 29.99, 'High-quality silk tie for formal outfits.', 150, 'images/silk_tie.jpg', 4),
('Leather Dress Shoes', 129.99, 'Elegant leather shoes for a refined look.', 40, 'images/leather_dress_shoes.jpg', 5),
('Cufflinks Set', 39.99, 'Premium cufflinks set for a professional finish.', 200, 'images/cufflinks_set.jpg', 6);

/* //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('pending', 'completed', 'canceled') DEFAULT 'pending',
    total_amount DECIMAL(10,2) NOT NULL,
    customer_id INT,
    payment_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (payment_id) REFERENCES Payment(payment_id) ON DELETE SET NULL
);

INSERT INTO Orders (order_date, total_amount, customer_id, payment_id) 
VALUES
('2025-02-15 12:00:00', 299.99, 1, 1),
('2025-02-16 14:00:00', 499.99, 2, 2),
('2025-02-17 16:30:00', 749.99, 3, 3),
('2025-02-18 10:45:00', 149.99, 4, 4),
('2025-02-19 09:15:00', 129.99, 5, 5),
('2025-02-20 18:00:00', 399.99, 6, 1),
('2025-02-21 13:30:00', 199.99, 7, 2),
('2025-02-22 11:20:00', 649.99, 8, 3),
('2025-02-23 15:00:00', 279.99, 9, 4),
('2025-02-24 17:40:00', 89.99, 10, 5);

/* /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// */


CREATE TABLE Order_items (
    order_items_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    subtotal_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);
INSERT INTO Order_items (order_id, product_id, subtotal_price, quantity) 
VALUES
(1, 1, 199.99, 1),
(1, 2, 249.99, 1),
(2, 3, 49.99, 2),
(2, 4, 299.99, 1),
(3, 5, 179.99, 2),
(3, 6, 89.99, 3),
(4, 7, 69.99, 1),
(5, 8, 29.99, 3),
(6, 9, 39.99, 1),
(7, 10, 129.99, 2);




/* //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

