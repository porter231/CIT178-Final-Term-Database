/* Final Project Procedures 

-- Stored Procedure that retrieves and displays data

USE OnHold;
GO
CREATE PROC spEmployeeList
AS 
SELECT DeptName AS Department, JobDescription AS Job, FirstName AS 'First Name', LastName AS 'Last Name', Email, Address + ' ' + City + 
	', ' + State + ', ' + ZipCodes.ZipCode AS 'Employee Address', Phone
FROM Employees LEFT JOIN Departments ON Employees.DeptID = Departments.DeptID
LEFT JOIN ZipCodes ON Employees.ZipCode = Zipcodes.ZipCode
LEFT JOIN Jobs ON Jobs.JobID = Employees.JobID
ORDER BY Department, Job; 

--checking that the procedure works

USE OnHold;
GO
EXEC spEmployeeList;

-- Takes input parameter -- Will pull customer(s) name like input

USE OnHold;
GO
CREATE PROC spGetCustomer
			@custname varchar(200)
AS
BEGIN 
			SELECT * FROM Customers
			WHERE CompanyName LIKE '%' + @custname + '%';
END
GO

--Checking that the sproc works

EXEC spGetCustomer 'Any';

-- Requires one input parameter and outputs four parameters.

USE OnHold;
GO
CREATE PROC spEmployeeContact
			@EmployeeID int,
			@FirstName varchar(20) OUTPUT,
			@LastName varchar(30) OUTPUT,
			@Email varchar(30) OUTPUT,
			@Phone varchar(15) OUTPUT
AS
SELECT @FirstName = FirstName, @LastName = LastName, @Email = Email, @Phone = Phone
FROM Employees
WHERE EmployeeID = @EmployeeID;


--Running the proc

DECLARE @FirstName varchar (20);
DECLARE @LastName varchar(30);
DECLARE @Email varchar(30);
DECLARE @Phone varchar(15);

EXEC spEmployeeContact 103, @FirstName OUTPUT, @LastName OUTPUT, @Email OUTPUT, @Phone OUTPUT;
SELECT @FirstName AS 'First Name', @LastName AS 'Last Name', @Email AS 'Email Address', @Phone AS 'Phone Number';

--Procedure that accepts 1 input parameter and returns a value

USE OnHold;
GO
CREATE PROC spCustomerHoldCount
			@CustID int
AS

DECLARE @ItemCount int;
SELECT @ItemCount = COUNT(HoldID)
FROM OnHoldItems WHERE @CustID = CustomerID;

RETURN @ItemCount;
GO

DECLARE @ItemCount int;
EXEC @ItemCount = spCustomerHoldCount 205;
PRINT 'There are ' + CONVERT(varchar, @ItemCount) + ' on-hold records for that customer.';
GO

 Final Project User Defined Fuctions 
 
--Scalar function that accepts an argument

USE OnHold;
GO 
CREATE FUNCTION fnGetEmployee
	(@LastName varchar(30) = '%')
	RETURNS int
BEGIN
	RETURN (Select EmployeeID
			FROM Employees
			WHERE LastName LIKE @LastName);
END; 
GO
SELECT EmployeeID, FirstName, LastName, Email, Phone
FROM Employees
WHERE EmployeeID = dbo.fnGetEmployee('Oliver%');

--Table Function that accepts an argument

USE OnHold;
GO
CREATE FUNCTION fnHoldListMinDate
			(@DateMin date = '2000-01-01')
			RETURNS table
RETURN
	(SELECT * FROM OnHoldItems
	WHERE DateOnHold >= @DateMin);
GO 
SELECT * FROM dbo.fnHoldListMinDate('2022-09-22');

Final Project Triggers

--Creating transaction table for triggers

USE OnHold;
GO
SELECT * INTO OnHoldArchive
FROM OnHoldItems
WHERE 1=0;

--adding information columns to archive table

ALTER TABLE OnHoldArchive
ADD ChangeDate date;
GO
ALTER TABLE OnHoldArchive
ADD Change varchar(30);

--creating delete trigger

CREATE TRIGGER OnHoldChange_DELETE ON OnHoldItems
AFTER DELETE
AS
BEGIN
	SET NOCOUNT ON;
		DECLARE @HoldID int
		DECLARE @DateOnHold date
		DECLARE @CustomerID int
		DECLARE @HoldReason int
		DECLARE @EmployeeID int
		DECLARE @DateOffHold date
		DECLARE @DispositionCode int
		DECLARE @ChangeDate date
		DECLARE @Change varchar(30)

	SELECT @HoldID = DELETED.HoldID, @DateOnHold = DELETED.DateOnHold, @CustomerID = DELETED.CustomerID,
		@HoldReason = DELETED.HoldReason, @EmployeeID = DELETED.EmployeeID, @DateOffHold = DELETED.DateOffHold,
		@DispositionCode = DELETED.DispositionCode, @ChangeDate = GETDATE(), @Change = 'Deleted'
	FROM DELETED
	INSERT INTO OnHoldArchive VALUES (@HoldID, @DateOnHold, @CustomerID, @HoldReason, @EmployeeID, @DateOffHold,
		@DispositionCode, @ChangeDate, @Change)
END

--Testing Trigger by deleting data and then selecting from archive table

DELETE FROM OnHoldItems WHERE HoldID = 102;
SELECT * FROM OnHoldArchive;

--Creating Insert Trigger

GO
CREATE TRIGGER OnHoldChange_INSERT ON OnHoldItems
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
		DECLARE @HoldID int
		DECLARE @DateOnHold date
		DECLARE @CustomerID int
		DECLARE @HoldReason int
		DECLARE @EmployeeID int
		DECLARE @DateOffHold date
		DECLARE @DispositionCode int
		DECLARE @ChangeDate date
		DECLARE @Change varchar(30)

	SELECT @HoldID = INSERTED.HoldID, @DateOnHold = INSERTED.DateOnHold, @CustomerID = INSERTED.CustomerID,
		@HoldReason = INSERTED.HoldReason, @EmployeeID = INSERTED.EmployeeID, @DateOffHold = INSERTED.DateOffHold,
		@DispositionCode = INSERTED.DispositionCode, @ChangeDate = GETDATE(), @Change = 'Inserted'
	FROM INSERTED
	INSERT INTO OnHoldArchive VALUES (@HoldID, @DateOnHold, @CustomerID, @HoldReason, @EmployeeID, @DateOffHold,
		@DispositionCode, @ChangeDate, @Change)
END

--Testing insert trigger

INSERT INTO OnHoldItems VALUES (102, '2022-09-05', 202, 301, 113, '2022-09-09', 402);
SELECT * FROM OnHoldArchive;

--creating update trigger

GO
CREATE TRIGGER OnHoldChange_UPDATE ON OnHoldItems
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
		DECLARE @HoldID int
		DECLARE @DateOnHold date
		DECLARE @CustomerID int
		DECLARE @HoldReason int
		DECLARE @EmployeeID int
		DECLARE @DateOffHold date
		DECLARE @DispositionCode int
		DECLARE @ChangeDate date
		DECLARE @Change varchar(30)

	SELECT @HoldID = INSERTED.HoldID, @DateOnHold = INSERTED.DateOnHold, @CustomerID = INSERTED.CustomerID,
		@HoldReason = INSERTED.HoldReason, @EmployeeID = INSERTED.EmployeeID, @DateOffHold = INSERTED.DateOffHold,
		@DispositionCode = INSERTED.DispositionCode, @ChangeDate = GETDATE(), @Change = 'Updated'
	FROM INSERTED
	INSERT INTO OnHoldArchive VALUES (@HoldID, @DateOnHold, @CustomerID, @HoldReason, @EmployeeID, @DateOffHold,
		@DispositionCode, @ChangeDate, @Change)
END
GO
--Testing Update Trigger

UPDATE OnHoldItems
SET DispositionCode = 404
WHERE HoldID = 110;
GO
SELECT * FROM OnHoldArchive;
*/
