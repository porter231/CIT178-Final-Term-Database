/* Earl Porter - Aggregate Queries Project Lab Assignment


USE OnHold;
SELECT ZipCodes.City, COUNT(DISTINCT Employees.EmployeeID) AS 'Employees per City'
FROM Employees JOIN ZipCodes ON ZipCodes.ZipCode = Employees.ZipCode
GROUP BY ZipCodes.City
ORDER BY ZipCodes.City DESC;

USE OnHold;
SELECT Customers.CompanyName AS Customer, MIN(DATEDIFF(day, DateOnHold, DateOffHold)) AS 'Least Days on Hold', 
	MAX(DATEDIFF(day, DateOnHold, DateOffHold)) AS 'Longest Days on Hold', 
	AVG(DATEDIFF(day, DateOnHold, DateOffHold)) AS 'Average Days on Hold'
FROM Customers JOIN OnHoldItems ON Customers.CustID = OnHoldItems.CustomerID
GROUP BY Customers.CompanyName
HAVING AVG(DATEDIFF(day, DateOnHold, DateOffHold)) > 0
ORDER BY Customers.CompanyName;

USE OnHold;
SELECT MIN(CompanyName) AS [First Customer], MAX(CompanyName) AS [Last Customer],
	COUNT(CompanyName) AS [Total Number of Customers]
FROM Customers;

USE OnHold;
SELECT DeptName AS [Department], SUM(DATEDIFF(Day, DateOnHold, DateOffHold)) AS [Total Days of on Hold Items]
FROM OnHoldItems
	JOIN Employees ON OnHoldItems.EmployeeID = Employees.EmployeeID
	JOIN Departments ON Departments.DeptID = Employees.DeptID
GROUP BY DeptName
HAVING SUM(DATEDIFF(Day, DateOnHold, DateOffHold)) > 0;
*/