USE revision;

SELECT * FROM movies
WHERE score = (SELECT MAX(score) FROM movies);

-- Independent subquery with Scalar subquery.
-- Q. Find the movie with the higest profit(vs order by)
SELECT * 
FROM movies 
WHERE (gross - budget) = (SELECT MAX(gross - budget) 
								FROM movies);
-- Same question using ORDER BY
SELECT * FROM movies
ORDER BY (gross - budget) DESC
LIMIT 1 ;

-- How many movies have a rating > avg of all the movies
-- rating(Find the count of above avg movies)
SELECT COUNT(*) FROM movies
WHERE score > (SELECT AVG(score) 
				FROM movies);

-- Find the higest rated movie of 2000
SELECT * FROM movies 
WHERE year = 2000 AND score = (SELECT MAX(score) FROM movies
WHERE year = 2000);

-- Find the highest rated movie among all movie whose number of
-- votes are > the dataset avg votes.
SELECT * FROM movies 
WHERE score = (SELECT MAX(score) 
				FROM movies
				WHERE votes > (SELECT AVG(votes) 
										FROM movies));






