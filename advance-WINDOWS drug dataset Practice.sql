USE revision;
-- Problem-6: For each condition, what is the average satisfaction level of drugs that are "On Label" vs "Off Label"?
/* In SQL, using backticks (``) around column names like SELECT Condition FROM drug; is primarily used for 
**Handling Special Characters or Reserved Words:**
		- Sometimes, column or table names might contain special characters (e.g., spaces, hyphens) or are reserved keywords (e.g., SELECT, FROM, WHERE).
		- In such cases, using backticks ensures that SQL understands the column name correctly.
Here SELECT Condition AVG(Satisfaction) AS 'avg_satisfaction' FROM drug Is not working its throwing error, So we use backticks (``) around Condition.
*/
	WITH temp_df AS (SELECT 
					`Condition`,Indication,Satisfaction,
					ROUND(AVG(Satisfaction) OVER(PARTITION BY `Condition`, Indication ORDER BY Satisfaction
								ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),2) AS avg_satisfaction,
					DENSE_RANK() OVER(PARTITION BY `Condition`, Indication ORDER BY Satisfaction) AS 'rank'
				FROM drug)
SELECT temp_df.`Condition`,temp_df.Indication,temp_df.avg_satisfaction
FROM temp_df
WHERE temp_df.rank = 1;

-- Problem-7: For each drug type (RX, OTC, RX/OTC), what is the average ease of use and satisfaction level of drugs with a price above the median for their type?

WITH temp_df AS (
					SELECT Type,ROUND(AVG(EaseOfUse) OVER(PARTITION BY Type),2) AS 'avg_ease_of_use',
					ROUND(AVG(Satisfaction) OVER(PARTITION BY Type),2) AS 'avg_satisfaction'
					FROM (SELECT Type,Price,EaseOfUse,Satisfaction,
							PERCENTILE_CONT(.50) WITHIN GROUP(ORDER BY Price) 
							OVER(PARTITION BY Type)  AS 'median_price'
							 FROM drug
							 WHERE Type IN ('RX', 'OTC', 'RX/OTC')) T
					WHERE Price >= median_price)
SELECT temp_df.Type,temp_df.avg_ease_of_use,temp_df.avg_satisfaction
FROM temp_df
GROUP BY temp_df.Type;
/* Problem 8: What is the cumulative distribution of EaseOfUse ratings for each drug type (RX, OTC, RX/OTC)? 
Show the results in descending order by drug type and cumulative distribution. (Use the built-in method and the manual method by calculating on your own.
 For the manual method, use the "ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW" and see if you get the same results as the built-in method.) */

/* Cumulative Distribution in MySQL
Cumulative distribution in MySQL is a statistical concept used to measure the relative position of a data point within a dataset or a specific group. 
It determines the proportion of rows that have values less than or equal to the current row's value.
Key Characteristics
Range: The result of cumulative distribution is a value between 0 and 1.
A value of 0.5 means the current row's value is in the middle of the dataset.
A value of 1.0 means the current row's value is the largest (or equal to the largest) in the dataset.

Partitioning: You can calculate cumulative distribution within specific groups by using the PARTITION BY clause.

Ordering: The calculation depends on the ORDER BY clause, which specifies how rows are ranked within the dataset or group.
Syntax:
CUME_DIST() OVER ([PARTITION BY column_name] ORDER BY column_name ASC|DESC) */

SELECT Type,EaseOfUse,
CUME_DIST() OVER(PARTITION BY Type ORDER BY EaseOfUse) AS cum_dist_built_in,
 COUNT(*) OVER (
            PARTITION BY Type
            ORDER BY EaseOfUse
        ) * 1.0 / COUNT(*) OVER (PARTITION BY Type) AS cumulative_dist_manual
 FROM drug
 WHERE Type IN ('RX', 'OTC', 'RX/OTC')
 ORDER BY Type,cum_dist_built_in DESC;
 -- Problem 9: What is the median satisfaction level for each medical condition? Show the results in descending order by median satisfaction level.
 -- (Don't repeat the same rows of your result.)-

WITH median_df AS ( SELECT `Condition`,Satisfaction,
					ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP(ORDER BY Satisfaction) OVER(PARTITION BY `Condition`),2) AS median_satisfaction
					FROM drug)
SELECT median_df.`Condition`,median_df.median_satisfaction
FROM median_df
GROUP BY median_df.`Condition`
ORDER BY median_df.median_satisfaction DESC;

-- Problem 10: What is the running average of the price of drugs for each medical condition? Show the results in ascending order by medical condition and drug name.
WITH df AS (
			SELECT `Condition`,Drug,Price,
			ROUND(AVG(Price) OVER(PARTITION BY `Condition` ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) AS runnig_avg
			FROM drug)
SELECT df.`Condition`,df.Drug,df.runnig_avg
FROM df
ORDER BY df.`Condition`,df.Drug;
-- **Using temp df just to avoid Price column.......**

-- Problem 11: What is the percentage change in the number of reviews for each drug between the previous row and the current row? 
-- Show the results in descending order by percentage change.
SELECT `Condition`,Drug,Reviews,
ROUND(ABS((Reviews - LAG(Reviews) OVER(PARTITION BY `Condition`,Drug ORDER BY Reviews DESC)) * 100 /
LAG(Reviews) OVER(PARTITION BY `Condition`,Drug ORDER BY Reviews DESC)),2) AS 'percentage_change_in_reviews'
FROM drug
ORDER BY percentage_change_in_reviews DESC;

-- Problem 12: What is the percentage of total satisfaction level for each drug type (RX, OTC, RX/OTC)? 
-- Show the results in descending order by drug type and percentage of total satisfaction.
WITH df AS(
			SELECT Type,Satisfaction,
			ROUND((SUM(Satisfaction) OVER(PARTITION BY Type) / SUM(Satisfaction) OVER())*100,2) AS 'satisfaction_level'
			FROM drug
			WHERE Type IN ('RX', 'OTC', 'RX/OTC')
			ORDER BY Type,satisfaction_level DESC
            )
SELECT df.Type,df.satisfaction_level
FROM df
GROUP BY df.Type;

-- Problem 13: What is the cumulative sum of effective ratings for each medical condition and drug form combination? 
-- Show the results in ascending order by medical condition, drug form and the name of the drug.
SELECT `Condition`,Form,Drug,Effective,
SUM(Effective) OVER(PARTITION BY `Condition`,Form ORDER BY Drug ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Cum_rating'
FROM drug
ORDER BY `Condition`,Form,Drug;

-- Problem-14: What is the rank of the average ease of use for each drug type (RX, OTC, RX/OTC)? 
-- Show the results in descending order by rank and drug type.
SELECT * FROM drug;
SELECT Type,ROUND(AVG(EaseOfUse),2) AS avg_EaseOfUse,
RANK() OVER(ORDER BY AVG(EaseOfUse) DESC) AS 'Rank'
FROM drug
WHERE Type IN('RX', 'OTC', 'RX/OTC')
GROUP BY Type
ORDER BY Rank;
-- Problem-15: For each condition, what is the average effectiveness of the top 3 most reviewed drugs?
SELECT T.`Condition`,T.Drug,T.avg_effectiveness,T.`rank`
FROM ( SELECT `Condition`,Drug,AVG(Effective) AS 'avg_effectiveness',
ROW_NUMBER() OVER(PARTITION BY `Condition` ORDER BY SUM(Reviews) DESC) AS 'rank'
FROM drug
GROUP BY `Condition`,Drug) T
WHERE `rank` <= 3
ORDER BY T.`Condition`,`rank`;








