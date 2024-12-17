USE revision;

SELECT brand_name,model,screen_size,rating FROM smartphones
WHERE brand_name = 'apple'
ORDER BY brand_name ASC, rating DESC;
-- LIMIT can be used as LIMIT(X,Y) here x is position of row number and 
-- y is total number of rows.
-- ex.. LIMIT(2,3) means from row number 3rd to 5th( row first number starts with 0)
SELECT model,battery_capacity
 FROM smartphones
 ORDER BY battery_capacity DESC
 LIMIT 2,1;
 
 SELECT model,rating 
 FROM smartphones
 WHERE brand_name = 'apple'
 ORDER BY rating ASC
 LIMIT 5;
 
 -- second worst apple phone on rating
  SELECT model,rating 
 FROM smartphones
 WHERE brand_name = 'apple'
 ORDER BY rating ASC
 LIMIT 1,1;
 
 
 
 
 
 