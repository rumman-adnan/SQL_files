

-- 3. Show all columns from all tables (each table displayed one by one).
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM order_products;
SELECT * FROM orders;
SELECT * FROM product_categories;
SELECT * FROM customer_addresses;

-- 4. Show the name of the customer whose customer ID is ‘HP-14815’.
SELECT customer_name
FROM customers
WHERE customer_id = 'HP-14815';

-- 5. Show all items placed under order ID ‘CA-2017-145625’.
SELECT * FROM order_products
WHERE order_id = 'CA-2017-145625';


-- 6. Show the name, category and sub-category of the product with product ID ‘TEC-AC-10002167’.
SELECT product_id, product_name, sub_category
FROM products 
where product_id = 'TEC-AC-10002167';


-- 7. Show all customers belonging to the ‘consumer’ segment.
SELECT * 
FROM customers
WHERE segment = 'consumer';

-- 8. Show a list of all sales amounting to more than $100.
SELECT * 
FROM products
WHERE sales > 100;

-- 9. Show all customers with missing postal addresses.
SELECT * 
FROM customers
WHERE postal_code IS NULL;

-- 10. Show all orders placed in 2017 and afterwards.
SELECT * 
FROM orders
WHERE year(ship_date) > 2016;

-- 11. Show all orders placed between 2015 and 2016 only.

SELECT * 
FROM orders
WHERE year(ship_date) BETWEEN 2015 AND 2016;

-- 12. Show all orders where the order was not shipped within 7 days of being placed.

SELECT * , DATEDIFF(ship_date, order_date) AS 'processing_days'
FROM orders
having 'processing_days' > 7;

-- 13. Show a list of all products with ‘Xerox’ in their name.
SELECT * 
FROM products
WHERE product_name = "Xerox";



-- 15 Update the address of the customer with ID ‘KC-16540’ to country=‘Pakistan’, city=‘Lahore’, state=‘Punjab’, postal_code=‘54000’, region=‘East’.
-- First Insert data,
-- JOIN 2 tables and update them


-- INSERT INTO customer_addresses (postal_code, city, state, region, country) VALUES (54000, "Lahore", "Punjab", "East", "Pakistan");

UPDATE customers 
SET postal_code = '54000'
where customer_id = 'KC-16540';

-- CHECK
SELECT *
FROM customer_addresses
WHERE postal_code = '54000';
