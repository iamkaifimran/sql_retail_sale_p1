select
  count (*) 
from retail_sales;
delete from retail_sales;
---- data cleanig part ----
--- checking the null records --
select  * from retail_sales
where 
    
	 sale_date IS NULL
	 or 
	 sale_time IS NULL
	 or
	 customer_id is NULL
	 or 
	 Category IS NULL
	 or
	 quantity IS NULL
	 or 
	 Price_per_unit IS NULL
	 or
	 cogs IS NULL
	 or
	 total_sale IS NULL;

	 
--- DELETING NULL RECORDS--
DELETE FROM retail_sales
where 
     transaction_id IS NULL 
	 or 
	 sale_date IS NULL
	 or 
	 sale_time IS NULL
	 or
	 customer_id is NULL
	 or 
	 Category IS NULL
	 or
	 quantity IS NULL
	 or 
	 Price_per_unit IS NULL
	 or
	 cogs IS NULL
	 or
	 total_sale IS NULL;

--- DATA EXPLORATION PART ------
1.--- Unique Customer ---
SELECT count (DISTINCT Customer_id) AS number_of_customer
from retail_sales;
2. -- Unique Category ---
SELECT  DISTINCT category AS unique_category
FROM retail_sales;


---DATA ANALYSIS AND BUSINESS KEY PROBLEMS ---


-- QUESTION 1-- RETRIVE ALL COLUMNS FROM  SALES MADE ON '2022-11-05'---
SELECT * 
FROM retail_sales
WHERE 
     sale_date = '2022-11-05'

--- Question 2-- WRITE A SQL QUERY TO RETRIVE ALL THE TRANSACTIONS WHERE CATEGORY IS CLOTHING AND QUANTITY SOLD IS MORE THAN 10 AND THE MONTH IS NOVEMBER--
--QUNTITY WISE SALE

SELECT CATEGORY, SUM (QUANTITY) AS TOTAL_SALES
FROM retail_sales
WHERE 
     CATEGORY='Clothing'
	 AND 
	 TO_CHAR(sale_date,'yyyy-mm')='2022-11'
GROUP BY CATEGORY
HAVING SUM(QUANTITY)>4;

---CALCULATE THE TOTAL SALES FOR EACH CATGORY ---
SELECT CATEGORY, SUM(QUANTITY) AS Number_of_sold_item, SUM(total_sale) as Total_revenue
from retail_sales
group by Category

--- WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF THE CUSTOMER BUYING 'BEAUTY' CATGORY PRODUCT---
SELECT CATEGORY,ROUND( AVG(AGE),2)
FROM retail_sales
WHERE CATEGORY='Beauty'
GROUP BY CATEGORY

---- FIND ALL THE TRANSACTION WHERE TOTAL SALE IS GREATER THAN 1000---
SELECT *
FROM retail_sales
WHERE total_sale>1000
---- FIND ALL THE TRANSACTION BY EACH GENDER AND EACH CATEGORY---
SELECT 
    category, 
    gender ,
	COUNT (TRANSACTION_ID) AS number_of_sales,
	SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY category, gender
ORDER BY 1

--- AVERAGE SALE IN EACH MONTH ALSO FIND BEST SELLING MONTH IN EACH YEAR ----
SELECT 
 EXTRACT(MONTH FROM sale_date) AS MONTH,
 ROUND(AVG(total_sale)::NUMERIC,2) AS month_wise_revenue
 FROM retail_sales
 GROUP BY 1
 ORDER BY 1;

-----BEST MONTH FOR SALES ACCORING TO REVENUE -----

SELECT * FROM retail_sales;
SELECT * FROM 
(
SELECT
EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT (MONTH FROM sale_date) AS month,
ROUND(AVG(total_sale)::NUMERIC, 3) AS total_revenue,
RANK() OVER(PARTITION BY  EXTRACT(YEAR FROM sale_date) ORDER BY  AVG(total_sale) DESC) AS RANK
FROM retail_sales
GROUP BY 1,2
) AS T1
WHERE RANK=1;


--- WRITE A QUERY TO FIND THE TOP 5 CUATOMER BASED ON THE TOP SALES -------
SELECT 
customer_id,
sum(total_sale) as total_revenue_per_customer,
rank()over (order by sum(total_sale) desc  )
from retail_sales
group by 1
order by 3
limit 5;

--- unique customer who purchase item from ecah category ---
SELECT 
	category,
	COUNT(DISTINCT customer_id)
FROM retail_sales
GROUP BY 1;

SELECT * FROM RETAIL_SALES
---WRITE A QUERY TO FIND THE NUMBER OF ORDER IN ECAH SHIFT 
---MORNING <=12
---AFTERNOON >=12 BETWEEN 17
----EVENING >=17
SELECT COUNT(transaction_id),
 CASE 
     WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'MORNING'
	 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
	 ELSE
	 'EVENING'
	 END AS SHIFT
FROM retail_saleS
GROUP BY SHIFT
ORDER BY COUNT(transaction_id)

---END PROJECT










