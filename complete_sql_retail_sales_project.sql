-- Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
			(
				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id	INT,
				gender VARCHAR(15),
				age INT	,
				category VARCHAR(15),
				quantiy INT,	
				price_per_unit FLOAT,	
				cogs FLOAT,	
				total_sale FLOAT
			)


	select * from retail_sales
	LIMIT 10;

	-- Check total number of records in the dataset
	SELECT COUNT(*) FROM retail_sales;
-- Data cleaning with sql
	-- check for null values
	select * from retail_sales
	WHERE age is null
	OR
	category is null
	OR
	quantiy is null
	OR
	price_per_unit is null
	OR
	cogs is null
	OR
	total_sale is null

	-- DELETE NULL VALUES FROM DATASET
	DELETE FROM retail_sales
	WHERE age is null
	OR
	category is null
	OR
	quantiy is null
	OR
	price_per_unit is null
	OR
	cogs is null
	OR
	total_sale is null

	-- Data Exploration

	-- 1) How many sales do we have 
	SELECT COUNT(*) as number_of_sales FROM retail_sales

	-- How many customers we have
	SELECT COUNT(customer_id) as total_s FROM retail_sales

	-- How many unique customers do we have?
	SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

	SELECT DISTINCT category FROM retail_sales

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retail_sales WHERE category = 'Clothing' AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantiy >= 4
	
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, 
	SUM(total_sale) as net_sale,
	count(*) as total_order --This is for total order
FROM retail_sales
GROUP BY 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),2) as average_age
FROM retail_sales
WHERE category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender, count(transactions_id)
FROM retail_sales
GROUP BY 1, 2
ORDER BY 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
	year,
	month,
	average_sale
FROM
(	
	SELECT 
		EXTRACT(YEAR FROM sale_date) as year,
		EXTRACT(MONTH FROM sale_date) as month,
		AVG(total_sale) as average_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as Rank
	FROM retail_sales
	GROUP BY 1, 2
) as t1
WHERE rank = 1


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
	customer_id as customers,
	SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
	category, COUNT( DISTINCT customer_id) as unique_customer_purchase
FROM retail_sales
GROUP BY 1

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'

	END AS shift
FROM retail_sales
)
SELECT 
	shift,
	COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift

	

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, 
sum(total_sale) as
FROM retail_sales
go
	
 
	

	 
	