USE flipkart;

SELECT t1.order_id,t1.amount,t1.profit,t3.name FROM order_details t1
JOIN orders t2
ON t1.order_id = t2.order_id
JOIN users t3
ON t2.user_id = t3.user_id;