USE revision;

-- Subquery with SELECT

-- Get the percentage of votes for each movie compared to the total number of votes?
SELECT name, ROUND((votes/(SELECT SUM(votes) FROM movies)) * 100,2) FROM movies;

-- Display all movie name ,genre,score and avg(score) of genre?
USE revision;
SELECT name,genre,score,(SELECT ROUND(AVG(score),2) from movies m2 WHERE m2.genre = m1.genre)
FROM movies m1


-- Why this is inefficient?