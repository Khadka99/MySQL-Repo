USE revision;
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    branch VARCHAR(50) NOT NULL,
    marks DECIMAL(5, 2) NOT NULL
);

INSERT INTO students (name, branch, marks)
VALUES
('John Doe', 'CSE', 91.60),
('Jane Smith', 'ECE', 92.50),
('Alice Johnson', 'CSE', 85.50),
('Bob Williams', 'CSE', 78.25),
('Charlie Brown', 'CSE', 91.60),
('Daisy Miller', 'ECE', 88.75),
('Edward Harris', 'ECE', 82.40),
('Fiona Clark', 'ECE', 95.20),
('George Anderson', 'ECE', 76.80),
('Hannah Lee', 'CSE', 89.90),
('Ian Wright', 'ECE', 84.35),
('Jackie Taylor', 'CSE', 93.70);
-- ------------------------------------------------------------------
-- ------------------------------------------------------------------

SELECT *, AVG(marks) OVER()FROM students;
-- the above syntax returns overall average of marks.

SELECT *, AVG(marks) OVER(PARTITION BY branch)FROM students;
-- In the above syntax returns the average for each branch.

SELECT *,
MIN(marks) OVER() AS 'Overall_Min_marks',
MAX(marks) OVER() AS 'Overall_Max_marks',
AVG(marks) OVER() AS 'Overall_Avg_marks',
MIN(marks) OVER(PARTITION BY branch) AS 'Min_marks',
MAX(marks) OVER(PARTITION BY branch) AS 'Max_marks',
AVG(marks) OVER(PARTITION BY branch) AS 'Avg_marks'
FROM students;

-- Q1. Finda all the students who have marks higher than avg marks of their respective branch?
SELECT * FROM (SELECT *,
AVG(marks) OVER(PARTITION BY branch) AS 'branch_avg' FROM students) t
WHERE t.marks > t.branch_avg;
-- ----------------------------------------------------------------------
-- ----------------------------------------------------------------------
-- **RANK/DENSE_RANK/ROW_NUMBER**

SELECT *,
RANK() OVER(ORDER BY marks DESC) AS 'Overall_rank',
RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS 'branch_rank',
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS 'dense_rank'
FROM students; 
-- The difference between rank and dense_rank is, in rank if there are two same marks then it returns rank 1,1,3 but in dense rank it returns 1,1,2.
SELECT *,
ROW_NUMBER() OVER()
FROM students;
-- Q2. Find top 2 most paying customers of each month?
SELECT * FROM (SELECT MONTHNAME(date) AS 'month',user_id,SUM(amount) AS 'total',
				RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY SUM(amount) DESC) AS 'month_rank'
				FROM orders
				GROUP BY MONTH(date),MONTHNAME(date),user_id
				ORDER BY MONTH(date)) t 
WHERE t.month_rank < 3
ORDER BY montH DESC, month_rank ASC;
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- ## FIRST_VALUE/LAST_VALUE/NTH_VALUE.
/* Q1. Find the branch topper.
   Q2. FRAME Clause.
   Q3. Find the last guy of each branch.
   Q4. Alternate way of writing window functions.
   Q5. Find the 2nd last guy of each branch, 5th topper of each branch?
*/
-- Q1. Find the branch topper(name of a top student).
SELECT name,branch,marks FROM (SELECT *,
			FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_name',
			FIRST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_marks'
			 FROM students) t 
WHERE t.name = t.topper_name AND t.marks = t.topper_marks;
 
 /*
 Frame Boundaries: Row frames are defined using boundaries that determine the range of rows included 
 in the calculation. These boundaries are relative to the current row.

Boundary Options:

UNBOUNDED PRECEDING: Includes all rows from the start of the partition to the current row.
CURRENT ROW: Includes only the current row.
n PRECEDING: Includes n rows before the current row.
n FOLLOWING: Includes n rows after the current row.
UNBOUNDED FOLLOWING: Includes all rows from the current row to the end of the partition.
Default Behavior:

If no explicit frame is defined, MySQL defaults to RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
for aggregate window functions.
 */
 
 SELECT *,
LAST_VALUE(marks) OVER(ORDER BY marks DESC)
 FROM students;
 
  SELECT *,
LAST_VALUE(marks) OVER(ORDER BY marks DESC
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
 FROM students;
 
   SELECT *,
LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
 FROM students;
 
    SELECT *,
NTH_VALUE(marks,2) OVER(PARTITION BY branch ORDER BY marks DESC
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
 FROM students;

-- Q3. Find the last guy of each branch.
SELECT name,branch,marks FROM (SELECT *,
			LAST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'last_name',
			LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'last_marks'
			 FROM students) t 
WHERE t.name = t.last_name AND t.marks = t.last_marks;

                        
SELECT name, branch, marks 
FROM (
    SELECT *,
           LAST_VALUE(name) OVER w AS 'last_name',
           LAST_VALUE(marks) OVER w AS 'last_marks'
    FROM students
    WINDOW w AS (PARTITION BY branch ORDER BY marks DESC
                 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
) t
WHERE t.name = last_name AND t.marks = last_marks;
-- Q3. Create roll no from branch and marks?
SELECT *,
CONCAT(branch,'-',ROW_NUMBER() OVER()) AS 'roll_num'
FROM students;

-- LAG/LEAD
SELECT *,
LAG(marks) OVER(ORDER BY student_id),
LEAD(marks) OVER(ORDER BY student_id)
FROM students;

SELECT *,
LAG(marks) OVER(PARTITION BY branch ORDER BY student_id),
LEAD(marks) OVER(PARTITION BY branch ORDER BY student_id)
FROM students;


 SELECT MONTHNAME(date),SUM(amount),
 (SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY MONTH(date))) /
 (LAG(SUM(amount)) OVER(ORDER BY MONTH(date)))*100
 FROM orders
 GROUP BY MONTHNAME(date),MONTH(date)
ORDER BY MONTH(date) ASC;
















