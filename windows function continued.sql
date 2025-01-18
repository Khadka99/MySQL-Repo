USE revision;
-- Find the top 5 batter from all the ipl team?
SELECT * FROM (SELECT BattingTeam,batter,sum(batsman_run) AS 'total_run',
DENSE_RANK() OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC) AS 'rank_within_team'
FROM ipl
GROUP BY BattingTeam,batter) t
WHERE t.rank_within_team < 6;

-- Find what is the cumilative score of Virat Kohli in match no 50, 100 and 200?
SELECT * FROM (SELECT CONCAT("Match-",CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
SUM(batsman_run) AS 'runs_scored',
SUM(SUM(batsman_run)) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'cumilative_run'
 FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID) t
WHERE match_no = 'Match-50' OR match_no = 'Match-100' OR match_no = 'Match-200';

-- Find the cumilative average of Virat Kohli?
-- In this code window as w is not working, so we use complete over().
SELECT * FROM (SELECT CONCAT("Match-",CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
SUM(batsman_run) AS 'runs_scored',
SUM(SUM(batsman_run)) OVER w AS 'career_run',
AVG(SUM(batsman_run)) OVER w AS 'career_avg'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID
WINDOW  w AS (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) t;

SELECT *
FROM (
    SELECT 
        CONCAT("Match-", CAST(ROW_NUMBER() OVER (ORDER BY ID) AS CHAR)) AS match_no,
        SUM(batsman_run) AS runs_scored,
        SUM(SUM(batsman_run)) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS career_run,
        AVG(SUM(batsman_run)) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS career_avg
    FROM ipl
    WHERE batter = 'V Kohli'
    GROUP BY ID
    -- WINDOW w AS (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
) t;
-- Find the running(rolling) average (10 match window) of Virat Kohli?
SELECT *
FROM (
    SELECT 
        CONCAT("Match-", CAST(ROW_NUMBER() OVER (ORDER BY ID) AS CHAR)) AS match_no,
        SUM(batsman_run) AS runs_scored,
        SUM(SUM(batsman_run)) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS career_run,
        AVG(SUM(batsman_run)) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS career_avg,
        AVG(SUM(batsman_run)) OVER (ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS rolling_avg
    FROM ipl
    WHERE batter = 'V Kohli'
    GROUP BY ID)t;
-- ---------------------------------------------------------------------------

-- What is the percent total of particular restaurant for its product?
USE zomato;
SELECT f_name,(total_value/SUM(total_value) OVER()) * 100 AS 'percent_of_total'
FROM (SELECT f_id, SUM(amount) AS 'total_value' FROM orders t1
JOIN order_details t2
ON t1.order_id = t2.order_id
WHERE r_id = 1
GROUP BY f_id) t
JOIN food t3
ON t.f_id = t3.f_id
ORDER BY percent_of_total DESC;
    
    


