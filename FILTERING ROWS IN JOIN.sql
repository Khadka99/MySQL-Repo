USE flipkart;

SELECT * FROM orders t1
JOIN 	users t2
ON t1.user_id = t2.user_id
WHERE t2.city = 'Pune'