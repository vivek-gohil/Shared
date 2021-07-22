SELECT @@VERSION;

--Basic SQL Server SELECT Statement
SELECT 
	*
FROM
	[production].[brands];

SELECT 
	*
FROM
	production.categories;

SELECT 
	*
FROM
	production.products;

SELECT 
	*
FROM
	sales.customers;

--print the first name and last name of all customers
SELECT
	first_name,
	last_name
FROM
	sales.customers;

--print the first name ,last name , email of all customers
SELECT
	first_name,
	last_name,
	email
FROM
	sales.customers;

--Filter the rows based on one or more conditions , using WHERE clause
SELECT
	*
FROM
	sales.customers
WHERE
	state = 'NY';

--TO sort the result set based on one or more columns , using ORDER BY clause
SELECT
	*
FROM
	sales.customers
WHERE
	state = 'NY'
ORDER BY
	first_name;

SELECT
	*
FROM
	sales.customers
WHERE
	state = 'NY'
ORDER BY
	first_name DESC;

--Print first name , last name , city of the customers.
--Sort the customers by city
SELECT
	first_name,
	last_name,
	city
FROM
	sales.customers
ORDER BY
	city;

--Print first name , last name , city of the customers.
--Sort the customers by city first and then sort by first name
SELECT
	city,
	first_name,
	last_name
FROM
	sales.customers
ORDER BY
	city,
	first_name;

--Print first name , last name , city of the customers.
--Sort the customers by city - descending order first and then sort by first name in ascending order
SELECT
	city,
	first_name,
	last_name
FROM
	sales.customers
ORDER BY
	city desc,
	first_name asc;

--Print first name , last name , city of the customers.
--Sort the customers by the length of the first name
SELECT 
	LEN(first_name) 'first name length',
	first_name
FROM
	sales.customers
ORDER BY
	'first name length';

--DISTINCT 
--print all cities of all customers
SELECT 
	city
FROM
	sales.customers
ORDER BY
	city;

SELECT DISTINCT
	city
FROM
	sales.customers
ORDER BY
	city;

SELECT DISTINCT
	city,state
FROM
	sales.customers
ORDER BY
	city,
	[state];

--USING WHERE Clause
--Finding rows that meet two conditions
--Print all products 
--With category id is 1 and model is 2018
SELECT
	*
FROM
	production.products
WHERE
	category_id = 1 AND model_year = 2018
ORDER BY 
	list_price;

--Print all products 
--With list price > 300 and model is 2018
SELECT
	*
FROM
	production.products
WHERE
	list_price > 300 AND model_year = 2018
ORDER BY 
	list_price;

--Print all products 
--whose list price between 1899 and 1999.99
SELECT
  *
FROM
    production.products
WHERE
    list_price BETWEEN 1899.00 AND 1999.99
ORDER BY
    list_price DESC;

----Print all products
--whose list price is 299.99 or 466.99 or 489.99.
SELECT
	*
FROM
    production.products
WHERE
    list_price = 299.99 OR list_price = 369.99 OR list_price = 489.99
ORDER BY
    list_price DESC;

SELECT
	*
FROM
    production.products
WHERE
    list_price IN (299.99, 369.99, 489.99)
ORDER BY
    list_price DESC;

--Using LIKE operator
----Print all products
--find products whose name contains the string 'Cruiser'
SELECT
	*
FROM
    production.products
WHERE
	--product_name LIKE '%Cruiser%';
	product_name LIKE 'Trek%';

--GROUPING DATA
--print all the orders
SELECT
	*
FROM
	sales.orders;

--print all the orders
--print the oreders placed by customer id 1 or 2
SELECT
	customer_id,
	YEAR(order_date) order_year
FROM
	sales.orders
where
	customer_id IN(1,2)
ORDER BY
	customer_id;

--print the oreders count placed by customer id 1 or 2
SELECT
	customer_id,
	COUNT(customer_id) 'orders_count',
	YEAR (order_date) 'order_year'
FROM
	sales.orders
GROUP BY
	customer_id,
	YEAR (order_date)
ORDER BY
	customer_id;

--print all customers
SELECT 
	*
FROM
	sales.customers
ORDER BY
	state;

--Print the total count of customers by its state
SELECT 
	[state],
	count([state]) 'state_count'
FROM
	sales.customers
GROUP BY
	[state]
HAVING 
	COUNT([state]) > 200
ORDER BY
	[state];

--SQL Server Joins
--SAMPLE TABLES
--create new schema as hr
go;
CREATE SCHEMA hr;
go;


--create two new tables named candidates and employees in hr 
CREATE TABLE hr.candidates(
	id INT PRIMARY KEY IDENTITY,
	fullname VARCHAR(100) NOT NULL	
);

CREATE TABLE hr.employees(
	id INT PRIMARY KEY IDENTITY,
	fullname VARCHAR(100) NOT NULL
);

--insert some rows into candidates and employees
INSERT INTO	
	hr.candidates
VALUES
	('Jayant Kulkarni'),
	('Amey Sawant'),
	('Vinayak Navada'),
	('Shreeyansh Parihar');

INSERT INTO
	hr.employees
