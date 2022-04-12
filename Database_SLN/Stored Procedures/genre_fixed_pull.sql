CREATE PROCEDURE [Report].[GenreSummary_FixedPull]
AS
BEGIN
	SELECT 
		[RowDefName]
		  ,[Genre]
		  ,[UnitsInStock]
		  ,[BookCount]
	FROM dbo.GenreSummary
    ORDER BY
		RowDefName
    
END
GO
