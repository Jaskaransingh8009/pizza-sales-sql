-- ============================================================
-- PIZZA SALES SQL ANALYSIS
-- ============================================================

USE pizza_sales;


-- ============================================================
-- Q1. Total Number of Orders
-- ============================================================

SELECT COUNT(*) AS total_orders
FROM orders;


-- ============================================================
-- Q2. Total Revenue Generated
-- ============================================================

SELECT
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id;


-- ============================================================
-- Q3. Highest-Priced Pizza
-- ============================================================

SELECT
    pt.name AS pizza_name,
    p.size,
    p.price
FROM pizzas p
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;


-- ============================================================
-- Q4. Most Common Pizza Size Ordered
-- ============================================================

SELECT
    p.size,
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
LIMIT 1;


-- ============================================================
-- Q5. Top 5 Most Ordered Pizza Types
-- ============================================================

SELECT
    pt.name AS pizza_name,
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;


-- ============================================================
-- Q6. Total Quantity of Each Pizza Category
-- ============================================================

SELECT
    pt.category,
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity DESC;


-- ============================================================
-- Q7. Distribution of Orders by Hour
-- ============================================================

SELECT
    HOUR(time) AS order_hour,
    COUNT(*) AS total_orders
FROM orders
GROUP BY HOUR(time)
ORDER BY order_hour;


-- ============================================================
-- Q8. Category-wise Distribution of Pizza Types
-- ============================================================

SELECT
    category,
    COUNT(pizza_type_id) AS total_pizza_types
FROM pizza_types
GROUP BY category
ORDER BY total_pizza_types DESC;


-- ============================================================
-- Q9. Average Number of Pizzas Ordered Per Day
-- ============================================================

SELECT
    ROUND(AVG(daily_quantity), 2) AS avg_pizzas_per_day
FROM (
    SELECT
        o.date,
        SUM(od.quantity) AS daily_quantity
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    GROUP BY o.date
) AS daily_sales;


-- ============================================================
-- Q10. Top 3 Pizza Types by Revenue
-- ============================================================

SELECT
    pt.name AS pizza_name,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;


-- ============================================================
-- Q11. Percentage Contribution of Each Pizza Type to Revenue
-- ============================================================

SELECT
    pt.name AS pizza_name,
    ROUND(
        SUM(od.quantity * p.price)
        /
        (
            SELECT SUM(od2.quantity * p2.price)
            FROM order_details od2
            JOIN pizzas p2
                ON od2.pizza_id = p2.pizza_id
        )
        * 100,
        2
    ) AS revenue_percentage
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue_percentage DESC;


-- ============================================================
-- Q12. Cumulative Revenue Over Time
-- ============================================================

SELECT
    o.date,
    ROUND(SUM(od.quantity * p.price), 2) AS daily_revenue,
    ROUND(
        SUM(SUM(od.quantity * p.price))
        OVER (ORDER BY o.date),
        2
    ) AS cumulative_revenue
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY o.date
ORDER BY o.date;


-- ============================================================
-- Q13. Top 3 Pizza Types by Revenue in Each Category
-- ============================================================

WITH pizza_revenue AS (
    SELECT
        pt.category,
        pt.name AS pizza_name,
        SUM(od.quantity * p.price) AS total_revenue
    FROM order_details od
    JOIN pizzas p
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt
        ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
),
ranked_pizzas AS (
    SELECT
        category,
        pizza_name,
        ROUND(total_revenue, 2) AS total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_revenue DESC
        ) AS pizza_rank
    FROM pizza_revenue
)
SELECT
    category,
    pizza_name,
    total_revenue,
    pizza_rank
FROM ranked_pizzas
WHERE pizza_rank <= 3
ORDER BY category, pizza_rank;