USE revision;

-- Independent Subquery with Table Subquery(Multi col Multi Row)

-- Find the most profitable movie of each year?
SELECT * FROM movies
WHERE (year,gross-budget) IN (SELECT year,MAX(gross - budget) AS 'profit' 
									FROM movies
									GROUP BY year)
ORDER BY gross DESC;

-- Find the highest rated movies of each genre votes cutoff of 25000?
SELECT * FROM movies
WHERE (genre,score) IN (SELECT genre,MAX(score) FROM movies
							WHERE votes > 25000
							GROUP BY genre)
AND votes > 25000;
-- Above subquery is taking too long to execute, so we use common table expression.                            
WITH higest_rating AS (SELECT genre,MAX(score) FROM movies
							WHERE votes > 25000
							GROUP BY genre)
SELECT * FROM movies
WHERE (genre,score) IN (SELECT * 
							FROM  higest_rating)
AND votes > 25000;

-- Find the highest grossing movies of 
-- top 5 actor/director combo in terms of total grossin income?
WITH star_director AS (SELECT star,director,MAX(gross)
							FROM movies
							GROUP BY star,director
							ORDER BY SUM(gross) DESC
							LIMIT 5)
SELECT * FROM movies
WHERE (star,director,gross) IN (SELECT * FROM star_director);








