USE OnHold;
GO
CREATE INDEX idx_CustZipCode ON Customers(ZipCode);
GO
CREATE INDEX idx_EmpZipCode ON Employees(ZipCode);
GO
CREATE INDEX idx_JobID ON Employees(JobID);
GO
CREATE INDEX idx_DeptID ON Employees(DeptID);
GO
CREATE INDEX idx_CustomerID ON OnHoldItems(CustomerID);
GO
CREATE INDEX idx_HoldReason ON OnHoldItems(HoldReason);
GO
CREATE INDEX idx_EmployeeID ON OnHoldItems(EmployeeID);
GO
CREATE INDEX idx_DispositionCode ON OnHoldItems(DispositionCode)
