/*
TEST CODE
EXEC IdsReport.BookSummary_Pull 
	''
	,'Tolkein'
	,''
	,''
*/
CREATE PROCEDURE Report.BookSummary_Pull
	@title NVARCHAR(250)
	,@author VARCHAR(300)
	,@genre NVARCHAR(100)
	,@publisher NVARCHAR(250)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
	   [Title]
      ,[PublicationDate]
      ,[ISBN]
      ,[Genre]
      ,CONCAT([FirstName],' ',[LastName]) AS 'Author'
      ,[Publisher]
	FROM [Bookstore].[dbo].[BooksSummary]
	
	WHERE
		(@title='' OR [Title] LIKE '%' + @title + '%')
		AND
		((@author='' OR [FirstName] LIKE '%' + @author + '%') OR (@author='' OR [LastName] LIKE '%' + @author + '%'))
		AND 
		(@genre='' OR [Genre] LIKE '%' + @genre + '%')
		AND 
		(@publisher='' OR [Publisher] LIKE '%' + @publisher + '%')

	ORDER BY
		[Title]
END
