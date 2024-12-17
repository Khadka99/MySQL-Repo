-- Window Practice

USE revision;

-- Problem 1: What are the top 5 patients who claimed the highest insurance amounts?
SELECT *,
RANK() OVER(ORDER BY claim DESC) AS 'max_claim'
 FROM insurance
 LIMIT 5;
 
 -- Problem 2: What is the average insurance claimed by patients based on the number of children they have?
SELECT children,avg_claim FROM (SELECT *,
				ROUND(AVG(claim) OVER(PARTITION BY children),2) AS 'avg_claim',
				ROW_NUMBER() OVER(PARTITION BY children) AS 'row_num'
				FROM insurance) t
	WHERE t.row_num = 1;
-- Problem 3: What is the highest and lowest claimed amount by patients in each region?
SELECT region,highest_claim,lowest_claim FROM (SELECT *,
				FIRST_VALUE(claim) OVER(PARTITION BY region ORDER BY claim DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS highest_claim,
				LAST_VALUE(claim) OVER(PARTITION BY region ORDER BY claim DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS lowest_claim,
				ROW_NUMBER() OVER(PARTITION BY region) as row_num
				FROM insurance) t
WHERE t.row_num = 1;
-- same as above
SELECT region,highest_claim,lowest_claim FROM (SELECT *,
											MAX(claim) OVER(PARTITION BY region) AS highest_claim,
											MIN(claim) OVER(PARTITION BY region) as lowest_claim,
											ROW_NUMBER() OVER(PARTITION BY region) as row_num
											FROM insurance) t
WHERE t.row_num = 1;

-- Problem 4: What is the percentage of smokers in each age group?
SELECT age, (COUNT(*)/1340) * 100 AS age_percentage
FROM insurance
GROUP BY age
ORDER BY age_percentage DESC;

-- Problem 5: What is the difference between the claimed amount of each patient and the first claimed amount of that patient?
SELECT *,
claim - FIRST_VALUE(claim) OVER() AS difference
FROM insurance;

-- Problem 6: For each patient, calculate the difference between their claimed amount and the average claimed amount of patients with the same number of children.
SELECT *,
ROUND(claim - ROUND(AVG(claim) OVER(PARTITION BY children),2),2) AS diff
FROM insurance;
-- Problem 7: Show the patient with the highest BMI in each region and their respective rank?
SELECT region,bmi,bmi_rank,over_all_rank FROM (SELECT *,
							RANK() OVER(ORDER BY bmi DESC) AS over_all_rank,
							RANK() OVER(PARTITION BY region ORDER BY bmi DESC) AS bmi_rank
							-- ROW_NUMBER() OVER(PARTITION BY region) AS row_num
							FROM insurance) t 
WHERE t.bmi_rank = 1;
-- Problem 8: Calculate the difference between the claimed amount of each patient and the claimed amount of the patient who has the highest BMI in their region.
SELECT *,
claim - FIRST_VALUE(claim) OVER(PARTITION BY region ORDER BY bmi DESC) AS diff_claim
FROM insurance;

/* Problem 9: For each patient, calculate the difference in claim amount between the patient and the patient with the highest claim amount among patients with the
													same  smoker status, within the same region. Return the result in descending order difference.*/
SELECT *,
(MAX(claim) OVER(PARTITION BY region,smoker) - claim)AS claim_diff
FROM insurance
ORDER BY claim_diff DESC;
-- Problem 10: For each patient, find the maximum BMI value among their next three records (ordered by age)?
SELECT *,
MAX(bmi) OVER(ORDER BY age ROWS BETWEEN 0 FOLLOWING AND 3 FOLLOWING)
FROM insurance;
-- Problem 11: For each patient, find the rolling average of the last 2 claims?
SELECT *,
 ROUND(AVG(claim) OVER (
        ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING
    ), 2) AS rolling_avg
 FROM insurance;
 
 /* Problem 12: Find the first claimed insurance value for male and female patients, 
 within each region order the data by patient age in ascending order, 
and only include patients who are non-diabetic and have a bmi value between 25 and 30.*/
/* =================================================================================
It is a good practice to use common table expression while using WINDOW FUNCTION.
We cannot use WHERE with WINDOW FUNCTION*/

WITH filtered_data AS (
			SELECT * FROM insurance
            WHERE diabetic = 'No' AND bmi BETWEEN 25 AND 30
)

SELECT region,gender,first_claim FROM (SELECT *,
			FIRST_VALUE(claim) OVER(PARTITION BY region,gender ORDER BY age) AS first_claim,
            ROW_NUMBER() OVER(PARTITION BY region,gender) AS row_num
			FROM filtered_data) t
 WHERE t.row_num = 1;
 














