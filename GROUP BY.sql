USE revision;

SELECT * FROM smartphones;

SELECT brand_name,COUNT(brand_name) AS 'num_phones' ,ROUND(AVG(price),2) AS 'avg_price',
MAX(rating) AS 'max_rating',ROUND(AVG(screen_size),2) AS 'AVG_screen',
ROUND(AVG(battery_capacity),2) AS 'avg_battery'
FROM smartphones
GROUP BY brand_name
ORDER BY num_phones DESC;

SELECT has_nfc,ROUND(AVG(price),2) AS 'avg_price',
ROUND(AVG(rating),2) AS 'avg_rating'
FROM smartphones
GROUP BY has_nfc;

SELECT has_5G,ROUND(AVG(price),2) AS 'avg_price',
ROUND(AVG(rating),2) AS 'avg_rating'
FROM smartphones
GROUP BY has_5G;

SELECT fast_charging_available,ROUND(AVG(price),2) AS 'avg_price',
ROUND(AVG(rating),2) AS 'avg_rating'
FROM smartphones
GROUP BY fast_charging_available;

SELECT has_nfc,has_5G,ROUND(AVG(price),2) AS 'avg_price',
ROUND(AVG(rating),2) AS 'avg_rating'
FROM smartphones
GROUP BY has_5G,has_nfc;

SELECT brand_name, processor_brand,COUNT(brand_name) AS 'num_phones',
ROUND(AVG(primary_camera_rear),2) AS 'avg_camera_resolution'
FROM smartphones
GROUP BY  brand_name, processor_brand;

SELECT brand_name, ROUND(AVG(price),2) AS 'avg_price'
FROM smartphones
GROUP BY brand_name
ORDER BY avg_price DESC
LIMIT 5;

SELECT brand_name, ROUND(AVG(screen_size),2) AS 'avg_screen_size'
FROM smartphones
GROUP BY brand_name
ORDER BY avg_screen_size ASC
LIMIT 5;

SELECT brand_name,count(*) AS 'count' 
FROM smartphones
WHERE has_nfc = 'True' AND has_ir_blaster = 'True'
GROUP BY brand_name
ORDER BY count DESC
LIMIT 5;

SELECT has_nfc,AVG(price) AS 'avg_price'
FROM smartphones
WHERE brand_name = 'samsung'
GROUP BY has_nfc;

SELECT model,price
FROM smartphones
ORDER BY price DESC
LIMIT 1;



