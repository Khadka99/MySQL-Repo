USE revision;



-- WHERE filter rows for SELECT
-- HAVING filters rows for GROUP BY
-- HAVING is used for filtering aggrigate function


SELECT brand_name,COUNT(brand_name) AS 'count', ROUND(AVG(price),2) AS 'avg_price'
FROM smartphones
GROUP BY brand_name
HAVING count > 20
ORDER BY avg_price DESC;

SELECT brand_name,AVG(ram_capacity) AS 'avg_ram' FROM smartphones
WHERE refresh_rate > 90 AND fast_charging_available = 1
GROUP BY brand_name
HAVING count(*) > 10
ORDER BY avg_ram DESC
LIMIT 3;

SELECT brand_name,AVG(price) AS 'avg_price' FROM smartphones
WHERE has_5g = 'True'
GROUP BY brand_name
HAVING AVG(rating) > 70 AND COUNT(*) > 10;