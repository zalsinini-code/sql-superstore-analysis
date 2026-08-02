-------------------------------------------------------------------------------
-- PROJECT: SQL Business Data Analysis (Ladder Challenge)
-- DATABASE: PostgreSQL
-------------------------------------------------------------------------------

-- 1. Question: Calculate the total Sales for each year based on OrderDate.
SELECT DATE_TRUNC('year', order_date::timestamp) AS year, SUM(sales)
FROM public.orders
GROUP BY 1
ORDER BY 1 ASC;
-- 2. Question: What is the average Profit for each month (regardless of year) based on OrderDate?
SELECT EXTRACT(month FROM order_date::timestamp) AS Month, AVG(profit) AS avg_profit
FROM public.orders
GROUP BY 1;

-- 3. Question: Find the total Quantity of products sold for each quarter of the year based on OrderDate.
SELECT DATE_TRUNC('quarter', order_date::timestamp) AS Quarter, SUM(quantity) AS total_quantity
FROM public.orders
GROUP BY 1;

-- 4. Question: List the Category and the total Sales for each month-year combination based on OrderDate.
SELECT 
    DATE_TRUNC('quarter', order_date::timestamp) AS year_quarter, 
    SUM(profit) AS total_profit
FROM public.orders
GROUP BY 1
ORDER BY 1;

-- 5. Question: What is the number of distinct Customers who placed orders in each day of the week (e.g., Monday, Tuesday, etc.)?
SELECT 
    EXTRACT(month FROM order_date::timestamp) AS month, 
    AVG(discount) AS avg_discount
FROM public.orders
GROUP BY 1
ORDER BY 1;

-- 6. Question: Calculate the total Profit from 'Technology' products for each year they were ordered.
SELECT 
    TO_CHAR(order_date::timestamp, 'Day') AS day_of_week, 
    SUM(sales) AS total_sales
FROM public.orders
GROUP BY 1, EXTRACT(dow FROM order_date::timestamp)
ORDER BY EXTRACT(dow FROM order_date::timestamp);

-- 7. Question: Show the total Sales for each quarter of the OrderDate in the 'South' Region.
SELECT 
    EXTRACT(year FROM order_date::timestamp) AS year, 
    COUNT(DISTINCT order_id) AS total_orders
FROM public.orders
GROUP BY 1
ORDER BY 1;
-- 8. Question: Retrieve all orders (OrderID, OrderDate) that were placed in March 2023.
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

-- 9. Question: List all CustomerName and their OrderDate for orders placed on a Sunday.
SELECT 
    order_id, 
    order_date, 
    ship_date, 
    (ship_date::date - order_date::date) AS days_to_ship
FROM public.orders;

-- 10. Question: Find the ProductName and Sales for all products that were ordered in the first half of any year (January to June).
SELECT 
    EXTRACT(year FROM order_date::timestamp) AS year, 
    (SUM(profit) / NULLIF(SUM(sales), 0)) * 100 AS profit_margin_percentage
FROM public.orders
GROUP BY 1
ORDER BY 1;