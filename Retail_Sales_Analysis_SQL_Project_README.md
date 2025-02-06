
# Retail Sales Analysis - SQL Project

## Project Overview
This project performs an in-depth analysis of retail sales data using SQL queries. It includes data cleaning, data exploration, and business insights extraction. The analysis covers key aspects such as sales trends, top-selling products, customer behavior, and revenue analysis.

## Dataset
The dataset contains transactional sales data for a retail store.

### Key columns include:
- `transaction_id`: Unique ID for each sale.
- `sale_date`: Date of sale.
- `sale_time`: Time of sale.
- `customer_id`: Unique customer identifier.
- `category`: Product category.
- `quantity`: Number of units sold.
- `price_per_unit`: Price per unit of the product.
- `cogs`: Cost of goods sold.
- `total_sale`: Total revenue from the transaction.
- `gender`: Gender of the customer.
- `age`: Age of the customer.

## SQL Analysis Breakdown

### 1. Data Cleaning
**Count total records:**
```sql
SELECT COUNT(*) FROM retail_sales;
```

**Check for missing values:**
```sql
SELECT * FROM retail_sales
WHERE sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

**Remove rows with NULL values:**
```sql
DELETE FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

### 2. Data Exploration
**Count unique customers:**
```sql
SELECT COUNT(DISTINCT customer_id) AS number_of_customers FROM retail_sales;
```

**List all unique product categories:**
```sql
SELECT DISTINCT category FROM retail_sales;
```

**Retrieve all sales from November 5, 2022:**
```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```

### 3. Business Key Insights

**1. Top-Selling Categories**
Find total quantity and revenue per category:
```sql
SELECT category,
       SUM(quantity) AS number_of_sold_items,
       SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY category;
```

**2. Best-Selling Month Per Year**
Find the month with the highest average sales per year:
```sql
SELECT year, month, total_revenue
FROM (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        ROUND(AVG(total_sale)::NUMERIC, 3) AS total_revenue,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY 1,2
) AS T
WHERE rank = 1;
```

**3. Top 5 Customers Based on Revenue**
```sql
SELECT customer_id,
       SUM(total_sale) AS total_revenue_per_customer,
       RANK() OVER(ORDER BY SUM(total_sale) DESC) AS rank
FROM retail_sales
GROUP BY customer_id
ORDER BY rank
LIMIT 5;
```

**4. Sales Shift Analysis (Morning, Afternoon, Evening)**
```sql
SELECT COUNT(transaction_id) AS total_orders,
       CASE
           WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
           WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
           ELSE 'EVENING'
       END AS shift
FROM retail_sales
GROUP BY shift
ORDER BY total_orders DESC;
```

## Key Takeaways
- The dataset was cleaned by removing NULL values.
- The most profitable product categories were identified.
- The best month for sales was determined for each year.
- The top customers by revenue were found.
- The sales distribution by time of day was analyzed.

## How to Run the Queries
1. Load the dataset into a PostgreSQL database.
2. Run the SQL scripts in order:
   - Data Cleaning
   - Data Exploration
   - Business Analysis
3. Analyze the results to gain insights into sales performance.

## Future Improvements
- Use window functions for more advanced ranking.
- Perform time-series forecasting on sales data.
- Integrate with BI tools like Power BI or Tableau.

## Author
Kaif

- GitHub: [Your GitHub Profile](#)
- LinkedIn: [Your LinkedIn Profile](#)
