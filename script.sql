use amazonsalesDB;

select * from amazon_sales;

-- Which category generates the highest total revenue?

select Category,
round(sum(Amount),2) as Total_Revenue
from amazon_sales
group by Category 
order by Total_Revenue desc limit 1;

-- Which category has the most orders?
-- Compare this with revenue to find volume vs value gaps?

select count(*) as total_order ,
Category
from amazon_sales
group by Category
order by total_order desc limit 1;

select Category,
count(*) as total_order,
sum(Amount) as total_revenue,
round(sum(amount)/count(*),2) as average_order_value
from amazon_sales
group by category
order by total_revenue desc; 
    
-- Which category has the highest cancellation rate?

select Category,
count(*) as total_order,
sum(case when Status like '%Cancelled%' then 1 else 0 end) as cancelled_order,
round(sum(case when Status like '%Cancelled%' then 1 else 0 end)*100.0/count(*),2)as cancelledRate
from amazon_sales
group by Category
order by cancelledRate desc;


-- Which category has the highest average order value?

select Category,
count(*) as total_order,
round(avg(Amount),2) as avg_value
from amazon_sales
group by Category
order by avg_value desc;

-- Does fulfilment type affect cancellation rate?


select Fulfilment,
count(*) as total_order,
round(sum(case when Status like '%Cancelled%' then 1 else 0 end)*100.0/count(*),2) as cancelled_rate
from amazon_sales
group by Fulfilment
order by cancelled_rate desc;

-- Does shipping service level affect cancellation rate?

select `ship-service-level` as ship_service,
count(*) as total_order,
round(sum(case when Status like '%Cancelled%' then 1 else 0 end)*100.0/count(*),2) as cancelled_rate
from amazon_sales
group by `ship-service-level`
order by cancelled_rate desc;

-- What is the overall order status breakdown?

select Status,
count(*)total_order
from amazon_sales
group by Status;

-- Which fulfilment type and shipping level combination
-- performs best? 

select
    Fulfilment,
    `ship-service-level` as shipping_level,
   count(*) as total_order,
  round(sum(case when Status like '%Cancelled%' then 1 else 0 end)*100.0/count(*),2) as cancelled_rate
FROM amazon_sales
GROUP BY Fulfilment, `ship-service-level`
ORDER BY cancelled_rate DESC;


-- Which states generate the most revenue?
select `ship-city`,
sum(Amount) as total_revenue
from amazon_sales
group by `ship-city`
order by total_revenue desc;

-- Which states have the highest average order value?
select `ship-city`,
round(avg(Amount),2) as avg_order
from amazon_sales
group by `ship-city`
order by avg_order desc;


-- B2B vs B2C — which segment is more valuable?

select 
case when B2B = 1 then 'B2B' else 'B2C' end as customer_type,
count(8) as total_order,
round(sum(Amount),2) as total_revenue,
round(avg(Amount),2) as avg_revenue
from amazon_sales
group by customer_type;
 
-- Which states have the most B2B orders?

select `ship-city`,
sum(case when B2B = 1 then 1 else 0 end) as customer_type,
count(*) as total_order
from amazon_sales
group by `ship-city`
order by customer_type desc;

-- Which month had the highest revenue?

select round(sum(Amount),2) as total_revenue,
month
from amazon_sales
group by Month
order by total_revenue desc;

-- What size sells the most?
select Size,sum(Qty) as total_qty
from amazon_sales
group by Size
order by total_qty desc;


-- Which category and state combination drives the most revenue?
select `ship-city`,
category,
round(sum(Amount),2) as total_revenue
from amazon_sales
group by Category,`ship-city`
order by total_revenue desc;



