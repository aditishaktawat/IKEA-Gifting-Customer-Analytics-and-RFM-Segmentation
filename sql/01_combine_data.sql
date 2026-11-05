
-- Purpose: Combine the two yearly tables into one and standardise data types
-- Input:   dbo.[Year_2009-2010], dbo.[Year_2010-2011]  (imported from the Online Retail II dataset)
-- Output:  dbo.RetailCombined


-- Check Row Counts after Import

SELECT COUNT(*) AS Rows_2009_2010
FROM dbo.[Year_2009-2010];

SELECT COUNT(*) AS Rows_2010_2011
FROM dbo.[Year_2010-2011];


-- COMBINE BOTH YEARS AND CONVERT TYPES SAFELY

SELECT 
	Invoice,StockCode, Description, Quantity,
	COALESCE(
		TRY_CONVERT(datetime2, InvoiceDate, 120),
		TRY_CONVERT(datetime2, InvoiceDate, 105)
		) AS InvoiceDate,

	TRY_CONVERT(decimal(10,2), Price) AS Price,
	Customer_ID,Country, '2009-2010' AS SourceSheet
INTO dbo.RetailCombined
FROM dbo.[Year_2009-2010]

UNION ALL 

SELECT 
	Invoice,StockCode, Description, Quantity,
	COALESCE(
		TRY_CONVERT(datetime2, InvoiceDate, 120),
		TRY_CONVERT(datetime2, InvoiceDate, 105)
		) AS InvoiceDate,

	TRY_CONVERT(decimal(10,2), Price) AS Price,
	Customer_ID,Country, '2010-2011' AS SourceSheet

FROM dbo.[Year_2010-2011];



--- Confirm the conversion worked cleanly
SELECT COUNT(*)  AS total_rows FROM dbo.RetailCombined;

SELECT COUNT(*) as failed_dates
FROM dbo.RetailCombined 
WHERE InvoiceDate IS NULL;

SELECT COUNT(*) as failed_price
FROM dbo.RetailCombined
WHERE Price IS NULL;