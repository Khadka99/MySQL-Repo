USE zomato;

-- Find the numbers of rows in users.
SELECT COUNT(*) FROM users;

-- Return the  5 random records. Its like sample function from pandas.
SELECT * FROM users
ORDER BY rand()
LIMIT 5;

-- Find all NULL values.
SELECT * FROM orders
WHERE restaurant_rating IS NULL;

SELECT * FROM orders
WHERE restaurant_rating IS NOT NULL;

SELECT * FROM orders
WHERE restaurant_rating = 0;

-- To replace NULL values with zero.
-- UPDATE orders SET restaurant_rating = 0;

-- Find the numbers of orders placed by each customers. 

SELECT t2.user_id, t2.name, COUNT(*) AS '#orders'
FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id
GROUP BY t2.user_id, t2.name;

SELECT t2.name, COUNT(*) AS '#orders'
FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id
GROUP BY t2.name;

-- Find the restaurant with most numbers of menu items?

SELECT t2.r_id,t1.r_name, COUNT(*) AS '#orders'
FROM restaurants t1
JOIN menu t2
ON t1.r_id = t2.r_id
GROUP BY t2.r_id,t1.r_name;

-- Find numbers of votes and avg ratings for all the restaurants?
SELECT t1.r_name,COUNT(*) AS 'num votes',ROUND(AVG(t2.restaurant_rating),2) AS 'avg_rating' 
FROM restaurants t1
JOIN orders t2
ON t1.r_id = t2.r_id
WHERE t2.restaurant_rating IS NOT NULL
GROUP BY t1.r_name
ORDER BY avg_rating DESC;

-- Find the food that is sold at most numbers of restaurants?
SELECT f_name,COUNT(*)
FROM menu t1
JOIN food t2
ON t1.f_id = t2.f_id
GROUP BY f_name
ORDER BY COUNT(*) DESC
LIMIT 2;

-- Find restaurant with max revenue in a given month?
-- lets take month MAY.
-- SELECT  MONTHNAME(DATE(date)) FROM orders
SELECT t2.r_name,SUM(t1.amount) AS 'revenue'
FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE MONTHNAME(DATE(date)) = 'may'
GROUP BY t2.r_name
ORDER BY revenue DESC
LIMIT 1;

-- month by month revenue of a particular restaurants.
SELECT MONTHNAME(DATE(date)) AS 'months', SUM(amount) AS 'revenue'
FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE t2.r_name = 'kfc'
GROUP BY MONTH(date),months
ORDER BY MONTH(date);

-- Find the restaurant with sale > x_amount?
SELECT t1.r_id,r_name,SUM(amount) AS 'revenue'
FROM orders t1
JOIN restaurants t2
ON 	t1.r_id = t2.r_id
GROUP BY t1.r_id,r_name
HAVING revenue > 1500;

-- Find customers who never ordered?
SELECT user_id,name  
FROM users 
EXCEPT
SELECT t1.user_id,t2.name
FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id;

-- Show order details of a particular customer in a given date range?
SELECT t1.order_id,f_name,date
FROM orders t1
JOIN order_details t2
ON t1.order_id = t2.order_id
JOIN food t3
ON t2.f_id = t3.f_id
WHERE user_id =3 AND date BETWEEN '2022-05-15' AND '2022-06-15';

-- Customer favorite food?
SELECT t1.name,t4.f_name,t1.user_id,t3.f_id,count(*)
FROM users t1
JOIN orders t2
ON t1.user_id = t2.user_id
JOIN order_details t3
ON t2.order_id = t3.order_id
JOIN food t4
ON t3.f_id = t4.f_id
WHERE t1.user_id = 1
GROUP BY t1.name,t1.user_id,t3.f_id,t4.f_name
ORDER BY COUNT(*) DESC
LIMIT 1;

-- find the most expensive restaurants(avg price per dish)?
SELECT r_name,ROUND((SUM(price)/COUNT(*)),2) AS 'avg_price'
FROM menu t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
GROUP BY t1.r_id,r_name
ORDER BY avg_price DESC
LIMIT 1;

--  Find delivery partner compensation using the formula(num delivery*100 + 
-- 1000*avg_rating)
SELECT t1.partner_id,t2.partner_name,COUNT(*)*100 + ROUND(AVG(delivery_rating),2)*1000 AS 'salary'
FROM orders t1
JOIN delivery_partner t2
ON t1.partner_id = t2.partner_id
GROUP BY t1.partner_id,t2.partner_name
ORDER BY salary DESC;

-- Find correlation between delivery_time and total rating?
SELECT CORR(delivery_time,delivery_rating) AS 'corr'
FROM orders;

-- Find all the veg restaurants?
SELECT t1.r_id,r_name FROM menu t1
JOIN food t2
ON t1.f_id = t2.f_id
JOIN restaurants t3
ON t1.r_id = t3.r_id
GROUP BY t1.r_id,r_name
HAVING MIN(type) = 'Veg' AND MAX(type) = 'Veg';


-- Find min and max order value for all the customers?
SELECT name,MIN(amount),MAX(amount),AVG(amount) FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id
GROUP BY t1.user_id,name

















