use [pizza DB]
select * from pizza_sales_excel_file
  -- KPI--
select sum(total_price) Total_Revenue from pizza_sales_excel_file;
select sum(total_price)/count( distinct order_id) Avg_order_value from pizza_sales_excel_file;
select sum(quantity) Total_Pizzas_Sold from pizza_sales_excel_file;
select count(distinct order_id) Total_Orders from pizza_sales_excel_file;
select cast( cast(sum(quantity) as decimal(10,2))/ cast(COUNT(distinct order_id ) as decimal(10,2)) as decimal (10,2))Avg_Pizzas_per_order from pizza_sales_excel_file;
-- Hourly Trend for Total Pizzas Sold--
select DATEPART(HOUR,order_time) Order_Hour,sum(quantity) Pizzas_Sold from pizza_sales_excel_file 
group by DATEPART(HOUR,order_time) order by DATEPART(HOUR,order_time);
--Weekly Trend for Total Pizzas Sold--
select DATEPART(ISO_WEEK,order_date) as  Week_no,year(order_date) as Order_Year,count(distinct order_id) as Total_Pizzas_Sold 
from pizza_sales_excel_file 
group by DATEPART(ISO_WEEK,order_date) ,year(order_date)
order by DATEPART(ISO_WEEK,order_date) ,year(order_date)
--Percentage of Total Sales by Pizza Category--
select pizza_category,cast(sum(total_price) as decimal(10,2)) as Total_sales,cast(sum(total_price)*100/
(select sum(total_price) from pizza_sales_excel_file where month(order_date)=1)as decimal(10,2)) as PCT from pizza_sales_excel_file
 where month(order_date)=1
group by pizza_category;
--Percentage of Total Sales by Pizza Size--
select pizza_size,cast(sum(total_price) as decimal(10,2)) as Total_sales,cast(sum(total_price)*100/
(select sum(total_price) from pizza_sales_excel_file where datepart(quarter,order_date)=1 )as decimal(10,2)) as PCT from pizza_sales_excel_file
where datepart(quarter,order_date)=1
group by pizza_size;

--Top 5 Best sellers by Revenue--
select top 5  pizza_name,sum(total_price) as Total_Revenue from pizza_sales_excel_file
group by pizza_name order by Total_Revenue desc;

--Bottom 5 Best sellers by Revenue--
select top 5  pizza_name,sum(total_price) as Total_Revenue from pizza_sales_excel_file
group by pizza_name order by Total_Revenue asc;

 --Top 5 Best sellers by quantity--
 select top 5  pizza_name,sum(quantity) as Total_Quantity from pizza_sales_excel_file
group by pizza_name order by Total_Quantity  desc;

--Bottom 5 Best sellers by quantity --
select top 5  pizza_name,sum(quantity) as Total_Quantity from pizza_sales_excel_file
group by pizza_name order by Total_Quantity asc;

--Top 5 Best sellers by Orders--
select top 5  pizza_name,count(distinct order_id)as Total_Orders from pizza_sales_excel_file
group by pizza_name order by Total_Orders desc;

--Bottom 5 Best sellers by Orders --
select top 5  pizza_name,count(distinct order_id)as Total_Orders from pizza_sales_excel_file
group by pizza_name order by Total_Orders asc;