DROP DATABASE IF EXISTS `GrocerEase`;

CREATE DATABASE GrocerEase;
USE GrocerEase;

DROP TABLE IF EXISTS `Customers`;
CREATE TABLE Customers(
	CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
    LastName VARCHAR(50),
    LoginID VARCHAR(50) NOT NULL,
    Customer_Password VARCHAR(50) NOT NULL,
    AddressLine1 VARCHAR(100) NOT NULL,
    AddressLine2 VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    pin_code VARCHAR(6) NOT NULL,
    CONSTRAINT pin_code_length CHECK (LENGTH(pin_code) = 6 AND pin_code REGEXP '^[0-9]+$'),
    Age INT NOT NULL CHECK (Age > 0),
    PhoneNumber BIGINT NOT NULL CHECK (PhoneNumber >=1000000000 AND PhoneNumber < 10000000000)
)AUTO_INCREMENT=1;


DROP TABLE IF EXISTS `Offline_Stores`;

CREATE TABLE Offline_Stores (
    storeID INT PRIMARY KEY NOT NULL,
    AddressLine1 VARCHAR(100) NOT NULL,
    AddressLine2 VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    zip_code VARCHAR(6) NOT NULL,
    CONSTRAINT zip_code_length CHECK (LENGTH(zip_code) = 6 AND zip_code REGEXP '^[0-9]+$')
);

DROP TABLE IF EXISTS `DeliveryAgent`;
CREATE TABLE DeliveryAgent(
	AgentID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    AgentName VARCHAR(100) NOT NULL,
    PhoneNumber BIGINT NOT NULL CHECK (PhoneNumber >= 1000000000 AND PhoneNumber < 10000000000),
    StoreID INT NOT NULL,
    FOREIGN KEY (StoreID) REFERENCES Offline_Stores(StoreID)
)AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `Admin`;

CREATE TABLE Admin (
    AdminID INT PRIMARY KEY NOT NULL,
    admin_pwd VARCHAR(10) NOT NULL,
    StoreID INT NOT NULL,
    FOREIGN KEY (StoreID) REFERENCES Offline_Stores(StoreID)
);

DROP TABLE IF EXISTS `Inventory`;

