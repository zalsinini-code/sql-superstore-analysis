# 📊 SQL Business Data Analysis: Superstore Dataset

## 📝 Overview & Highlights
**Ladder Challenge:** Completed a progressive SQL challenge simulating real-world business queries, focusing on data cleaning, filtering, aggregation, joins, and subqueries. Demonstrated advanced proficiency in querying relational databases to extract insights and support data-driven decisions.

This project focuses on analyzing sales performance, customer trends, product categories, and temporal patterns from a retail database (**Superstore**) using **PostgreSQL**.

---

## 🛠️ Key SQL Concepts & Techniques Applied
* **Temporal Analysis & Date Functions:** `EXTRACT()`, `DATE_TRUNC()`, handling Quarters, Months, and Days of the week (`DOW`).
* **Data Aggregation:** `SUM()`, `AVG()`, `COUNT(DISTINCT)` combined with multi-level `GROUP BY` and `ORDER BY` clauses.
* **Relational Joins:** `INNER JOIN` across `orders`, `products`, `customers`, and `regions` tables using foreign key relationships (`USING` syntax).
* **Conditional Logic:** `CASE WHEN` statements to transform numeric values into business-friendly categorical names (e.g., Days of the Week, Month Names).
* **Case-Insensitive Pattern Matching:** `ILIKE` for text filtering across product categories and regions.

---

## 🔍 Key Business Questions Addressed

-------------------------------------------------------------------------------
-- PROJECT: SQL Business Data Analysis (Ladder Challenge)
-- DATABASE: PostgreSQL
-------------------------------------------------------------------------------
-- 1. Question: Calculate the total Sales for each year based on OrderDate.
```sql
SELECT DATE_TRUNC('year', order_date::timestamp) AS year, SUM(sales)
FROM public.orders
GROUP BY 1
ORDER BY 1 ASC;
```
<img width="1008" height="421" alt="Screenshot 2026-07-28 235353" src="https://github.com/user-attachments/assets/1fab0d57-1087-41d6-bd98-ee032ecd4ff5" />


-- 2. Question: What is the average Profit for each month (regardless of year) based on OrderDate?
```sql
SELECT EXTRACT(month FROM order_date::timestamp) AS Month, AVG(profit) AS avg_profit
FROM public.orders
GROUP BY 1;
```
<img width="1002" height="415" alt="Screenshot 2026-07-28 235420" src="https://github.com/user-attachments/assets/f55780be-85b3-47de-b55c-a32a14bed209" />


-- 3. Question: Find the total Quantity of products sold for each quarter of the year based on OrderDate.
```sql
SELECT DATE_TRUNC('quarter', order_date::timestamp) AS Quarter, SUM(quantity) AS total_quantity
FROM public.orders
GROUP BY 1;
```
<img width="1003" height="430" alt="Screenshot 2026-07-28 235445" src="https://github.com/user-attachments/assets/53ad7452-8c8e-41a5-8868-71ae1ae97eaf" />


-- 4. Question: List the Category and the total Sales for each month-year combination based on OrderDate.
```sql
SELECT 
    DATE_TRUNC('quarter', order_date::timestamp) AS year_quarter, 
    SUM(profit) AS total_profit
FROM public.orders
GROUP BY 1
ORDER BY 1;
```
<img width="1002" height="415" alt="Screenshot 2026-07-28 235517" src="https://github.com/user-attachments/assets/4993b306-87a9-439a-9d16-fd670596c0da" />


-- 5. Question: What is the number of distinct Customers who placed orders in each day of the week (e.g., Monday, Tuesday, etc.)?
```sql
SELECT 
    EXTRACT(month FROM order_date::timestamp) AS month, 
    AVG(discount) AS avg_discount
FROM public.orders
GROUP BY 1
ORDER BY 1;
```
<img width="1006" height="417" alt="Screenshot 2026-07-28 235541" src="https://github.com/user-attachments/assets/36a36adc-e7e6-4722-8216-4c305d4ee0f5" />

-- 6. Question: Calculate the total Profit from 'Technology' products for each year they were ordered.
```sql
SELECT 
    TO_CHAR(order_date::timestamp, 'Day') AS day_of_week, 
    SUM(sales) AS total_sales
FROM public.orders
GROUP BY 1, EXTRACT(dow FROM order_date::timestamp)
ORDER BY EXTRACT(dow FROM order_date::timestamp);
```
<img width="1006" height="425" alt="Screenshot 2026-07-29 001825" src="https://github.com/user-attachments/assets/69a39f77-2061-45ff-b01d-d739d369e316" />



-- 7. Question: Show the total Sales for each quarter of the OrderDate in the 'South' Region.
```sql
SELECT 
    EXTRACT(year FROM order_date::timestamp) AS year, 
    COUNT(DISTINCT order_id) AS total_orders
FROM public.orders
GROUP BY 1
ORDER BY 1;
```
<img width="1010" height="416" alt="Screenshot 2026-07-28 235706" src="https://github.com/user-attachments/assets/cb5b2589-fe19-4db6-9907-bce25d50b902" />




-- 8. Question: Retrieve all orders (OrderID, OrderDate) that were placed in March 2023.
```sql
WITH MonthlySales AS (
    SELECT 
        EXTRACT(year FROM order_date::timestamp) AS year,
        EXTRACT(month FROM order_date::timestamp) AS month,
        SUM(sales) AS total_sales,
        RANK() OVER (
            PARTITION BY EXTRACT(year FROM order_date::timestamp) 
            ORDER BY SUM(sales) DESC
        ) AS rnk
    FROM public.orders
    GROUP BY 1, 2
)
SELECT year, month, total_sales
FROM MonthlySales
WHERE rnk = 1;
```
<img width="1007" height="418" alt="Screenshot 2026-07-28 235740" src="https://github.com/user-attachments/assets/4425417e-ca10-43e5-bee5-19a7d2830f6b" />


-- 9. Question: List all CustomerName and their OrderDate for orders placed on a Sunday.
```sql
SELECT 
    order_id, 
    order_date, 
    ship_date, 
    (ship_date::date - order_date::date) AS days_to_ship
FROM public.orders;
```
<img width="1007" height="417" alt="Screenshot 2026-07-28 235804" src="https://github.com/user-attachments/assets/74d79794-7eb4-4295-8b4b-c5b98edb8e84" />

-- 10. Question: Find the ProductName and Sales for all products that were ordered in the first half of any year (January to June).
```sql
SELECT 
    EXTRACT(year FROM order_date::timestamp) AS year, 
    (SUM(profit) / NULLIF(SUM(sales), 0)) * 100 AS profit_margin_percentage
FROM public.orders
GROUP BY 1
ORDER BY 1;
```
<img width="1006" height="413" alt="Screenshot 2026-07-28 235828" src="https://github.com/user-attachments/assets/b9e3de20-467a-475f-9d92-b25428ef7f60" />

---

## 📂 Repository Structure

```text
├── README.md
├── scripts/
│   └── superstore_analysis.sql   # Complete SQL queries
└── data_outputs/
    └── superstore_dataset.zip          # Exported CSV query results
```

---

## 🚀 How to Run the Queries
1. Open your PostgreSQL environment (e.g., **pgAdmin** or **DBeaver**).
2. Connect to the database containing the `orders`, `products`, `customers`, and `regions` tables.
3. Execute `superstore_analysis_queries.sql` to run the analysis and reproduce the key metrics.
