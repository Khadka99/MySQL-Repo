USE Revision;

Create table If Not Exists Person (id int, email varchar(255));
Truncate table Person;
insert into Person (id, email) values ('1', 'a@b.com');
insert into Person (id, email) values ('2', 'c@d.com');
insert into Person (id, email) values ('3', 'a@b.com');

-- Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.
-- Return the result table in any order.

SELECT email 
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

-- delete the duplicate
-- By using WHERE CONDITION it keeps the first occurance of id,,ie it keeps id = 1 and deletes id = 3.
DELETE p1
FROM Person p1
JOIN Person p2
ON p1.email = p2.email
WHERE p1.id > p2.id;

-- We can also USE MIN(id) to get the same result.
Create table If Not Exists Person (id int, email varchar(255));
Truncate table Person;
insert into Person (id, email) values ('1', 'a@b.com');
insert into Person (id, email) values ('2', 'c@d.com');
insert into Person (id, email) values ('3', 'a@b.com');

-- Here the inner query returns the minimum of id 1 and 2,by filtering them we can get the duplicate emails.
DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
); 

WITH tmp_Person AS(
				SELECT MIN(id) AS id
				FROM Person
				GROUP BY email)

DELETE FROM Person
WHERE id NOT IN (SELECT id FROM tmp_Person);
/*  Both the above Query Might return Error-1093.**The error 1093: You can't specify target table 'Person' for 
update in FROM clause occurs because MySQL does not allow you to modify the table you're selecting 
from in the same query. This happens when you try to use a subquery that selects from the same 
table you're trying to delete from.
**To resolve this issue, we can use a JOIN or a TEMPORARY TABLE to avoid referencing the same table in both 
the SELECT and DELETE clauses.** */
-- Therefor we use Temporory tables to delete Duplicates...........
CREATE TEMPORARY TABLE tmp_Person AS
SELECT MIN(id) AS id
FROM Person
GROUP BY email;

DELETE FROM Person
WHERE id NOT IN (SELECT id FROM tmp_Person);

DROP TEMPORARY TABLE tmp_Person;

SELECT * FROM Person;

