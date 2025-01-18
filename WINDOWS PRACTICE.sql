USE northwind;
-- Q-1: Rank Employee in terms of revenue generation. Show employee id, first name, revenue, and rank?
SELECT *
FROM nw_employees;

SELECT * FROM nw_order_details;

SELECT * FROM nw_orders;

SELECT * FROM nw_products;

SELECT * FROM nw_suppliers;

SELECT T.EmployeeID,T.FirstName,ROUND(SUM(T.revenue),2) AS 'total_revenue',
RANK() OVER(ORDER BY SUM(T.revenue) DESC) AS 'rank'
FROM (SELECT t2.EmployeeID,t2.FirstName,t2.LastName,(t3.UnitPrice*t3.Quantity) AS 'revenue' FROM nw_orders t1
				JOIN nw_employees t2
				ON t1.EmployeeID = t2.EmployeeID
				JOIN nw_order_details t3
				ON t1.OrderID = t3.OrderID
                WHERE t2.Title = 'Sales Representative') T
GROUP BY T.EmployeeID,T.FirstName;

-- Q-2: Show All products cumulative sum of units sold each month.
SELECT T.months,T.ProductName,SUM(T.Quantity) AS 'Total_unit_sold'
FROM(SELECT t2.ProductName,Quantity,MONTHNAME(OrderDate) AS 'months'
			, MONTH(OrderDate) AS 'month_number'
				FROM nw_order_details t1
				INNER JOIN nw_products t2 
				ON t1.ProductID = t2.ProductID
				JOIN nw_orders t3
				ON t1.OrderID = t3.OrderID) T
GROUP BY T.ProductName,T.months,T.month_number
ORDER BY T.month_number,T.ProductName;

-- Q-3: Show Percentage of total revenue by each suppliers?
SELECT T.CompanyName, 
ROUND((T.total_sales/SUM(T.total_sales) OVER()) * 100,2) AS 'percentage_of_total_revenue'
 FROM(SELECT t3.CompanyName, SUM(t1.UnitPrice*t1.Quantity) AS 'total_sales'
 FROM nw_order_details t1
		JOIN nw_products t2
				ON t1.ProductID = t2.ProductID
		JOIN nw_suppliers t3
				ON t2.SupplierID = t3.SupplierID
		GROUP BY t3.CompanyName) T
ORDER BY percentage_of_total_revenue DESC;

-- Q-4: Show Percentage of total orders by each suppliers?
SELECT T.SupplierID,T.CompanyName,
ROUND((T.total_order/SUM(total_order) OVER()) * 100,2) AS 'percentage_order'
 FROM( SELECT t1.SupplierID,t1.CompanyName,SUM(t3.UnitPrice*t3.Quantity) AS 'total_order'
				FROM nw_suppliers t1 
				JOIN nw_products t2
				ON t1.SupplierID = t2.SupplierID
				JOIN nw_order_details t3 
				ON t2.ProductID = t3.ProductID
				JOIN nw_orders t4
				ON t3.OrderID = t4.OrderID
				GROUP BY t1.SupplierID,t1.CompanyName)T
ORDER BY T.SupplierID ASC;
-- Q-5:Show All Products Year Wise report of totalQuantity sold, percentage change from last year.
SELECT T.year,T.ProductName,SUM(T.Quantity) AS 'sales',
LAG(SUM(T.Quantity)) OVER(PARTITION BY T.ProductID ORDER BY SUM(T.Quantity) ASC)

           FROM(
				SELECT t3.ProductID,t3.ProductName,t2.Quantity, year(t1.OrderDate) AS 'year'
				FROM nw_orders t1
				JOIN nw_order_details t2
				ON t1.OrderID = t2.OrderID
				JOIN nw_products t3
				ON t2.ProductID = t3.ProductID
				)T
GROUP BY T.ProductName,T.year,T.ProductID;


SELECT T.year,T.ProductName,SUM(T.Quantity) AS 'sales',
((LAG(SUM(T.Quantity)) OVER(PARTITION BY T.ProductID ORDER BY SUM(T.Quantity) DESC) - SUM(T.Quantity)) / 
LAG(SUM(T.Quantity)) OVER(PARTITION BY T.ProductID ORDER BY SUM(T.Quantity) DESC)) * 100 AS 'growth_percent'

           FROM(
				SELECT t3.ProductID,t3.ProductName,t2.Quantity, year(t1.OrderDate) AS 'year'
				FROM nw_orders t1
				JOIN nw_order_details t2
				ON t1.OrderID = t2.OrderID
				JOIN nw_products t3
				ON t2.ProductID = t3.ProductID
				)T
GROUP BY T.ProductName,T.year,T.ProductID;

