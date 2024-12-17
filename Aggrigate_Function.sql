USE revision;

SELECT MAX(price) FROM smartphones;

SELECT MAX(price) FROM smartphones
WHERE brand_name = 'samsung';

SELECT * FROM smartphones
WHERE brand_name = 'samsung' AND price = 110999;

SELECT ROUND(AVG(rating),2) FROM smartphones
WHERE brand_name = 'samsung';

SELECT COUNT(*) FROM smartphones
WHERE brand_name = 'oneplus';

SELECT COUNT(DISTINCT(brand_name)) FROM smartphones;

SELECT STD(screen_size) FROM smartphones;

SELECT VARIANCE(screen_size) FROM smartphones;


