-- putting some query inside another query,
-- We can choose inner queries from SELECT, FROM, WHERE 
-- Do all these tasks with nested queries not JOINS and or other ways
-- We can use outer query attrribute in inner query, vice versa is not true


use superstore_B;
-- 1. Show all customers that have not placed an order yet.   
-- ALL of THEN, ANY ONE OF THEM, EXISTS
SELECT customer_id
FROM orders;

SELECT * 
FROM customers AS c
WHERE c.customer_id NOT IN (
	SELECT o.customer_id
	FROM orders AS o
    WHERE o.customer_id = c.customer_id
    );
    
    SELECT o.customer_id
	FROM orders AS o;
    
-- 2. Show all orders that are placed by ‘Home Office’ customers
-- All


SELECT *
FROM orders
WHERE customer_id IN (
	SELECT customer_id 
	FROM customers
	WHERE segment = "Home Office"
);

-- 3. Show all products whose price is greater than the average price per product.
SELECT *, count(*)
FROM products
group by product_name;

SELECT *
FROM orders
where customer_id IN (
	SELECT customer_id
	FROM customers
	WHERE segment = "Home Office"

);


-- 4. Show all products that belong to the ‘Technology’ category.

SELECT * 
FROM products 
WHERE sub_category IN (
SELECT sub_category
FROM product_categories
WHERE category = "Technology");


-- 5. Show all orders that contain one or more wooden products.   (NO)

SELECT * FROM orders;

SELECT *, COUNT(*)
FROM products AS p
INNER JOIN order_products AS op ON p.product_id = op.product_id
GROUP BY order_id;

SELECT * 
FROM product_categories
WHERE category = "Furniture";


-- 6. Show the customer IDs as well as the names of customers that only use standard class shipping.

SELECT customer_id, customer_name
FROM customers
WHERE customer_id IN (
	SELECT customer_id
	FROM orders
	WHERE ship_mode="Standard Class"
);

-- 7. Show the total sales volume of products purchased by New York City residents
SELECT * from products;

SELECT * FROM customers AS c
	INNER JOIN orders AS o ON c.customer_id = o.customer_id
    INNER JOIN order_products AS op ON o.order_id = op.order_id
    INNER JOIN products AS p ON op.product_id = p.product_id;

SELECT *, sales
FROM products 
WHERE product_id IN( 
	SELECT product_id 
	FROM order_products 
	WHERE order_id IN (
		SELECT order_id
		FROM orders WHERE customer_id IN (

			SELECT customer_id 
			from customers 
			where postal_code IN('10009', '10011', '10024', '10035')
										)
						)
		);

SELECT COUNT(*)
FROM customers
WHERE postal_code; 


-- every customer has many orders, order has many products. 794 ko match krna is too difficult
-- just 68 is good. first find new yorkers customers, then move forward.
-- In nested quety statrt form ground, small thing, think about sequence of events





-- 8. Find the most popular product purchased by Corporate customers.
SELECT *, sales
FROM products 
WHERE product_id IN( 
	SELECT product_id 
	FROM order_products 
	WHERE order_id IN (
		SELECT order_id
		FROM orders WHERE customer_id IN (

			SELECT customer_id 
			from customers 
			where segment = "Corporate"
										)
						)
		);


-- 1. Find a list of customers that have used both shipment methods in 2015
-- SET operations can be done here
SELECT * FROM customers;


SELECT count(*) FROM
(SELECT customer_id
from orders
WHERE ship_mode="Standard Class" AND YEAR(ship_date) = 2015
INTERSECT
select customer_id
from orders
WHERE ship_mode="First Class" AND YEAR(ship_date) = 2015) AS both_shipment;


-- 2. Find the corporate customer churn between 2016 and 2017.
-- customers, orders

SELECT * FROM customers AS c
INNER JOIN (
	SELECT * FROM orders AS o
	WHERE YEAR(order_date) = 2016
 )AS o ON c.customer_id = o.customer_id;



-- 3 Find the corporate and home business customer churn between 2016 and 2017 for the city of Massachusetts
-- customer_addresses, customers, orders
SELECT * FROM customers AS c
INNER JOIN customer_addresses AS ca ON c.postal_code = ca.postal_code ;


SELECT *
FROM orders AS o
	INNER JOIN
    (
		SELECT *
		FROM customers 
		WHERE (postal_code IN (
			SELECT postal_code
			FROM customer_Addresses
			WHERE state = 'Massachusetts'
			) AND (segment = 'Corporate' OR segment = 'Home Office'))
		) AS c ON o.customer_id = c.customer_id
        WHERE YEAR(order_id) = 2016;

-- Sir Aammar Attemp
select *
from customers
where postal_code IN (
	select postal_code
	from customer_addresses
	where state = "Massachusetts") and (segment  = "corporate" OR segment = "Home Office")
    
where year (order_date) = 2016;
-- \\\\\




SELECT *
FROM orders AS o
	INNER JOIN
    (
		SELECT *
		FROM customers 
		WHERE (postal_code IN (
			SELECT postal_code
			FROM customer_Addresses
			WHERE state = 'Massachusetts'
			) AND (segment = 'Corporate' OR segment = 'Home Office'))
		) AS c ON o.customer_id = c.customer_id
        WHERE YEAR(order_date) = 2016
EXCEPT (
select * 
from orders as o
inner join (
	select *
	from customers
	where postal_code IN (
		select postal_code
		from customer_addresses
		where state = "Massachusetts") and 	(segment  = "corporate" OR segment = "Home Office")
) 
as c on o.customer_id =c.customer_id
where year (order_date)= 2017); 





-- 4- Find the average number of products per order in the corporate and home business segments in 2017.
-- order_products, customer, orders

-- Not optimized query (join tables, no filtering)
SELECT AVG(productNumber)
FROM (
	SELECT op.order_id, count(*) AS productNumber, segment, order_date
	FROM orders AS o
	INNER JOIN customers AS c ON c.customer_id = o.customer_id
	INNER JOIN order_products AS op ON o.order_id = op.order_id
	WHERE (segment = 'Corporate' OR segment = 'HomeOffice') AND YEAR(order_date)= 2017
	group by op.order_id
) AS tbl;
    
    USE superstore_B;
    SELECT * FROM orders;
    
    -- SELECT order_id, customer_id, ship_mode
-- 	INTO #temprders
-- 	FROM orders
--     WHERE YEAR(ship_date)=2015;

CREATE TEMPORARY TABLE temp_table
SELECT customer_id, order_date FROM orders;
SELECT * FROM temp_table;
    
    -- Optimized Query (tables JOIN after filtering)
    SELECT AVG(productNumber)
FROM (
	SELECT op.order_id, count(*) AS productNumber, segment, order_date
	FROM (
    SELECT * 
    FROM orders
    WHERE YEAR(order_date) = 2017 
    )
    AS o
	INNER JOIN (
    SELECT * FROM customers
    WHERE segment= 'Corporate' OR segment = 'Home Office'
    )
    AS c ON c.customer_id = o.customer_id
	INNER JOIN order_products AS op ON o.order_id = op.order_id
	GROUP BY op.order_id
) AS tbl;
     
     
     
     -- Optimized Query (IN statement)
     
     
SELECT AVG(productsNumber)
FROM (
SELECT *, COUNT(*) AS productsNumber
FROM order_products
WHERE order_id IN (
	SELECT order_id FROM 
	orders WHERE customer_id IN (
		SELECT customer_id FROM customers
		WHERE segment= 'Corporate' OR segment = 'Home Office'
		 ) AND YEAR(order_date)=2017
         ) GROUP BY order_id
         ) AS tbl;
     
     
     
     
     
     
     
     
    
    
    SELECT *
    FROM orders AS o
    INNER JOIN (
				SELECT *                         
			FROM customers
			WHERE (postal_code IN (
									SELECT postal_code
									FROM customer_Addresses
									WHERE state = 'Massachusetts'
									) 
				) AND (segment = "Corporate" OR segment = "Home Office")
			)
    AS c ON o.customer_id = c.customer_id
    WHERE YEAR(order_date) = 2016;


-- Lengthy way of doing same thing, Sir Aammar
SELECT o.order_id, COUNT(op.product_id)   -- COUNT of products per order
FROM orders AS o
	INNER JOIN order_products AS op ON o.order_id = op.order_id
    INNER JOIN customers AS c ON o.customer_id = c.customer_id
WHERE YEAR(order_date) = 2017 AND (c.segment = 'Corporate' OR c.segment = 'Home Office')
GROUP BY o.order_id;




-- 5. Find a list of product IDs and their names that are typically involved in late shipments (> 5 processing days).
-- products, orders, order_products
    
SELECT product_id, product_name
FROM products
WHERE product_id IN (
	SELECT product_id 
	FROM order_products
	WHERE order_id IN(
		SELECT order_id
		FROM orders
		WHERE DATEDIFF(ship_date, order_date) > 5
		)
    );
    




-- VIEWS
-- 1. Create a view for a customer support representative that deals with clients in Seattle.
CREATE VIEW seattle_customers AS
SELECT c.customer_id, c.customer_name, c.segment, ca.postal_code, ca.city, ca.state, ca.region, ca.country
FROM customers AS c
	INNER JOIN customer_addresses AS ca ON c.postal_code = ca.postal_code
    WHERE city = 'Seattle'
    WITH CHECK OPTION;     -- This checks enforced at time of insertion adn deletion, now data can not be added further.
    
    SELECT *
    FROM seattle_custoemrs;