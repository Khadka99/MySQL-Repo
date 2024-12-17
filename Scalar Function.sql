USE revision;

SELECT price - 100000 AS 'temp' FROM smartphones;

SELECT ABS(price - 100000) AS 'temp' FROM smartphones;

SELECT AVG(price) FROM smartphones
WHERE brand_name = 'samsung';

SELECT model,
ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size,2) AS 'ppi'
FROM smartphones;

SELECT CEIL(screen_size) FROM smartphones;

SELECT FLOOR(screen_size) FROM smartphones;

