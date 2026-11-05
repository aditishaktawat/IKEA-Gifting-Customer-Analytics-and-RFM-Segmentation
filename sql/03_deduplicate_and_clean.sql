-- Purpose: Remove exact duplicate rows and create the final cleaned table
-- Input:   dbo.RetailCombined
-- Output:  dbo.RetailCleaned

-- DEDUPLICATE AND PRODUCE THE FINAL CLEANED TABLE --
WITH Deduplicate AS (
	SELECT *, 
		ROW_NUMBER() OVER (
			PARTITION BY Invoice, StockCode, Description,
						Quantity, InvoiceDate, Price,
						Customer_ID, Country
			ORDER BY (SELECT NULL)
		) AS RowNum
	FROM dbo.RetailCombined
)
SELECT Invoice, StockCode, Description,
	   Quantity, InvoiceDate, Price,
	   Customer_ID, Country, SourceSheet
INTO dbo.RetailCleaned
FROM Deduplicate
WHERE RowNum = 1;



SELECT * FROM dbo.RetailCleaned;