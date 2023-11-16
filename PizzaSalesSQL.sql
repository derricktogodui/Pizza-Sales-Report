
-- Total Revenue

SELECT SUM(total_price) AS Total_Revenue
FROM Pizza_DB.dbo.pizza_sales

-- Average Order Value

SELECT SUM(total_price) / COUNT(DISTINCT(order_id)) AS Average_Order_Value
FROM Pizza_DB.dbo.pizza_sales

-- Total Pizzas Sold

SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM Pizza_DB.dbo.pizza_sales

-- Total Orders

SELECT COUNT(DISTINCT(order_id)) AS Total_Orders
FROM Pizza_DB.dbo.pizza_sales

-- Average Pizzas Per Order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Average_Pizzas_Per_Order
FROM Pizza_DB.dbo.pizza_sales

-- Hourly Trend For Total Pizzas Sold

SELECT DATEPART(HOUR, order_time) AS Order_Hour, SUM(quantity) as Total_Pizzas_Sold
FROM Pizza_DB.dbo.pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

-- Weekly Trends For Total Orders

SELECT DATEPART(ISO_WEEK, order_date) AS Week_Numner, YEAR(order_date) AS Order_Year,
COUNT(DISTINCT(order_id)) AS Total_Orders
FROM Pizza_DB.dbo.pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)

-- Percentage of Sales by Pizza Category

SELECT pizza_category, SUM(total_price)*100 / 
(SELECT SUM(total_price) FROM Pizza_DB.dbo.pizza_sales WHERE MONTH(order_date)=1) AS Percentage_of_Sales
FROM Pizza_DB.dbo.pizza_sales 
WHERE MONTH(order_date)=1    -- this clause means we are filtering the data to show only January
GROUP BY pizza_category

-- Percentage of Sales by Pizza Size

SELECT pizza_size, CAST(SUM(total_price)*100 / 
(SELECT SUM(total_price) FROM Pizza_DB.dbo.pizza_sales WHERE DATEPART(quarter, order_date) = 1) AS DECIMAL(10,2)) AS Percentage_of_Sales
FROM Pizza_DB.dbo.pizza_sales 
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY Percentage_of_Sales DESC

-- Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC 

-- Top 5 Best Sellers From Bottom

SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

-- Top 5 Best Sellers by Quantity

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

-- Top 5 Best Sellers from Bottom

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM Pizza_DB.dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC
