create database retail_Sales_project ;

/*  A retail company wants to analyze its sales performance, 
identify top-performing products,
 understand customer behavior, and find opportunities to increase revenue.

target :
- Identify high revenue regions and categories
- Find top customers and products
- Analyze monthly trends
- Provide actionable business recommendations  */ 


-- total revenue
SELECT 
    SUM(Sales) AS total_revenue
FROM train;


-- Revenue by Region
SELECT 
    Region,
    SUM(Sales) AS revenue
FROM train
GROUP BY Region
ORDER BY revenue DESC;



-- Top 10 Products
SELECT 
    `Product Name`,
    SUM(Sales) AS total_sales
FROM train
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;



-- Monthly Sales Trend
SELECT 
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS month,
    SUM(Sales) AS total_sales
FROM train
GROUP BY month
ORDER BY month;


-- Top Customers 
SELECT 
    `Customer Name`,
    SUM(Sales) AS total_clv
FROM train
GROUP BY `Customer Name`
ORDER BY total_clv DESC
LIMIT 10;


-- Category Contribution
SELECT 
    Category,
    SUM(Sales) AS category_sales,
    ROUND(SUM(Sales) * 100.0 / (SELECT SUM(Sales) FROM train), 2) AS contribution_percent
FROM train
GROUP BY Category
ORDER BY contribution_percent DESC;



SELECT 
    Category,
    SUM(Sales) AS category_sales,
    ROUND(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER (), 2) AS contribution_pct,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS rank_pos,
    SUM(SUM(Sales)) OVER (ORDER BY SUM(Sales) DESC) AS running_sales
    ROUND(
        SUM(SUM(Sales)) OVER (ORDER BY SUM(Sales) DESC) * 100.0 
        / SUM(SUM(Sales)) OVER (), 
     AS cumulative_pct
FROM train
GROUP BY Category;






/*  Top 20% products contribute ~70–80% of total revenue
Region X generates highest sales → strong market presence
Some regions show low performance → growth opportunity
Sales peak during specific months → seasonal demand


 Business Recommendations
Focus marketing on top-performing products
Improve sales strategy in low-performing regions
Introduce discounts during low-sales months
Retain high-value customers with loyalty programs */

