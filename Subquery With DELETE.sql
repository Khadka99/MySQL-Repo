USE zomato;

-- Subquery With DELETE

DELETE FROM users
WHERE user_id IN (SELECT user_id FROM users
WHERE user_id NOT IN ( SELECT DISTINCT(user_id) FROM orders));

-- This syntax is not working check with the video .. video time 2:10 SUBQUERY..

SELECT * FROM users;

SELECT user_id FROM users
WHERE user_id NOT IN ( SELECT DISTINCT(user_id) FROM orders);