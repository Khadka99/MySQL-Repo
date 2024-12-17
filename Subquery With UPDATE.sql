USE zomato;
--  Subquery With UPDATE
UPDATE loyal_customers
SET money = (SELECT user_id,SUM(amount)*0.1
					FROM orders
					GROUP BY user_id);

-- This query is not working need to check whats wrong.....
SELECT user_id,SUM(amount)*0.1
FROM orders
GROUP BY user_id;
-- ------------------------------------------------------------

-- (The issue with the query is that the SET clause in an UPDATE statement expects a single
--  value for each column being updated, but the subquery is returning two columns
--  (user_id and the calculated SUM(amount)*0.1). To fix this, we need to correctly 
-- link the user_id from loyal_customers with the user_id in the subquery and only
--  update the money column.)

UPDATE loyal_customers
SET money = (
    SELECT SUM(amount) * 0.1
    FROM orders
    WHERE orders.user_id = loyal_customers.user_id
)
WHERE user_id IN (
    SELECT user_id
    FROM orders
);

SELECT * FROM loyal_customers;

-- Explanation:
-- Subquery in SET:

	-- 	The subquery calculates SUM(amount) * 0.1 for a specific user_id from the orders table.
	-- 	The WHERE clause ensures the subquery matches the user_id in the loyal_customers table.
	-- 	WHERE Clause in UPDATE:
				-- 	Limits the update to only those rows in loyal_customers where user_id exists in the orders table. 
                -- This avoids unnecessary updates.

