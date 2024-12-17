USE revision;
 -- Subquery With HAVING
-- Find genres having avg score > avg score of all the movies?

SELECT genre,ROUND(AVG(score),2) AS 'avg_score'
FROM movies
GROUP BY genre
HAVING AVG(score) > (SELECT AVG(score) FROM movies);
