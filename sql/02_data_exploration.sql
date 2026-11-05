
-- Purpose: Check data quality issues before cleaning
-- Input:   dbo.RetailCombined
-- Output:  None (read-only checks, no tables are changed)

-- DATA EXPLORATION --

-- CHECK 1 - Missing CustomerID
SELECT COUNT(*) as Missing_CustomerID
FROM dbo.RetailCombined
WHERE Customer_ID IS NULL;


-- CHECK 2 - Negative or Zero Quantity
SELECT COUNT(*) as Negative_Qty
FROM dbo.RetailCombined
WHERE Quantity <= 0;


-- CHECK 3 - Missing Description
SELECT COUNT(*) as Missing_description
FROM dbo.RetailCombined
WHERE Description IS NULL;


-- CHECK 4 - Exact Duplicate Rows
SELECT Invoice, StockCode, Description, Quantity, InvoiceDate, Price,
	Customer_ID, Country,
	COUNT(*) as ExactDupeCount
FROM dbo.RetailCombined
GROUP BY Invoice, StockCode, Description, Quantity, InvoiceDate, Price,
	Customer_ID, Country
HAVING COUNT(*) > 1;