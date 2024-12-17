USE revision;

SELECT * FROM ipl;

SELECT batter, SUM(batsman_run) AS "sum_run"
FROM ipl
GROUP BY batter
ORDER BY sum_run DESC
LIMIT 5;

SELECT batter, SUM(batsman_run)
FROM ipl
WHERE batter = 'MS Dhoni';

SELECT batter,COUNT(*) AS 'num_six' 
FROM ipl
WHERE batsman_run = 6
GROUP BY batter
ORDER BY num_six DESC
LIMIT 1,1;

SELECT * FROM ipl 
WHERE batter = 'V Kohli';

SELECT batter,ID, SUM(batsman_run) AS 'score'
FROM ipl
GROUP BY batter, ID
HAVING score > 100
ORDER BY score DESC;

SELECT batter, SUM(batsman_run) AS 'score',COUNT(batsman_run),
ROUND((SUM(batsman_run)/COUNT(batsman_run))*100,2) AS 'strike_rate'
FROM ipl
GROUP BY batter
HAVING COUNT(batsman_run) > 1000
ORDER BY strike_rate DESC
LIMIT 10;


