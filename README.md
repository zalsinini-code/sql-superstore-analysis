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

1. **Annual Sales Trend:** Aggregating total revenue year-over-year.
2. **Monthly Profitability Pattern:** Evaluating average profit per month to identify seasonal performance.
3. **Quarterly Product Demand:** Tracking total units sold across year-and-quarter intervals.
4. **Category Sales by Month:** Monitoring monthly sales breakdown by product categories.
5. **Customer Engagement by Day:** Analyzing distinct customer order activity per day of the week.
6. **Technology Sector Profit:** Measuring total profit generated strictly by Technology products per year.
7. **Regional Performance (South):** Quarterly sales breakdown specifically for the Southern sub-region.
8. **Targeted Date Filtering:** Extracting transactional details for specific timeframe windows (e.g., March 2023).
9. **Sunday Shopping Behavior:** Identifying customer ordering patterns specifically on Sundays.
10. **H1 Performance Analysis:** Analyzing product-level sales generated during the first half of the year (Q1 & Q2).

---

## 📂 Repository Structure
├── analytical_queries.sql    # Fully formatted and debugged PostgreSQL queries
└── README.md                 # Project documentation and summary

---

## 🚀 How to Run the Queries
1. Open your PostgreSQL environment (e.g., **pgAdmin** or **DBeaver**).
2. Connect to the database containing the `orders`, `products`, `customers`, and `regions` tables.
3. Execute `analytical_queries.sql` to run the analysis and reproduce the key metrics.
