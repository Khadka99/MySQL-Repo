USE revision;

-- Correlate Subquery
-- "In Correlated Subquery inside Subquery is Related to Outer Query"

-- Find all the movies that have a rating higher than the average rating of a movie?
SELECT * FROM movies m1
WHERE score > (SELECT AVG(score) FROM movies m2
WHERE m2.genre = m1.genre);

-- Find the favorite food of each customers?
USE zomato;

WITH fav_food AS (SELECT t2.user_id,t3.f_id,name,f_name, COUNT(*) AS 'frequency'
						FROM  users t1
						JOIN orders t2 ON 
						t1.user_id = t2.user_id
						JOIN order_details t3 ON 
						t2.order_id = t3.order_id
						JOIN food t4 ON 
						t3.f_id = t4.f_id
						GROUP BY t2.user_id,t3.f_id,name,f_name
)
SELECT * FROM fav_food f1
WHERE frequency = (SELECT MAX(frequency) FROM fav_food f2
						WHERE f2.user_id = f1.user_id);





