USE revision;

CREATE TABLE IF NOT EXISTS repossessions(
id INT,
client_id INT,
driver_id INT,
status VARCHAR(255),
date_repossession DATE
);


INSERT INTO repossessions (id, client_id, driver_id, status, date_repossession) 
VALUES 
(1, 1001, 1, 'Completed', '2023-01-15'),
(2, 1002, 2, 'Pending', '2023-02-20'),
(3, 1003, 3, 'In Progress', '2023-03-10'),
(4, 1004, 4, 'Cancelled', '2023-04-05'),
(5, 1005, 5, 'Completed', '2023-05-25'),
(6, 1006, 6, 'Pending', '2023-06-15'),
(7, 1007, 1, 'In Progress', '2023-07-10'),
(8, 1008, 2, 'Completed', '2023-08-18'),
(9, 1009, 3, 'Pending', '2023-09-12'),
(10, 1010, 4, 'In Progress', '2023-10-05'),
(11, 1011, 5, 'Cancelled', '2023-11-20'),
(12, 1012, 6, 'Completed', '2023-12-25'),
(13, 1013, 1, 'Pending', '2024-01-15'),
(14, 1014, 2, 'In Progress', '2024-02-10'),
(15, 1015, 3, 'Cancelled', '2024-03-05'),
(16, 1016, 4, 'Completed', '2024-04-20'),
(17, 1017, 5, 'Pending', '2024-05-18'),
(18, 1018, 6, 'In Progress', '2024-06-22'),
(19, 1019, 1, 'Completed', '2024-07-14'),
(20, 1020, 2, 'Cancelled', '2024-08-09'),
(21, 1021, 3, 'Pending', '2024-09-03'),
(22, 1022, 4, 'In Progress', '2024-10-11'),
(23, 1023, 5, 'Completed', '2024-11-06'),
(24, 1024, 6, 'Pending', '2024-12-01'),
(25, 1025, 1, 'In Progress', '2023-01-22'),
(26, 1026, 2, 'Completed', '2023-02-14'),
(27, 1027, 3, 'Pending', '2023-03-08'),
(28, 1028, 4, 'In Progress', '2023-04-18'),
(29, 1029, 5, 'Cancelled', '2023-05-10'),
(30, 1030, 6, 'Completed', '2023-06-02'),
(31, 1031, 1, 'Pending', '2023-07-15'),
(32, 1032, 2, 'In Progress', '2023-08-08'),
(33, 1033, 3, 'Cancelled', '2023-09-20'),
(34, 1034, 4, 'Completed', '2023-10-15'),
(35, 1035, 5, 'Pending', '2023-11-10'),
(36, 1036, 6, 'In Progress', '2023-12-05'),
(37, 1037, 1, 'Completed', '2024-01-29'),
(38, 1038, 2, 'Pending', '2024-02-22'),
(39, 1039, 3, 'In Progress', '2024-03-14'),
(40, 1040, 4, 'Cancelled', '2024-04-08'),
(41, 1041, 5, 'Completed', '2024-05-03'),
(42, 1042, 6, 'Pending', '2024-06-17'),
(43, 1043, 1, 'In Progress', '2024-07-11'),
(44, 1044, 2, 'Cancelled', '2024-08-07'),
(45, 1045, 3, 'Completed', '2024-09-04'),
(46, 1046, 4, 'Pending', '2024-10-23'),
(47, 1047, 5, 'In Progress', '2024-11-17'),
(48, 1048, 6, 'Completed', '2024-12-09'),
(49, 1049, 1, 'Cancelled', '2024-01-30'),
(50, 1050, 2, 'Pending', '2024-02-25');

-- TRUNCATE TABLE repossessions;


SELECT * FROM repossessions;

SELECT driver_id,COUNT(status)
FROM repossessions
WHERE YEAR(date_repossession) = 2024 AND status = 'Completed'
GROUP BY driver_id,status;

SELECT driver_id,COUNT(*) AS 'Completed_count'
FROM repossessions
WHERE YEAR(date_repossession) = 2024 AND status = 'Completed'
GROUP BY driver_id,status;