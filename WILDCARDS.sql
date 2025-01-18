USE revision;
SELECT * FROM movies;

-- all the movies name wich has exactly 5 charecters in it?
SELECT name FROM movies
WHERE name LIKE '_____'; -- it has 5 underscores.
-- name of a movies name starts with A.
SELECT name FROM movies
WHERE name LIKE 'A____';

-- name of a movies wich has 'man' in it
SELECT name FROM movies
WHERE name LIKE '%man%';

-- name of a movies wich starts with 'man'.
SELECT name FROM movies
WHERE name LIKE 'man%';

-- name of a movies wich ends with 'man'.
SELECT name FROM movies
WHERE name LIKE '%man';

