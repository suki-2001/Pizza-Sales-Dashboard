USE [Pizza DB];
GO

select * from pizza_sales;

--- total revenue
SELECT SUM(total_price) AS total_revenue FROM pizza_sales;

--- Average Order Value
SELECT (SUM(total_price) / count(DISTINCT order_id)) AS Average_order_value FROM pizza_sales;

--- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Solds FROM pizza_sales;

--- Total Orders placed
SELECT COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales;

--- Average pizza per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_pizza_per_order FROM pizza_sales ;

---------- charts

-- daily trend for total_orders;
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales 
GROUP BY DATENAME(DW, order_date);

-- monthlu trend for total orders
SELECT DATENAME(MONTH, order_date) AS month_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY total_orders DESC;

-- sales by pizza_category
SELECT pizza_category, (SUM(total_price) * 100) / (SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) =1)
AS PCT_category_wise_sales
FROM pizza_sales
WHERE MONTH(order_date) =1
GROUP BY pizza_category;

-- % sales by pizza size
SELECT pizza_size, CAST((SUM(total_price) * 100) / (SELECT SUM(total_price) from pizza_sales WHERE DATEPART(quarter,order_date) = 1) 
AS DECIMAL(10,2)) AS PCT  
FROM pizza_sales
WHERE DATEPART(quarter,order_date) = 1
GROUP BY pizza_size; 


select * from pizza_sales;

-- top 5 best sellers by revenue, total quantity, total orders
SELECT TOP 5 pizza_name, SUM(total_price) AS total_revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue desc;

-- by quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity desc;

--by order
SELECT TOP 5 pizza_name,  COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders desc;

-- bottom 5 best sellers by revenue, total quantity, total orders
SELECT TOP 5 pizza_name, SUM(total_price) AS total_revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ;

-- by quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS total_quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity ;

-- by order
SELECT TOP 5 pizza_name,  COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders;