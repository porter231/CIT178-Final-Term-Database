/* Final Project Views 

--View #1 - Limited Updateable

--creating view

USE OnHold;
GO
CREATE VIEW ClosedHoldItems
AS
SELECT HoldID, CompanyName, HoldReasons.HoldDescription AS HoldDescription, DateOffHold, Dispositions.Description AS DispositionDescription, 
	DATEDIFF(DAY, DateOnHold, DateOffHold) AS TotalDaysOnHold
FROM OnHoldItems 
	JOIN Customers ON Customers.CustID = OnholdItems.CustomerID
	JOIN HoldReasons ON OnholdItems.HoldReason = HoldReasons.HoldCode
	JOIN Dispositions ON OnHoldItems.DispositionCode = Dispositions.DispositionCode
WHERE DateOffHold IS NOT NULL
WITH CHECK OPTION;
GO 

--Double checking that the view works and reviewing data

SELECT * FROM ClosedHoldItems; 

View #2 

--Creating View of items still on hold (Updateable)

USE OnHold;
GO
CREATE VIEW OpenHoldItems
AS
SELECT HoldID, DateOnHold, CompanyName, HoldDescription, DeptName, Employees.FirstName + ' ' + Employees.LastName AS EmployeeName,
		DateOffHold, DispositionCode, DATEDIFF(DAY, DateOnHold, GETDATE()) AS CurrentDaysOnHold
FROM OnHoldItems
	JOIN Employees ON OnHoldItems.EmployeeID = Employees.EmployeeID
	JOIN Departments ON Employees.DeptID = Departments.DeptID
	JOIN Customers ON Customers.CustID = OnHoldItems.CustomerID
	JOIN HoldReasons ON OnHoldItems.HoldReason = HoldReasons.HoldCode
WHERE DateOffHold IS NULL;
GO

--checking view after creation

SELECT * FROM OpenHoldItems;

USE OnHold;
GO 
UPDATE OpenHoldItems
SET DateOnHold = '2022-10-03'
WHERE HoldID = 112;
GO 
--Displaying new data

SELECT * FROM OpenHoldItems;

--Second update to take item off hold

USE OnHold;
GO
UPDATE OpenHoldItems
SET DateOffHold = GETDATE(), DispositionCode = 405
WHERE HoldID = 111;
GO

--selecting updated view

SELECT * FROM OpenHoldItems;

View #3 

USE OnHold;
GO
CREATE VIEW CustomerContact
AS
SELECT CompanyName, ContactFN, ContactLN, Phone
FROM Customers;
GO

--Selecting view

SELECT * FROM CustomerContact;

View #4 

--creating view of department leader contacts

USE OnHold;
GO
CREATE VIEW DLContacts
AS
SELECT DeptName, FirstName, LastName, Email, Phone
FROM Employees 
	JOIN Departments ON Employees.DeptID = Departments.DeptID
WHERE JobID = 2;
GO

--Using View to display Data

Select * FROM DLContacts; 

View #5 (because customer contact is almost identical to an example given, so just in case!)

-creating view of out of state customers

USE OnHold;
GO
CREATE VIEW OutofStateCust
AS
SELECT CompanyName, Address, City, State, ZipCodes.ZipCode
FROM Customers
	JOIN ZipCodes ON Customers.ZipCode = ZipCodes.ZipCode
WHERE State <> 'MI';
GO

--using view to select data

SELECT * FROM OutofStateCust; */