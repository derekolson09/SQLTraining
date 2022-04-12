CREATE VIEW [dbo].[GenreSummary]
AS
	SELECT 
		g.[Name] as RowDefName
		,g.[Name] as Genre
		,sum([UnitsInStock]) as UnitsInStock
		,count(*) as BookCount
	FROM [dbo].[Book] b
	INNER JOIN [dbo].[Genre] g
		ON g.id = b.Genre
	group by g.[Name]
GO
