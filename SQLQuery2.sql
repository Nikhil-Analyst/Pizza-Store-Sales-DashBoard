use [Piiza DB];

select*
from pizza_sales
-- 1. Total Revenue:
select SUM(round(total_price,0)) AS Total_Revenue
from pizza_sales
-- 2. Average Order Value 
select SUM(total_price) / count(distinct order_id) as Avg_Revenue
from pizza_sales
-- 3.Total Pizzas Sold
select SUM(quantity) as Total_pizza_sold
from pizza_sales
-- 4.Total Orders
select count(distinct order_id)AS Total_orders
from pizza_sales
-- 5.Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales
-- 6.Daily Trend for Total Orders
select DATENAME(dw,order_date) as order_day, COUNT(distinct order_id)
from pizza_sales
group by DATENAME(dw,order_date)
-- 7. Monthly Trend for Orders
	select pizza_category, sum(total_price) as Total_sales, 
	SUM(total_price)*100/ (select SUM(total_price)from pizza_sales where MONTH(order_date) = 1) as percentage_Total_sales
	from pizza_sales
	where MONTH(order_date) = 1
	group by pizza_category
-- 8. % of Sales by Pizza Category

	SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS percentage_pizza_sales
	FROM pizza_sales
	GROUP BY pizza_category

-- 9. % of Sales by Pizza Size
	select pizza_size, cast(sum(total_price)as decimal (10,2)) as Total_revenue, 
	cast(SUM(total_price)*100 / (select SUM(total_price)from pizza_sales) as decimal (10,2)) as percentage_Total_sales
	from pizza_sales
	group by pizza_size
	order by percentage_Total_sales desc
	-- 10. Top 5 Pizzas by Revenue
	select top 5 pizza_name, SUM(total_price) as Total_revenue
	from pizza_sales
	group by pizza_name
	order by Total_revenue desc;

	-- 11. Bottom 5 Pizzas by Revenue
	select top 5 pizza_name, SUM(total_price) as Total_revenue
	from pizza_sales
	group by pizza_name
	order by Total_revenue asc;

	-- 12. Top 5 Pizzas by Total Orders
	select top 5 pizza_name, COUNT(distinct order_id) as Total_orders
	from pizza_sales
	group by pizza_name
	order by Total_orders desc;

	-- 13. Top 5 Pizzas by Quantity

	select top 5 pizza_name, SUM(quantity) as Total_quantity
	from pizza_sales
	group by pizza_name
	order by Total_quantity desc;

