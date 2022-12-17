

SHOW databases;
USE superstore_b;
INSERT INTO customer_addresses (postal_code, city, state, region, country) VALUES (54000, "Multan", "Punjab", "South", "Pakistan");

DELIMITER //
CREATE PROCEDURE us_customers ()
BEGIN
SELECT customer_id, first_name
FROM Customers
WHERE Country = 'USA';
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE customer_addresses ()
BEGIN
SELECT customer_id, city, state, region, country FROM customers AS c
INNER JOIN customer_Addresses ca;
END //
DELIMITER ;

CALL customer_addresses ();


DELIMITER //
CREATE PROCEDURE us_customers ()
BEGIN
SELECT customer_id, first_name
FROM Customers
WHERE Country = 'USA';
END //
DELIMITER ;



-- 3
DELIMITER //
CREATE PROCEDURE customer_population ()
BEGIN

(SELECT customer_id, city, state, region, country, COUNT(*) AS population
FROM customers AS c
INNER JOIN customer_Addresses AS ca ON c.postal_code = ca.postal_code
GROUP BY city
ORDER BY population DESC
LIMIT 3)
UNION 
(SELECT customer_id, city, state, region, country, COUNT(*) AS population
FROM customers AS c
INNER JOIN customer_Addresses AS ca ON c.postal_code = ca.postal_code
GROUP BY city
ORDER BY population ASC
LIMIT 3);

END //
DELIMITER ;

CALL customer_population();

-- 4


DELIMITER //
CREATE PROCEDURE avg_population ()
BEGIN
SELECT AVG(population)
FROM (
		SELECT customer_id, city, state, region, country, COUNT(*) AS population
		FROM customers AS c
		INNER JOIN customer_Addresses AS ca ON c.postal_code = ca.postal_code
		GROUP BY city
) AS tbl;
END //
DELIMITER ;

CALL avg_population();

-- 5  Create a stored procedure that can identify the best-selling product in a given year.


DELIMITER //
CREATE PROCEDURE best_product ()
BEGIN
SELECT *, count(*) AS best_selling 
FROM products as p
inner join order_products as op on op.product_id=p.product_id
inner join orders as o on o.order_id=op.order_id
WHERE YEAR(order_date) = 2018
GROUP BY o.order_id
ORDER BY best_selling DESC
LIMIT 1;
END //
DELIMITER ;


CALL best_product();


-- 6. Create a stored procedure that identifies all dead inventory items in a given year.

SELECT * 
FROM products AS p
INNER JOIN order_products as op on op.product_id = p.product_id
LEFT JOIN orders as o on o.order_id = op.order_id;
WHERE order_id IS NULL ;



-- 6



-- 7 Create a stored procedure that identifies budget customers, i.e., customers that only buy
-- products that have sales prices lower than the average product price in its sub-category.


