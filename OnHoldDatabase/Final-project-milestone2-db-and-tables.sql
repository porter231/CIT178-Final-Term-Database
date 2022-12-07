CREATE DATABASE OnHold;

GO
USE OnHold;
CREATE TABLE ZipCodes (
	ZipCode varchar(10) NOT NULL,
	City varchar(30) NOT NULL,
	State varchar(2) NOT NULL,
	PRIMARY KEY (Zipcode)
);

GO
CREATE TABLE Departments (
	DeptID int NOT NULL,
	DeptName varchar(30) NOT NULL,
	PRIMARY KEY (DeptID)
);

GO
CREATE TABLE Jobs (
	JobID int NOT NULL,
	JobDescription varchar(50) NOT NULL,
	PRIMARY KEY (JobID)
);

GO
CREATE TABLE HoldReasons (
	HoldCode int NOT NULL,
	HoldDescription varchar(100) NOT NULL,
	PRIMARY KEY (HoldCode)
);

GO
CREATE TABLE Dispositions (
	DispositionCode int NOT NULL,
	Description varchar(100) NOT NULL,
	PRIMARY KEY (DispositionCode)
);

GO
CREATE TABLE Customers (
	CustID int NOT NULL,
	CompanyName varchar(200) NOT NULL,
	ContactFN varchar(20),
	ContactLN varchar(30),
	Address varchar(100),
	ZipCode varchar(10) NOT NULL,
	Phone varchar(15),
	PRIMARY KEY (CustID)
);

GO
CREATE TABLE Employees (
	EmployeeID int NOT NULL,
	FirstName varchar(20) NOT NULL,
	LastName varchar(30) NOT NULL,
	Email varchar(30),
	Address varchar(100),
	ZipCode varchar(10) NOT NULL,
	Phone varchar(15),
	JobID int NOT NULL,
	DeptID int NOT NULL,
	PRIMARY KEY (EmployeeID)
);

GO
CREATE TABLE OnHoldItems (
	HoldID int NOT NULL,
	DateOnHold date NOT NULL,
	CustomerID int NOT NULL,
	HoldReason int NOT NULL,
	EmployeeID int NOT NULL,
	DateOffHold date,
	DispositionCode int,
	PRIMARY KEY (HoldID)
);

GO
