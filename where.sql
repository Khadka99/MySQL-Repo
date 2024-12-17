USE revision;

SELECT * 
FROM smartphones
WHERE brand_name = 'samsung';

SELECT *  
FROM smartphones
WHERE price > 50000;

SELECT * 
FROM smartphones
WHERE price > 50000 AND brand_name = 'samsung';

SELECT * FROM smartphones
WHERE price > 10000 and price < 20000;

SELECT * FROM smartphones
WHERE price BETWEEN 10000 AND 20000;

SELECT * FROM smartphones
WHERE price < 15000 AND rating > 80 AND processor_brand = 'snapdragon';

SELECT * FROM smartphones
WHERE brand_name = 'samsung' AND ram_capacity > 8;