VALUES
	('Jayant Kulkarni'),
	('Nikhil Rane'),
	('Mauank Patel'),
	('Amey Sawant');

--Select all employees and candidates
SELECT 
	*
FROM
	hr.employees;

SELECT 
	*
FROM
	hr.candidates;

--CROSS JOIN
SELECT 
	*
FROM
	hr.employees , hr.candidates;

SELECT 
	*
FROM
	hr.employees CROSS JOIN hr.candidates;

--Inner Join
SELECT 
	*
FROM
	hr.employees e INNER JOIN hr.candidates c
ON
	e.fullname = c.fullname

--Outer Join
	--Left outer - returns all rows from the left table and the matching rows from the right table
	--Right outer - returns all rows from the right table and the matching rows from the left table
	--Full outer - returns all rows from both the tables. in case there is no match the missing side will have null values


--Left outer join
SELECT 
	*
FROM
	hr.employees e LEFT OUTER JOIN hr.candidates c
ON
	e.fullname = c.fullname

--Right outer join
SELECT 
	*
FROM
	hr.employees e RIGHT OUTER JOIN hr.candidates c
ON
	e.fullname = c.fullname

--Full outer join
SELECT 
	*
FROM
	hr.employees e FULL OUTER JOIN hr.candidates c
ON
	e.fullname = c.fullname;

--Self join
SELECT 
	*
FROM
	hr.employees e1 INNER JOIN hr.employees e2
ON
	e1.fullname = e2.fullname;

SELECT 
	*
FROM
	sales.staffs;

SELECT 
	employee.first_name 'employee',
	manager.first_name 'manager'
FROM
	sales.staffs manager INNER JOIN sales.staffs employee
ON
	employee.manager_id = manager.staff_id;

--SubQuery
--Print the customers who is located in city New York
SELECT 
	*
FROM
	sales.customers



--print all the orders 
SELECT 
	*
FROM
	sales.orders;


--Print sales order of the customers who is located in city New York
SELECT 
	*
FROM
	sales.orders
WHERE customer_id IN ( 
	SELECT 
		customer_id
	FROM
		sales.customers
	WHERE 
		city = 'New York' );

SELECT 
	*
FROM
	[production].[stocks]

SELECT 
	*
FROM
	[production].[products]

--Print all products for which stock is > 20 in store id = 1 
SELECT 
	*
FROM
	[production].[products]
WHERE
	product_id IN
	(SELECT DISTINCT
		product_id
	FROM
	[production].[stocks]
	where 
	store_id = 1 AND
	quantity > 20
	);

SELECT
product_id,
product_name
FROM
production.products
WHERE
product_id IN(
SELECT
product_id
FROM
production.stocks
GROUP BY
product_id
HAVING
SUM(quantity) > 20
);

--find the products whose list prices are greater than or equal to 
--the average list price of any product brand.
SELECT 
	*
FROM
	production.products
WHERE
	list_price >= ANY (
		SELECT
			AVG(list_price)
		FROM
			production.products
		GROUP BY
			brand_id
	);

--Aggrigate functions
SELECT
	*
FROM
	production.products;

SELECT 
	*
FROM
	production.products
WHERE list_price = (
	SELECT
		MIN(list_price)
	FROM
		production.products);


SELECT 
	*
FROM
	production.products
WHERE list_price = (
	SELECT
		MAX(list_price)
	FROM
		production.products);

SELECT
		SUM(list_price)
	FROM
		production.products


SELECT 
	*
FROM
	production.products
WHERE list_price >= (
	SELECT
		AVG(list_price)
	FROM
		production.products)
ORDER BY
	list_price;

--DATE Functions
SELECT GETDATE();

SELECT DAY(GETDATE());
SELECT MONTH(GETDATE());
SELECT YEAR(GETDATE());


SELECT DATEADD(SECOND,1,'2018-12-31 23:59:59') RESULT;
SELECT DATEADD(DAY,1,'2018-12-31 23:59:59') RESULT;
SELECT DATEADD(MONTH,1,'2018-12-31 23:59:59') RESULT;
SELECT DATEADD(YEAR,1,'2018-12-31 23:59:59') RESULT;

DECLARE @d DATETIME = '2019-01-01 14:30:14';
SELECT 
	DATEPART(YEAR , @d) year,
	DATEPART(QUARTER , @d) quarter,
	DATEPART(MONTH , @d) month,
	DATEPART(DAY , @d) day,
	DATEPART(WEEKDAY , @d) weekday,
	DATEPART(HOUR , @d) hour,
	DATEPART(MINUTE , @d) minute,
	DATEPART(SECOND , @d) seconds;

SELECT DATENAME(WEEKDAY , '2019-01-01 14:30:14');

DECLARE 
	@start_dt DATETIME = '2019-12-31 23:59:59',
	@end_dt DATETIME =  '2020-01-01 00:00:00';
SELECT
	DATEDIFF(YEAR , @start_dt , @end_dt) YEAR ,
	DATEDIFF(MONTH , @start_dt , @end_dt) MONTH,
	DATEDIFF(DAY , @start_dt , @end_dt) DAY,
	DATEDIFF(HOUR , @start_dt , @end_dt) HOUR,
	DATEDIFF(SECOND , @start_dt , @end_dt) SECOND;















