USE revision;

-- 1. ID -> ID of every records to our dataset. It has integer datatype.
-- 2. Name -> Name of the athletes.
-- 3. Sex -> Gender of the athletes.
-- 4. Height -> Height of the athletes
-- 5. Weight -> Weight of the athletes
-- 6. NOC -> In which country, the athletes belong to. This is actually the country code.
-- 7. Year -> In which year, the athlete has participated
-- 8. Sport -> What is the sport name in which the athlete participated.
-- 9. Event -> Event name of the sport
-- 10. Medal -> Which medal the athlege got. If the athlete did not get any medal then this cell is blank.
-- 11. country -> The name of the country.
-- --------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------
-- Q1. Display the names of athletes who won a gold medal in the 2008 Olympics and whose height
-- is greater than the average height of all athletes in the 2008 Olympics.
		SELECT Name,Year,Event,Medal
		FROM olympics
		WHERE Medal = 'Gold' AND Year = 2008
		ORDER BY Name ASC;

-- Q2. Display the names of athletes who won a medal in the sport of basketball in the 2016
-- Olympics and whose weight is less than the average weight of all athletes who won a medal
-- in the 2016 Olympics.
			SELECT * FROM olympics
			WHERE Weight < (SELECT AVG(Weight) FROM olympics)
						AND Sport = 'Basketball' 
						AND Year = 2016;
-- Q3. Display the names of all athletes who have won a medal in the sport of 
-- swimming in both the 2008 and 2016 Olympics.
		SELECT * FROM olympics
		WHERE Sport = 'Swimming' AND (Year = 2008 OR Year = 2016);
		-- Same result can be achieved from below query.
		SELECT * 
				FROM olympics
				WHERE Sport = 'Swimming' 
						AND Year IN (2008,2016)
						AND Medal IN ('Gold','Bronze','Silver');
-- Q4. Display the names of all countries that have won more than 50 medals in a single year.
		SELECT Country
		FROM olympics
		WHERE Medal IN ('Gold','Bronze','Silver');

		SELECT Country,Year,
		(SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) +
		SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) +
		SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END)) AS 'Total_Medal'
		FROM olympics t1
		GROUP BY Country,Year
		HAVING Total_Medal > 50
		ORDER BY Year DESC;

-- Q5. Display the names of all athletes who have won medals in more than one sport in the same year.
		SELECT Name,Year,COUNT(DISTINCT Sport) AS 'Num_Sport' FROM olympics
		WHERE Medal IN ('Gold','Bronze','Silver')
		GROUP BY Name,Year
		HAVING Num_Sport > 1
		ORDER BY Num_Sport DESC;
-- Q6. What is the average weight difference between male and female athletes in the Olympics who have won a medal in the same event.
SELECT * FROM olympics
WHERE Medal IN ('Gold','Bronze','Silver');

SELECT AVG(A.Sex-B.Sex) FROM (SELECT * FROM olympics
WHERE Medal IS NOT NULL) A 
JOIN 
(SELECT * FROM olympics
WHERE Medal IS NOT NULL) B
ON A.Event = B.Event AND
A.sex != B.Sex;
WITH result AS (SELECT * FROM olympics
					WHERE Medal IS NOT NULL)
SELECT AVG(A.Weight - B.Weight) FROM result A
JOIN result B
ON A.Event = B.Event AND
A.Sex != B.Sex AND
A.Country = B.Country;
-- Q7. How many patients have claimed more than the average claim amount for patients who are smokers and have at least one child, and belong to the southeast region?
-- This is according to the campus-X Which is wrong
			SELECT * FROM insurance
			WHERE claim > (SELECT AVG(claim) FROM insurance
								WHERE  smoker = 'Yes' 
								AND children = 1 
								AND region = 'southeast');
-- This is the correct answer                    
			SELECT * FROM insurance
			WHERE claim > (SELECT AVG(claim) FROM insurance)
								AND  smoker = 'Yes' 
								AND children = 1 
								AND region = 'southeast';
-- Q8. How many patients have claimed more than the average claim amount for patients who are not smokers and have 
-- a BMI greater than the average BMI for patients who have at least one child?
-- This is according to the campus-X Which is wrong
			SELECT COUNT(claim) FROM insurance
			WHERE claim > (SELECT AVG(claim) FROM insurance
			WHERE smoker = 'No' AND bmi > (SELECT AVG(bmi) FROM insurance
			WHERE children >=1));
-- This is the correct answer
			SELECT COUNT(claim) FROM insurance
			WHERE claim > (SELECT AVG(claim) FROM insurance)
							AND bmi > (SELECT AVG(bmi) FROM insurance)
			AND children >=1
			AND smoker = 'No';
-- Q9. How many patients have claimed more than the average claim amount for patients
--  who have a BMI greater than the average BMI for patients who are diabetic, have
--  at least one child, and are from the southwest region?
-- This is according to the campus-X Which is wrong.......
			SELECT COUNT(claim) FROM insurance
			WHERE claim > (SELECT AVG(claim) FROM insurance
							WHERE
							 bmi > (SELECT AVG(bmi) FROM insurance
						WHERE children >=1
						AND region = 'southwest'
						AND  diabetic = 'Yes'));
-- This is the correct answer
				SELECT COUNT(claim) FROM insurance
							WHERE claim > (SELECT AVG(claim) FROM insurance)
										AND bmi > (SELECT AVG(bmi) FROM insurance)
										AND children >=1
										AND region = 'southwest'
										AND  diabetic = 'Yes';
-- Q10. What is the difference in the average claim amount between patients who are
-- smokers and patients who are non-smokers, and have the same BMI and number of children?
SELECT AVG(ABS( t1.claim - t2.claim)) FROM insurance t1
JOIN insurance t2 
ON t1.bmi = t2.bmi AND
   t1.children = t2.children AND
   t1.smoker != t2.smoker;
   
   
SELECT bmi, children, AVG(claim) AS smoker_avg_claim, (
    SELECT AVG(claim)
    FROM insurance AS non_smoker
    WHERE non_smoker.bmi = smoker.bmi
    AND non_smoker.children = smoker.children
    AND non_smoker.smoker = 'No'
) AS non_smoker_avg_claim, AVG(claim) - (
    SELECT AVG(claim)
    FROM insurance AS non_smoker
    WHERE non_smoker.bmi = smoker.bmi
    AND non_smoker.children = smoker.children
    AND non_smoker.smoker = 'No'
) AS claim_diff
FROM insurance AS smoker
WHERE smoker.smoker = 'Yes'
GROUP BY smoker.bmi, smoker.children
having claim_diff is not null;











