USE flipkart;

SELECT t1.order_id,SUM(t2.profit) FROM orders t1
JOIN order_details t2
ON t1.order_id = t2.order_id
GROUP BY t1.order_id
HAVING SUM(t2.profit) > 0;

SELECT t2.name, COUNT(t2.name) AS 'num_orders' FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id
GROUP BY  t2.name
ORDER BY num_orders DESC;