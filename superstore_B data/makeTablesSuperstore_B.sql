
CREATE DATABASE IF NOT EXISTS superstore_B;
USE superstore_B;


CREATE TABLE IF NOT EXISTS customer_addresses (

    postal_code INT (5),
    city VARCHAR (25),
    state VARCHAR (25),
    region VARCHAR (15),
    country VARCHAR (15),

	PRIMARY KEY (postal_code)

);


CREATE TABLE IF NOT EXISTS customers (

	customer_id CHAR (8),
    customer_name VARCHAR (50),
    segment VARCHAR (15),
    postal_code INT (5),

    PRIMARY KEY (customer_id),
	FOREIGN KEY (postal_code) REFERENCES customer_addresses(postal_code)

);


CREATE TABLE IF NOT EXISTS product_categories (

    sub_category VARCHAR (25),
    category VARCHAR (25),
    
    PRIMARY KEY (sub_category)

);


CREATE TABLE IF NOT EXISTS products (

	product_id CHAR (15),
    product_name VARCHAR (255),
    sub_category VARCHAR (25),
    sales FLOAT,
    
    PRIMARY KEY (product_id),
    FOREIGN KEY (sub_category) REFERENCES product_categories(sub_category)    

);


CREATE TABLE IF NOT EXISTS orders (

	order_id CHAR (14),
	customer_id CHAR (8),
    order_date DATE,
    ship_mode VARCHAR (15),
    ship_date DATE,
    
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)

);


CREATE TABLE IF NOT EXISTS order_products (

	order_id CHAR (14),
	product_id CHAR (15),
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (product_id) REFERENCES products(product_id),
	PRIMARY KEY (order_id, product_id)

);

show tables;







