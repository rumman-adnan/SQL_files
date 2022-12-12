use superstore_B;
-- 1 Create a new derived attribute on orders to calculate and show the order processing time in
-- days along with all other attributes.
SELECT * ,DATEDIFF(ship_date, order_date) AS 'order_processing_days'
FROM orders ;

-- 2 Find the average sales price of products per product sub-category.
SELECT sub_category, AVG(sales) 
FROM products
GROUP BY sub_category;

-- 3 Find the minimum and maximum sales prices of any product per product sub-category.
SELECT sub_category, AVG(sales) AS 'avg_sales', MIN(sales) AS 'min_price', MAX(sales) AS 'max_price' 
FROM products
GROUP BY sub_category;
-- We need aggregate values for grouping
SELECT sub_category, COUNT(*) AS 'total_products', AVG(sales) AS 'avg_sales', MIN(sales) AS 'min_price', MAX(sales) AS 'max_price' 
FROM products
GROUP BY sub_category;

SELECT sub_category FROM products group by sub_category;

-- 4  Find the count of all tuples / records in each table of your database.
desc product_categories;
SELECT COUNT(DISTINCT(category)) AS 'total_categories' FROM product_categories;
SELECT COUNT(DISTINCT(sub_category)) AS 'total_sub_categories' FROM product_categories;
SELECT COUNT(*) AS 'total_orders' FROM orders;
SELECT COUNT(*) AS 'total_categories' FROM product_categories;
SELECT COUNT(*) AS 'total_orders' FROM category;
SELECT COUNT(DISTINCT(sales)) AS 'Total_products' FROM products;
SELECT COUNT(*) AS 'total_orders' FROM orders;

show tables;

-- 5 Show a list of product categories that have more than 5 sub-categories in them.
SELECT *
FROM product_categories
GROUP BY category;

SELECT category, COUNT(*) as product_categories
FROM product_categories
GROUP BY category
HAVING product_categories > 5;

-- 6  Show the total number of orders shipped under each type of shipping mode.
 SELECT ship_mode, COUNT(order_id)
 FROM orders
 GROUP BY ship_mode;

-- 7 Show the total number of orders shipped under each type of shipping mode since 2017.
 SELECT ship_mode, COUNT(order_id), ship_date
 FROM orders
 WHERE year(ship_date) >= 2017
 GROUP BY ship_mode;
 
 SELECT * FROM orders;
 
-- 8 Find the distribution of customers in each segment (total number of customers per segment).

select *, COUNT(*) 
from customers
GROUP BY segment;

-- 9 Find the distribution of customers in each segment for “New York City”, i.e., postal codes ‘10009’, ‘10011’, ‘10024’ and ‘10035’.
select *, COUNT(*) 
from customers
WHERE postal_code IN ('10009', '10011', '10024', '10035');

select *
from customers
WHERE postal_code IN (10009,10011,10035, 10024)
group by segment;

select segment, postal_code, COUNT(*)
from customers
group by segment, postal_code = '10035', postal_code = '10009';

-- 10  Find the total number of products per sub-category that have a sales price greater than $100.
select sub_category,count(*) AS 'product_count'
from products
where sales > 100
Group by sub_category
HAVING product_count >=50
order by product_count DESC;
-- Limit 3




-- 11 Orders deliveries are considered late if they take more than 7 days to be shipped after being  placed. Find the total number of late deliveries per year.

SELECT * , DATEDIFF(ship_date, order_date) AS 'processing_days'
FROM orders
having processing_days >6;


SELECT *
FROM orders
WHERE DATEDIFF(ship_date, order_date) > 7;

-- 12 Show the product IDs of the top 10 most purchased products.
SELECT * 
FROM products
ORDER BY sales DESC
LIMIT 10;

-- 13 Show the names of the top 5 most expensive products.
SELECT * FROM products
ORDER BY sales DESC
LIMIT 5;


-- 14. Show a list of the top 3 most frequent buyers.
SELECT * , COUNT(*)  AS c
FROM orders
group by customer_id
ORDER BY c DESC
LIMIT 3;


-- 15. Show the order ID of the largest order given, i.e., maximum product count per order.
SELECT * , COUNT(*) AS products_in_order
FROM order_products
GROUP BY order_id
ORDER BY products_in_order DESC
LIMIT 1;

