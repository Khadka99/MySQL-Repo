-- Independent Subquery with Row Subquery(One col multiple Rows) --
USE zomato;
-- Find all user who never orderd
SELECT * FROM users
WHERE user_id NOT IN (SELECT DISTINCT(user_id) 
								FROM orders);
-- This is a Row subquery because the inner query returns only one column
-- with multiple rows(RUN THE INNER QUERY)

-- Find all the movies made by top 3 Directors(In terms of Total Gross Income)
USE revision;

WITH top_director AS (SELECT director FROM movies
						 GROUP BY director
						 ORDER BY SUM(gross) DESC
						 LIMIT 3)
SELECT * FROM movies
WHERE director IN (SELECT * 
						FROM top_director)
ORDER BY director DESC;

-- Find all movies of all those actors whose fillmography's avg rating > 8.5
-- (take 25000 votes as cutoff)
SELECT *
FROM movies
WHERE star IN (SELECT star
					 FROM movies
					 WHERE votes > 25000
					 GROUP BY star
					 HAVING AVG(score) > 8.5 );

WITH filtered_stars AS (
						SELECT star
						FROM movies
						WHERE votes > 25000
						GROUP BY star
						HAVING AVG(score) > 8.5
												)
SELECT *
FROM movies
WHERE star IN (SELECT star FROM filtered_stars);

