
-- 1. Display the first 5 tuples of each table.
SELECT * FROM customers
LIMIT 5;
SELECT * FROM employees
LIMIT 5;
SELECT * FROM offices
LIMIT 5;
SELECT * FROM orderdetails
LIMIT 5;
SELECT * FROM orders
LIMIT 5;
SELECT * FROM payments
LIMIT 5;
SELECT * FROM productlines
LIMIT 5;
SELECT * FROM products
LIMIT 5;

-- 2. Display the employee head count of the company.
SELECT COUNT(*) AS employee_count
FROM employees;
SELECT SUM(DISTINCT(employeeNumber)) AS head_count
FROM employees;

-- 3. Display the primary key fields only for each table.
SHOW KEYS FROM customers  WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM employees  WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM offices  WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM orderdetails  WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM orders  WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM payments  WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM productlines  WHERE Key_name = 'PRIMARY';
SHOW KEYS FROM products  WHERE Key_name = 'PRIMARY';
-- 4. Display all products that are out of stock.

SELECT * FROM products
WHERE quantityInStock IS NULL;

-- 5. Display the total number of classic car models currently in stock
SELECT * FROM products;
SELECT * FROM products  WHERE (quantityInStock >= 1 AND productLine = 'Classic Cars');


-- 6. Display the employee number, first name and last name of all sales managers.

SELECT employeeNumber, firstName, lastName, jobTitle 
FROM employees
WHERE jobTitle LIKE "Sales Manager%";
-- 7. Display all Mercedes based models.

SELECT * FROM products
WHERE productName LIKE "%Mercedes%";

-- 8. Change the job title of employee number 1002 from President to CEO.
UPDATE employees 
SET jobTitle = "CEO"
WHERE employeeNumber = 1002;

SELECT * FROM employees where employeeNumber = 1002;
-- 9. Display all orders that were shipped after the customer’s requirement date.
SELECT * 
FROM orders
WHERE  DAY(shippedDate) > DAY(requiredDate);
-- 10. Display all the orders that were cancelled before getting shipped.
SELECT * FROM orders
WHERE (status = "In Process") AND (shippedDate IS NULL);








-- Write one or more SQL queries to solve each of the following problems:
-- 11.  Display total number of customers handled by each sales representative.
SELECT salesRepEmployeeNumber, COUNT(*)
FROM customers
group by salesRepEmployeeNumber
;

-- 12. Display the country with the least number of customers.
SELECT country, SUM(DISTINCT(customerNumber)) AS customers_number
FROM customers
GROUP BY country
ORDER BY customers_number ASC
LIMIT 1;


-- 13. Display the total number of products in each product line, along with the
-- min, max and average manufacturer suggested retail price (MSRP) of products in the product line.


SELECT productLine, SUM(DISTINCT(productName)) AS total_products, MIN(MSRP), MAX(MSRP), AVG(MSRP) 
FROM products
GROUP BY productLine;

-- 14. Display all order IDs containing at least 15 products sorted in decreasing
-- order of ordered product count.
SELECT orderNumber, quantityOrdered FROM orderdetails
WHERE quantityOrdered > 15
ORDER BY quantityOrdered DESC;

-- 15. Display single order ID which generated the greatest revenue income
SELECT orderNumber FROM orderdetails
ORDER BY quantityOrdered DESC
LIMIT 1;



-- 16. Display the employee number, first name, last name and the country where
-- each employee works.

SELECT employeeNumber, firstName, lastName, country
FROM employees AS e
INNER JOIN offices AS o ON e.officeCode=o.officeCode;

-- 17. Display the product code, product name and slogan (text description) for each product.

SELECT productCode, productName, productDescription
FROM products AS p
INNER JOIN productlines AS pl ON p.productLine = pl.productLine;


-- 18. Find the average profit earned from products supplied by each vendor, sorted in descending order.
SELECT productVendor, AVG(priceEach-buyPrice) AS avg_profit
FROM products AS p
INNER JOIN orderdetails AS od ON p.productCode = od.productCode
group by p.productVendor
ORDER BY avg_profit DESC;

-- 19. Display the employee number, first name and last name of the sales
-- representative that had the greatest number of cancelled orders.

SELECT * 
FROM customers AS c
INNER JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber;

SELECT e.employeeNumber, e.firstName, e.lastName, COUNT(*) AS cancel_orders
FROM customers AS c
INNER JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN orders AS o ON c.customerNumber = o.customerNumber 
GROUP BY o.status ="cancelled"
ORDER BY cancel_orders DESC
LIMIT 1;





-- 20. Display the first name and last name of each employee, along with the first
-- name and last name of their boss. Display ‘NULL’ if boss does not exist.

SELECT e.firstName, e.lastName, be.firstName AS bossFirstName, be.lastName AS bossLastName
FROM employees AS e
LEFT JOIN employees AS be ON e.employeeNumber = be.reportsTo;



-- 21. Find all customers that are being served by sales representatives stationed out of the customer’s local country. 
-- Display the customer’s name, the customer’s country, as well as the country from which they are being served.

SELECT c.customerName, c.country, o.country AS salesRepCountry
FROM customers AS c
INNER JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN offices AS o ON e.officeCode = o.officeCode
WHERE c.country != o.country;

