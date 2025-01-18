SELECT DISTINCT(Source) FROM revision.flights
UNION
SELECT DISTINCT(Destination) FROM revision.flights;

SELECT * FROM revision.flights
WHERE Source = 'Banglore'  AND Destination = 'Delhi';

SELECT Airline, COUNT(*) FROM revision.flights
GROUP BY Airline;

SELECT Source,COUNT(*) FROM (SELECT Source FROM revision.flights
							UNION ALL
							SELECT Destination FROM revision.flights) t
GROUP BY t.Source
ORDER BY COUNT(*) DESC;

SELECT Date_of_Journey,COUNT(*) FROM revision.flights
GROUP BY Date_of_Journey;

SELECT dep_time,COUNT(*),Price FROM Revision.flights
GROUP BY dep_time,Price
ORDER BY price DESC;

-- Fetching time
SELECT DISTINCT dep_time FROM Revision.flights
ORDER BY dep_time;

-- Fetching Price
SELECT DISTINCT Price FROM Revision.flights
ORDER BY Price;

SELECT DISTINCT Airline, Total_stops FROM Revision.flights
GROUP BY Airline,Total_stops;