-- Subquery With FROM

-- Display average rating of all the restaurants?

USE zomato;

SELECT r_name,avg_rating
FROM (SELECT r_id,AVG(restaurant_rating) AS 'avg_rating' 
FROM orders
GROUP BY r_id) t1 
JOIN restaurants t2
ON t1.r_id = t2.r_id