CREATE TABLE Inventory (
    itemID INT AUTO_INCREMENT NOT NULL,
    storeID INT NOT NULL,
    ItemName VARCHAR(50) NOT NULL,
    Unit VARCHAR(50) NOT NULL,
    PRIMARY KEY (itemID, StoreID),
    FOREIGN KEY (storeID) REFERENCES Offline_Stores(storeID),
    price INT NOT NULL,
    stock INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    itemDescription VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS Supplier;
CREATE TABLE Supplier (
    Supplier_ID  INT auto_increment PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    AddressLine1 VARCHAR(100) NOT NULL,
    AddressLine2 VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    PIN_code CHAR(6) NOT NULL
)AUTO_INCREMENT=1;

DROP TABLE IF EXISTS `Orders`;

CREATE TABLE Orders(
    OrderID INT auto_increment PRIMARY KEY NOT NULL,
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    OrderStatus VARCHAR(20) NOT NULL
)AUTO_INCREMENT=1;

CREATE TABLE Reviews (
    OrderID INT,
    stars INT,
    description VARCHAR(255),
    PRIMARY KEY (OrderID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

DROP TABLE IF EXISTS `Wallet`;
CREATE TABLE Wallet(
	CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    Balance FLOAT CHECK (Balance >= 0),
    UPI_ID VARCHAR(20) NOT NULL
);

drop table if exists Cart;
create table Cart(
    Cart_ID INT primary key,
    Customer_ID Int not null,
    FOREIGN KEY (Customer_ID) references Customers(CustomerID),
    Item_ID INT,
    Quantity INT
);

INSERT INTO Offline_Stores (storeID, AddressLine1, AddressLine2, city, state, country, zip_code) VALUES
(1, '1, Anand Bai Keni Compd', 'Datta Mandir X Rd, Kandivli', 'Mumbai', 'Maharashtra', 'India', '400067'),
(2, '7, Laxmi Tower Lsc', 'Sector 10, Patel Nagar', 'New Delhi', 'Delhi', 'India', '110034'),
(3, '399,Street-24', 'Hebbal', 'Bangalore', 'Karnataka', 'India', '560024'),
(4, '111, Industrial Area', 'Sion East', 'Mumbai', 'Maharashtra', 'India', '400022'),
(5, 'Kaderi Chawl, Andheri Kurla Road', 'Andheri (west)', 'Mumbai', 'Maharashtra', 'India', '400072'),
(6, '8, Mayur Kunj, Liberty Garden', 'Rd No 4, Malad', 'Mumbai', 'Maharashtra', 'India', '400064'),
(7, '225, Bombay Talkies Compound', 'Dadiseth Road, Nr Lokseva Transport, Malad', 'Mumbai', 'Maharashtra', 'India', '400064'),
(8, 'Lohana Sanitorium, Sanitorium Lane', 'Ghatkopar (west)', 'Mumbai', 'Maharashtra', 'India', '400086'),
(9, '2085, Sector 16', 'Faridabad', 'Delhi NCR', 'Haryana', 'India', '121001'),
(10, 'Gala No 213, Creative Indu Estate', 'N.m. Joshi Marg, Lower Parel', 'Mumbai', 'Maharashtra', 'India', '400013');

INSERT INTO Admin (AdminID, admin_pwd, StoreID) VALUES
(101, 'pass123', 3),
(102, 'adminpass', 7),
(103, 'securepwd', 2),
(104, 'admin1234', 5),
(105, 'pwd123', 1),
(106, 'admin@123', 8),
(107, 'pass@123', 6),
(108, '1234admin', 4),
(109, 'admin_123', 10),
(110, 'securepass', 9);

INSERT INTO Customers (FirstName, MiddleName, LastName, LoginID, Customer_Password, AddressLine1, AddressLine2, City, State, Country, pin_code, Age, PhoneNumber) VALUES
('John', 'Doe', 'Smith', 'john_smith', 'password123', '123 Main Street', 'Apt 5', 'Mumbai', 'Maharashtra', 'India', '400001', 25, 9876543210),
('Alice', 'Eve', 'Johnson', 'alice_johnson', 'securepass', '456 Park Avenue', 'Flat 12', 'Delhi', 'Delhi', 'India', '110001', 30, 8765432109),
('David', 'Michael', 'Brown', 'david_brown', 'brown123', '789 Crescent Road', 'Block B', 'Mumbai', 'Maharashtra', 'India', '400002', 28, 7654321098),
('Priya', 'Raj', 'Singh', 'priya_singh', 'singh456', '101 Green Valley', 'Floor 3', 'Delhi', 'Delhi', 'India', '110002', 22, 6543210987),
('Rahul', 'Kumar', 'Verma', 'rahul_verma', 'verma789', '234 Lake View', 'Tower 7', 'Mumbai', 'Maharashtra', 'India', '400003', 35, 5432109876),
('Neha', 'Sharma', 'Gupta', 'neha_gupta', 'gupta@123', '567 Hill Street', 'Unit 8', 'Delhi', 'Delhi', 'India', '110003', 29, 4321098765),
('Amit', 'Singh', 'Yadav', 'amit_yadav', 'yadavpass', '789 Skyline Avenue', 'Apartment 15', 'Mumbai', 'Maharashtra', 'India', '400004', 27, 3210987654),
('Anita', 'Mishra', 'Joshi', 'anita_joshi', 'anita123', '876 River Side', 'Flat 2B', 'Delhi', 'Delhi', 'India', '110004', 32, 2109876543),
('Vikram', 'Gupta', 'Sinha', 'vikram_sinha', 'sinha456', '345 Maple Lane', 'Suite 10', 'Mumbai', 'Maharashtra', 'India', '400005', 26, 1098765432),
('Sanya', 'Reddy', 'Kumar', 'sanya_kumar', 'reddypass', '678 Forest View', 'Villa 3', 'Delhi', 'Delhi', 'India', '110005', 31, 9876543210),
('Aditya', 'Kumar', 'Shah', 'aditya_shah', 'shah@123', '456 Sea View', 'Apartment 7', 'Mumbai', 'Maharashtra', 'India', '400006', 33, 8765432109),
('Ritu', 'Verma', 'Goyal', 'ritu_goyal', 'goyal456', '789 Sunrise Avenue', 'Flat 3C', 'Delhi', 'Delhi', 'India', '110006', 28, 7654321098),
('Kunal', 'Mehta', 'Singh', 'kunal_singh', 'singh789', '101 Sky Scraper', 'Floor 15', 'Mumbai', 'Maharashtra', 'India', '400007', 25, 6543210987),
('Neha', 'Chopra', 'Agarwal', 'neha_agarwal', 'agarwal@123', '234 Hill Top', 'Tower 4', 'Delhi', 'Delhi', 'India', '110007', 29, 5432109876),
('Rahul', 'Saxena', 'Yadav', 'rahul_yadav', 'yadavpass', '567 Ocean View', 'Suite 20', 'Mumbai', 'Maharashtra', 'India', '400008', 26, 4321098765),
('Amit', 'Joshi', 'Gupta', 'amit_gupta', 'gupta456', '789 Palm Lane', 'Unit 11', 'Delhi', 'Delhi', 'India', '110008', 32, 3210987654),
('Vidya', 'Nair', 'Sinha', 'vidya_sinha', 'sinha@123', '876 Green Hills', 'Flat 4B', 'Mumbai', 'Maharashtra', 'India', '400009', 27, 2109876543),
('Sandeep', 'Rai', 'Sharma', 'sandeep_sharma', 'sharma789', '345 River Side', 'Villa 5', 'Delhi', 'Delhi', 'India', '110009', 34, 1098765432),
('Anjali', 'Gupta', 'Verma', 'anjali_verma', 'verma456', '678 Silver Street', 'Apartment 9', 'Mumbai', 'Maharashtra', 'India', '400010', 30, 9876543210),
('Vivek', 'Yadav', 'Kumar', 'vivek_kumar', 'kumar@123', '901 Gold Plaza', 'Floor 8', 'Delhi', 'Delhi', 'India', '110010', 31, 8765432109);

INSERT INTO Supplier (Name, AddressLine1, AddressLine2, City, State, Country, PIN_code) VALUES
( 'Green Fields Organic', 'Warehouse 1, Industrial Area', 'Sector 5', 'Mumbai', 'Maharashtra', 'India', '400021'),
( 'Health Essentials Distributors', 'Market Plaza, Main Road', 'District 3C', 'Delhi', 'Delhi', 'India', '110022'),
( 'Fresh Harvest Distribution Center', 'Warehouse 2, Outer Ring Road', 'Zone 12', 'Bangalore', 'Karnataka', 'India', '560022'),
( 'Eco-Friendly Stationary Hub', 'Market Street, Central Area', 'Block B', 'Chennai', 'Tamil Nadu', 'India', '600022'),
( 'Nature Beauty Products Depot', 'Warehouse 3, Beauty Avenue', 'District 10', 'Kolkata', 'West Bengal', 'India', '700022'),
( 'Hygiene Haven Logistics Center', 'Warehouse 4, Cleanliness Road', 'Sector C', 'Hyderabad', 'Telangana', 'India', '500022'),
( 'Organic Shampoo Distribution', 'Market Square, Health Lane', 'Zone 17', 'Pune', 'Maharashtra', 'India', '411022'),
( 'Fresh Veggie Wholesale Center', 'Warehouse 5, Vegetable Lane', 'Area 6', 'Ahmedabad', 'Gujarat', 'India', '380022'),
( 'Healthy Living Products Depot', 'Warehouse 6, Wellness Street', 'Zone 10', 'Jaipur', 'Rajasthan', 'India', '302022'),
( 'Fruitful Delights Wholesale Hub', 'Market Plaza, Fruit Avenue', 'District 8', 'Chandigarh', 'Punjab', 'India', '160022');

INSERT INTO DeliveryAgent (AgentName, PhoneNumber, StoreID) VALUES
('Aarav Sharma', 9876543210, 5),
('Advait Gupta', 8765432109, 3),
('Vivaan Patel', 7654321098, 2),
('Arjun Singh', 7543210987, 4),
('Vihaan Kumar', 8432109876, 1),
('Reyansh Reddy', 7321098765, 6),
('Aryan Malhotra', 9210987654, 9),
('Rudra Khanna', 8109876543, 8),
('Ayaan Kapoor', 8098765432, 7),
('Kabir Mehta', 9876543210, 10);

INSERT INTO Inventory (storeID, ItemName, Unit, price, stock, category, itemDescription)
VALUES
    -- Fruits
    (1, 'Kashmir Apples', 'per 500 gms', 93, 100, 'Fruits', 'Fresh and juicy apples from Kashmir'),
    (10, 'Bananas', 'per 3 pieces', 45, 150, 'Fruits', 'Ripe bananas for a healthy snack'),
    (3, 'Valencia Oranges', 'per kg', 200, 80, 'Fruits', 'Sweet and tangy oranges'),
    (4, 'Pear', '3 pieces', 300, 80, 'Fruits', 'Green and yummy pears'),
    (3, 'Kiwis', 'per peice', 40, 80, 'Fruits', 'Yummy kiwis for a healthy you'),

    -- Vegetables
    (5, 'Carrot-Red', 'per 500 gms', 13, 120, 'Vegetables', 'Crunchy and nutritious carrots'),
    (7, 'Broccoli', 'per piece', 40, 90, 'Vegetables', 'Fresh and green broccoli heads'),
    (8, 'Tomatos', 'per piece', 40, 90, 'Vegetables', 'Fresh red tomatoes from the farm'),

    -- Hair care products
    (4, 'Loreal Paris Shampoo', 'per bottle: 500ml', 300, 50, 'Hair Care', 'Gentle and nourishing shampoo'),
    (1, 'Mama Earth Anti Hair fall Conditioner', 'per bottle: 500ml', 500, 60, 'Hair Care', 'Deep conditioning for smooth hair'),
    (1, 'Mama Earth Anti Hair fall Shampoo', 'per bottle: 500ml', 250, 60, 'Hair Care', 'Shampoo for smooth hair'),
    (3, 'Johnsons Hair oil', 'per bottle: 150ml', 89, 60, 'Hair Care', 'hair oil for smooth hair'),

    -- Stationary items
    (10, 'Classmate Notebook', '172 pges', 60, 100, 'Stationery', 'Spiral-bound smooth notebook for writing'),
    (8, 'Rorito Ballpoint Pens', 'Pack of 5', 30, 150, 'Stationery', 'Pack of ballpoint pens for everyday use'),
    (7, 'Apsara Scale', '1 scale', 10, 150, 'Stationery', '15 cm scale for everyday use'),
    (5, 'Nataraja Pencils', 'Pack of 10 pencils', 50, 150, 'Stationery', 'HB pencils for a good handwriting'),

    -- Health and hygiene products
    (9, 'Dettol Hand Sanitizer', '50ml', 25, 80, 'Health and Hygiene', 'Alcohol-based hand sanitizer for germ free hands'),
    (2, 'Colgate Whitening Toothpaste', '150gm per tube', 90, 120, 'Health and Hygiene', 'Trusted toothpaste for oral care'),
    (6, 'Stayfree Sanitary Napkins', 'Pack of 20 pads', 150, 120, 'Health and Hygiene', 'Cotton sanitary napkins for good hygiene'),
    (7, 'Plastic Gala Broom', '1 piece', 150, 120, 'Health and Hygiene', 'gala broom with plastic bricels for deep cleaning');

INSERT INTO Wallet (CustomerID, Balance, UPI_ID) VALUES
(1, 10000.00, '9876543210@paytm'),
(2, 15000.00, '8765432109@paytm'),
(3, 0.00, '7654321098@paytm'),
(4, 8000.00, '6543210987@paytm'),
(5, 20000.00, '5432109876@paytm'),
(6, 0.00, '4321098765@paytm'),
(7, 11000.00, '3210987654@paytm'),
(8, 7500.00, '2109876543@paytm'),
(9, 0.00, '1098765432@paytm'),
(10, 13000.00, '9876543210@paytm'),
(11, 14000.00, '8765432109@paytm'),
(12, 0.00, '7654321098@paytm'),
(13, 18000.00, '6543210987@paytm'),
(14, 8500.00, '5432109876@paytm'),
(15, 0.00, '4321098765@paytm'),
(16, 0.00, '3210987654@paytm'),
(17, 10500.00, '2109876543@paytm'),
(18, 0.00, '1098765432@paytm'),
(19, 13500.00, '9876543210@paytm'),
(20, 0.00, '8765432109@paytm');

INSERT INTO Orders (CustomerID, OrderStatus) VALUES
(1, 'Shipped'),
(2, 'Delivered'),
(3, 'Processing'),
(4, 'Cancelled'),
(15, 'Shipped'),
(7, 'Delivered'),
(8, 'Shipped'),
(10, 'Processing'),
(11, 'Shipped'),
(13, 'Delivered');

INSERT INTO Reviews (OrderID, stars, description) VALUES
(1, 5, 'Excellent service and product quality.'),
(2, 4, 'Fast delivery but product packaging could be better.'),
(3, 3, 'Average experience, delivery was delayed.'),
(5, 5, 'Very satisfied with the product and delivery.'),
(7, 4, 'Good service overall, would recommend.');

INSERT INTO Cart (Cart_ID, Customer_ID, Item_ID, Quantity) VALUES
(1, 1, NULL, NULL),
(2, 2, NULL, NULL),
(3, 3, NULL, NULL),
(4, 4, NULL, NULL),
(5, 5, NULL, NULL),
(6, 6, NULL, NULL),
(7, 7, NULL, NULL),
(8, 8, NULL, NULL),
(9, 9, NULL, NULL),
(10, 10, NULL, NULL),
(11, 11, NULL, NULL),
(12, 12, NULL, NULL),
(13, 13, NULL, NULL),
(14, 14, NULL, NULL),
(15, 15, NULL, NULL),
(16, 16, NULL, NULL),
(17, 17, NULL, NULL),
(18, 18, NULL, NULL),
(19, 19, NULL, NULL),
(20, 20, NULL, NULL);