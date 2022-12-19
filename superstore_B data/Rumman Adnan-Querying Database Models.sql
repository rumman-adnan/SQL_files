

create database IF NOT exists superstore;
use superstore;

CREATE TABLE postal_addresses (
postal_code INT (5),
city VARCHAR (30),
state VARCHAR (30),
region VARCHAR (10),
country VARCHAR (10),
PRIMARY KEY (postal_code)
);

ALTER TABLE postal_addresses DROP COLUMN country;

ALTER TABLE postal_addresses ADD COLUMN country VARCHAR(20);

create table customers(
customer_id CHAR (8),
customer_name VARCHAR (40),
segment VARCHAR (25),
postal_code INT (5),

PRIMARY KEY (customer_id),
FOREIGN KEY (postal_code) REFERENCES postal_addresses(postal_code)
);

CREATE TABLE product_categories(
sub_category VARCHAR (30),
category VARCHAR (50),
PRIMARY KEY (sub_category)
);

CREATE TABLE products (
product_id CHAR (15),
product_name VARCHAR (255),
sub_category VARCHAR (100),
sales FLOAT,

PRIMARY KEY (product_id),
FOREIGN KEY (sub_category) REFERENCES product_categories(sub_category)

);

CREATE TABLE orders(

order_id CHAR(14),
order_date DATE,
ship_date DATE,
ship_mode VARCHAR(20),
customer_id CHAR (8),

PRIMARY KEY (order_id),
FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE order_products (
order_id CHAR (14),
product_id CHAR (15),

FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id),
PRIMARY KEY (order_id, product_id)
);

show tables;

INSERT INTO customers VALUES ('CG-12520', 'Claire Gute', 'Consumer', '42420'); 

INSERT INTO postal_addresses VALUES ('42420', 'Henderson', 'Kentucky', 'South', 'United State');
INSERT INTO product_categories VALUES ('Bookcases','Furniture');
-- DELETE FROM product_categories WHERE sub_category = 'Bookcases';
INSERT INTO products VALUES ('FUR-BO-10001798','Bush Somerset Collection Bookcase', 'Bookcases', '261.96');


INSERT INTO orders VALUES ('CA-2017-152156','2017-8-11','2017-11-11','Second Class','CG-12520');
INSERT order_products VALUES ('CA-2017-152156','FUR-BO-10001798'); 

INSERT INTO product_categories VALUES ('Chairs','Furniture');
INSERT INTO products VALUES ('FUR-CH-10000454','Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back', 'Chairs', '731.94');

select * from product_categories;
select * from customers;
INSERT INTO postal_addresses VALUES ('90036', 'Los Angeles', 'California', 'West', 'United States'),('33311', 'Fort Lauderdale', 'Florida','South', 'United States');
INSERT INTO customers VALUES ('DV-13045', 'Darrin Van Huff', 'Corporate', '90036'),('SO-20335', 'Sean O"Donnell"', 'Consumer', '33311');
INSERT INTO product_categories VALUES ('Labels', 'Office Supplies'),('Tables', 'Furniture'),('Storage', 'Office Supplies'),('Furnishings', 'Furniture'),('Art', 'Office Supplies'),('Phones', 'Technology');
  
INSERT INTO products VALUES ('OFF-LA-10000240','Self-Adhesive Address Labels for Typewriters by Universal','Labels','14.62'),
('FUR-TA-10000577', 'Bretford CR4500 Series Slim Rectangular Table','Tables','957.5775'),
('OFF-ST-10000760', 'Eldon Fold N Roll Cart System','Storage','22.368'),
('FUR-FU-10001487', 'Eldon Expressions Wood and Plastic Desk Accessories, Cherry Wood','Furnishings','48.86'),
('OFF-AR-10002833', 'Newell 322','Art','7.28'),
('TEC-PH-10002275', 'Mitel 5320 IP Phone VoIP phone','Phones','907.152');
INSERT INTO customers VALUES ('BH-11710', 'Brosina Hoffman', 'Consumer', '90032');
select * from orders;
INSERT INTO orders VALUES ('CA-2017-138688', '2017-06-12', '2017-06-16', 'SecondClass', 'DV-13045');
INSERT INTO orders VALUES ('US-2016-108966', '2016-10-11', '2016-10-18', 'Standard Class', 'SO-20335'); 
-- INSERT INTO orders VALUES ('CA-2015-115812', '2015-06-09', '2015-06-14', 'Standard Class', 'BH-11710'); have to run it.

INSERT INTO order_products VALUES ('CA-2017-152156','FUR-BO-10001798' );
INSERT INTO order_products VALUES ('CA-2017-152156','FUR-CH-10000454');
INSERT INTO order_products VALUES ('CA-2017-138688','OFF-LA-10000240');
INSERT INTO order_products VALUES ('US-2016-108966','FUR-TA-10000577');
INSERT INTO order_products VALUES ('US-2016-108966','OFF-ST-10000760');
-- INSERT INTO order_products VALUES ('CA-2015-115812','FUR-FU-10001487');
-- INSERT INTO order_products VALUES ('CA-2015-115812','OFF-AR-10002833');
-- INSERT INTO order_products VALUES ('CA-2015-115812','TEC-PH-10002275');


-- 3
SELECT * from postal_addresses;
SELECT * from customers;
SELECT * from product_categories;
SELECT * from products;
SELECT * from orders;
SELECT * from order_products;

-- 4
SELECT customer_name from customers where customer_id = 'DV-13045';
SELECT product_name from products where order_id ='US-2016-108966';

-- 5 
SELECT product_id from order_products WHERE order_id='CA-2017-138688';

-- 6 
SELECT products.product_name,product_categories.category, products.sub_category FROM products INNER JOIN product_categories ON products.sub_category=product_categories.sub_category WHERE product_id='FUR-FU-10001487';

-- 7
SELECT * FROM customers where segment ='consumer';

-- 8
SELECT sales from products where sales > 100;











 