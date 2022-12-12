use superstore_B;

-- 1  Show each customer along with their complete address in one table.

SELECT * 
FROM customers AS c
INNER JOIN customer_addresses AS ca ON c.postal_code = ca.postal_code;
-- GROUP BY region;

SELECT * FROM customers;
-- 2 Find any orders that do not have a postal code available for shipment.

SELECT customer_id, customer_name, postal_code
FROM customers
WHERE postal_code IS NULL;

select * from orders;
-- 3 Find the customer that has placed the most orders.

SELECT *, count(*) as tc
from orders
group by customer_id
order by tc desc
LIMIT 1;

-- 4 Find the total number of orders placed by each customer segment in the year 2016.

select *, COUNT(*) as total_orders
FROM customers as c
INNER JOIN orders as o
ON c.customer_id = o.customer_id
where year(order_date) = 2016
group by segment;


-- select *, COUNT(*) 
-- FROM customers as c
-- INNER JOIN orders as o
-- ON c.customer_id = o.customer_id
-- group by customer_name;

select columns from orders;
-- 5 Show any customers that have not yet placed an order.

select *
FROM orders as o
LEFT OUTER JOIN customers as c        
ON c.customer_id = o.customer_id
where order_id IS NULL;
-- Where to do right and left join?, can they be replaceable? 
-- can we add data in customers? just to check null

-- 6 Find the name of the top-rated customer that has spent the greatest amount of money.

SELECT c.customer_id, c.customer_name, SUM(p.sales) AS `customer_total_sales`
FROM customers AS c 
	INNER JOIN orders AS o ON c.customer_id = o.customer_id 
	INNER JOIN order_products AS op ON o.order_id = op.order_id
    INNER JOIN products AS p ON op.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY customer_total_sales DESC
LIMIT 1;



-- 7 Find the distribution of customer segments in each city.

SELECT city, segment, COUNT(*) AS total_customers
FROM customers as cus
INNER JOIN customer_addresses AS cus_add
ON cus.postal_code = cus_add.postal_code
group by city, segment
order by city ASC;


-- 8 Find the total sales volume per product category.

SELECT category, SUM(sales) as Total_Sales
FROM products as p
INNER JOIN product_categories as pc
ON p.sub_category = pc.sub_category
group by category;


-- 9. Find the names of any cities that have not placed any orders yet.
 
SELECT * 
from customers as c
LEFT OUTER JOIN customer_addresses as ca on c.postal_code = ca.postal_code
LEFT OUTER JOIN customer_addresses as ca on c.postal_code = ca.postal_code
INNER JOIN orders as o on o.customer_id = c.customer_id
WHERE city IS NULL;


-- 10. Re-create a single table of all entries as given in the ‘csv’ flat file.

SELECT * 
FROM customers AS c
	INNER JOIN customer_Addresses AS ca ON c.postal_code = ca.postal_code
    INNER JOIN orders AS o ON c.customer_id = o.customer_id
    INNER JOIN order_products AS op ON o.order_id = op.order_id
    INNER JOIN products AS p ON op.product_id = p.product_id
    INNER JOIN product_categories AS pc ON p.sub_category = pc.sub_category;

















