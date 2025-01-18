/* 
Explotary Data Analysis
EDA Plan.......
1. Head-> Tail->SAmple
2. For numerical columns
   - 8 number summary [count,min,max,mean,std,Q1,Q2,Q3]
   - missing values
   - outliers
   ->Horizontal/Vertical Histogram
3. For Categorical columns
   - Value Count -> Pie Chart
   - Missin VALUES
4. Numerical - Numerical
   - Side by side * number analysis.
   - Scatterplot
   - Correlation
5. Categorical - Categorical
   - Contengency Table -> Stacked bar Chart
6. Numerical - Categorical
   - Compare Distribution across categories
7. Missin values Treatment
8. Feature Engineering
   - PPI
   - Price_bracket
9. One Hot Encoding
*/
-- ------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------

USE revision;

-- Describe data
DESCRIBE laptops;

-- 1. Head
SELECT * FROM laptops
ORDER BY `Index` 
LIMIT 5;

-- Tail
SELECT * FROM laptops
ORDER BY `Index` DESC
LIMIT 5;

-- SAmple
SELECT * FROM laptops
ORDER BY rand()
LIMIT 5;

/* 2. For numerical columns
   - 8 number summary [count,min,max,mean,std,Q1,Q2,Q3]*/
   SELECT COUNT(Price) OVER(),
   MIN(Price) OVER(),
   MAX(Price) OVER(),
   AVG(Price) OVER(),
   STD(Price) OVER(),
   PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY Price) OVER() AS 'Q1',
   PERCENTILE_CONT(0.50) WITHIN GROUP(ORDER BY Price) OVER() AS 'Median',
   PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY Price) OVER() AS 'Q3'
   FROM laptops
   ORDER BY `Index`
   LIMIT 1;

-- Missing Value
SELECT COUNT(Price)
FROM laptops
WHERE  Price IS NULL;

-- **Outliers**
/*Formula:
Lower Bound=Q1−1.5×IQR
Upper Bound=Q3+1.5×IQR */
SELECT * FROM (SELECT *,
				PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY Price) OVER() AS 'Q1',
				PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY Price) OVER() AS 'Q3'
				FROM laptops) t
WHERE t.Price < t.Q1 - (1.5*(t.Q3 - t.Q1)) OR
	  t.Price > t.Q3 + (1.5*(t.Q3 - t.Q1));

-- Horizontal/Vertical Histogram
SELECT t.buckets,REPEAT('*',COUNT(*)/5) FROM (SELECT Price,
CASE 
	WHEN Price BETWEEN 0 AND 25000 THEN '0-25K'
	WHEN Price BETWEEN 25001 AND 50000 THEN '25K-50K'
	WHEN Price BETWEEN 50001 AND 75000 THEN '50K-75K'
	WHEN Price BETWEEN 75001 AND 100000 THEN '75K-100K'
	WHEN Price > 100000 THEN '>100K'
END AS 'buckets'
FROM laptops) t
GROUP BY t.buckets;

/*3. For Categorical columns
   - Value Count -> Pie Chart
   - Missin VALUES */
   SELECT Company,COUNT(Company)
   FROM laptops
   GROUP BY Company;
   
   -- Bi-veriate columns (numerical-numerical)----------------------------------------------
SELECT cpu_speed,Price FROM laptops;
-- SELECT COR(cpu_speed,Price) FROM laptops There is no Correlation functions in MySQL.
-- We can Use Scatter Plot for Analysis


-- Bi-veriate columns (categorical-categorical) Contengency Table---------------------------------
SELECT Company,
SUM(CASE WHEN TouchScreen = 1 THEN 1 ELSE 0 END) AS 'Touchscreen_yes',
SUM(CASE WHEN TouchScreen = 0 THEN 1 ELSE 0 END) AS 'Touchscreen_no' 
FROM laptops
GROUP BY Company;

SELECT Company,
SUM(CASE WHEN Cpu_brand = 'Intel' THEN 1 ELSE 0 END) AS 'Intel',
SUM(CASE WHEN Cpu_brand = 'AMD' THEN 1 ELSE 0 END) AS 'AMD',
SUM(CASE WHEN Cpu_brand = 'Samsung' THEN 1 ELSE 0 END) AS 'Samsung'
FROM laptops
GROUP BY Company;

 -- We can Use Staked Bar Chart For Analysis  
select * from laptops;

/*Numerical - Categorical
   - Compare Distribution across categories
   */
   SELECT Company,MIN(Price),
   MAX(Price),MIN(Price),ROUND(STD(Price),2)
   FROM laptops
   GROUP BY Company;
   
   -- Missin values Treatment
   /*
   Replacing missing values with mean(Since we dont have any missing values we do nothing).
UPDATE laptops
SET Price = (SELECT AVG(Price) FROM laptops)
   WHERE Price IS NULL;
   Replacing missing values with mean price of corresponding company
UPDATE laptops l1
SET Price = (SELECT * FROM laptops l2 WHERE l2.Company =l1.Company)
WHERE Price IS NULL;

corresponding company + Processor
UPDATE laptops l1
SET Price = (SELECT * FROM laptops l2 WHERE l2.Company =l1.Company AND l2.Cpu_name = l1.Cpu_name)
WHERE Price IS NULL;
   */
   
-- Feature Engineering
-- PPI
SELECT ROUND(SQRT(POW(Resolution_width, 2) + POW(Resolution_height, 2)) / Inches,2) AS PPI
FROM laptops;
-- Price_bracket
ALTER TABLE laptops
ADD COLUMN Screen_size VARCHAR(255) AFTER Inches;

SELECT *,
CASE
	WHEN Inches < 14.0 THEN 'Small'
    WHEN Inches >= 14.0 AND Inches < 17.0 THEN 'Medium'
    ELSE 'Large'
END
FROM laptops;

UPDATE laptops
SET Screen_size = CASE
	WHEN Inches < 14.0 THEN 'Small'
    WHEN Inches >= 14.0 AND Inches < 17.0 THEN 'Medium'
    ELSE 'Large'
END;

SELECT * FROM laptops;

--  One Hot Encoding
SELECT gpu_brand,
CASE WHEN gpu_brand = 'Intel' THEN 1 ELSE 0 END AS 'intel',
CASE WHEN gpu_brand = 'AMD' THEN 1 ELSE 0 END AS 'amd',
CASE WHEN gpu_brand = 'Nvidia' THEN 1 ELSE 0 END AS 'nvidia',
CASE WHEN gpu_brand = 'ARM' THEN 1 ELSE 0 END AS 'arm'
FROM laptops;
   
   


   
   
   












































































































