--retrieving all data
SELECT * FROM customer;
SELECT * FROM products;
SELECT * FROM sales;
-- Daily sales revenue
SELECT 
    order_date,
    SUM(total_amount) AS daily_revenue,
    COUNT(sales_id) AS transactions
FROM dbo.sales
GROUP BY order_date
ORDER BY order_date;

-- Monthly sales revenue
SELECT 
    FORMAT(order_date, 'yyyy-MM') AS month,
    SUM(total_amount) AS monthly_revenue,
    COUNT(sales_id) AS transactions
FROM dbo.sales
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY month;
-- Top products by revenue
SELECT 
    p.product_name,
    p.category,
    SUM(s.total_amount) AS total_revenue,
    SUM(s.quantity) AS total_units_sold
FROM dbo.sales s
JOIN dbo.products p ON s.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC;

-- Top products by quantity sold
SELECT 
    p.product_name,
    SUM(s.quantity) AS units_sold
FROM dbo.sales s
JOIN dbo.products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC;
-- Customer lifetime value (total spend)
SELECT 
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    c.city,
    c.province,
    SUM(s.total_amount) AS lifetime_value,
    COUNT(s.sales_id) AS total_orders
FROM dbo.sales s
JOIN dbo.customer c ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city, c.province
ORDER BY lifetime_value DESC;

-- Average order value per customer
SELECT 
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    AVG(s.total_amount) AS avg_order_value
FROM dbo.sales s
JOIN dbo.customer c ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY avg_order_value DESC;

-- Revenue by province
SELECT 
    province,
    SUM(total_amount) AS revenue,
    COUNT(sales_id) AS transactions
FROM dbo.sales
GROUP BY province
ORDER BY revenue DESC;

-- Revenue by city
SELECT 
    city,
    SUM(total_amount) AS revenue,
    COUNT(sales_id) AS transactions
FROM dbo.sales
GROUP BY city
ORDER BY revenue DESC;
-- Revenue by province
SELECT 
    province,
    SUM(total_amount) AS revenue,
    COUNT(sales_id) AS transactions
FROM dbo.sales
GROUP BY province
ORDER BY revenue DESC;

-- Revenue by city
SELECT 
    city,
    SUM(total_amount) AS revenue,
    COUNT(sales_id) AS transactions
FROM dbo.sales
GROUP BY city
ORDER BY revenue DESC;
-- Revenue by province
SELECT 
    province,
    SUM(total_amount) AS revenue,
    COUNT(sales_id) AS transactions
FROM dbo.sales
GROUP BY province
ORDER BY revenue DESC;

-- Revenue by city
SELECT 
    city,
    SUM(total_amount) AS revenue,
    COUNT(sales_id) AS transactions
FROM dbo.sales
GROUP BY city
ORDER BY revenue DESC;

SELECT 
    payment_method,
    COUNT(sales_id) AS transactions,
    SUM(total_amount) AS total_revenue
FROM dbo.sales
GROUP BY payment_method
ORDER BY total_revenue DESC;

SELECT 
    p.product_name,
    p.category,
    p.stock - SUM(s.quantity) AS remaining_stock
FROM dbo.products p
LEFT JOIN dbo.sales s ON p.product_id = s.product_id
GROUP BY p.product_name, p.category, p.stock
ORDER BY remaining_stock ASC;

