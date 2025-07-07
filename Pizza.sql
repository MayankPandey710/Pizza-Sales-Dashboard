CREATE DATABASE Dashboard;
USE Dashboard;

-- total number of orders placed 
SELECT COUNT(order_id) as total_orders from orders;

-- total revenue of pizza sales 
SELECT ROUND(SUM(order_details.quantity * pizzas.price),2) as TotalSales 
from order_details join pizzas 
on pizzas.pizza_id = order_details.pizza_id;

SELECT order_details.quantity * pizzas.price as TotalSales 
from order_details join pizzas 
on pizzas.pizza_id = order_details.pizza_id;

-- Check for null values
SELECT 
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_orders,
    SUM(CASE WHEN pizza_id IS NULL THEN 1 ELSE 0 END) AS null_pizzas
FROM order_details;

-- Identify highest pizza price
SELECT pizza_types.name, pizzas.price
from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price DESC LIMIT 1; 

-- most commonly ordered pizzas 
SELECT pizza_types.name, order_details.quantity as quantity
from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity DESC LIMIT 5;

SELECT pizza_types.name, SUM(order_details.quantity) as quantity
from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity DESC LIMIT 5;

-- total quantity ordered of each category  
SELECT pizza_types.category, SUM(order_details.quantity) as quantity 
from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details 
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc;

-- top revenue generating pizzas 
SELECT pizza_types.name, ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_revenue
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY total_revenue DESC
LIMIT 5;

-- weekly analysis 
SELECT 
    DAYNAME(orders.date) AS day,
    COUNT(DISTINCT orders.order_id) AS total_orders,
    SUM(order_details.quantity) AS total_pizzas,
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
GROUP BY day
ORDER BY FIELD(day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- monthly 

SELECT *
FROM orders
WHERE orders.date IS NULL;

-- daywise 
SELECT 
    HOUR(orders.time) AS hour_of_day,
    COUNT(DISTINCT orders.order_id) AS order_count,
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
GROUP BY hour_of_day
ORDER BY hour_of_day;


-- Monthly analysis of pizza sales
SELECT 
    MONTHNAME(orders.Order_Date) AS month,
    COUNT(DISTINCT orders.Order_ID) AS total_orders,
    SUM(order_details.Quantity) AS total_pizzas_sold,
    ROUND(SUM(order_details.Quantity * pizzas.price), 2) AS total_revenue
FROM orders
JOIN order_details ON orders.Order_ID = order_details.Order_ID
JOIN pizzas ON pizzas.pizza_id = order_details.Pizza_ID
GROUP BY MONTH(orders.Order_Date), month
ORDER BY MONTH(orders.Order_Date);

-- Monthly Sales Analysis
SELECT 
    MONTHNAME(o.date) AS month,
    COUNT(DISTINCT o.Order_ID) AS total_orders,
    SUM(od.Quantity) AS total_pizzas_sold,
    ROUND(SUM(od.Quantity * p.price), 2) AS total_revenue
FROM orders o
JOIN order_details od ON o.Order_ID = od.Order_ID
JOIN pizzas p ON p.pizza_id = od.Pizza_ID
GROUP BY MONTH(o.date), MONTHNAME(o.date)
ORDER BY MONTH(o.date);

-- hourly analysis
SELECT 
    HOUR(o.time) AS hour_of_day,
    COUNT(DISTINCT o.Order_ID) AS order_count,
    ROUND(SUM(od.Quantity * p.price), 2) AS revenue
FROM orders o
JOIN order_details od ON o.Order_ID = od.Order_ID
JOIN pizzas p ON p.pizza_id = od.Pizza_ID
GROUP BY hour_of_day
ORDER BY hour_of_day;
show tables;
