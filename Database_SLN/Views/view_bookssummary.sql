CREATE VIEW BooksSummary AS 
	SELECT  
		b.Title
		,b.PublicationDate
		,b.ISBN
		,g.Name AS 'Genre'
		,a.FirstName
		,a.MiddleName
		,a.LastName
		,p.Name AS 'Publisher'
	FROM 
	Book b 
		INNER JOIN Genre g
			ON b.genre = g.id
		INNER JOIN BooksAuthors ba
			ON ba.book = b.id
		LEFT JOIN Author a
			ON ba.Author = a.id
		INNER JOIN BookPublishers bp
			ON bp.book = b.id
		LEFT JOIN Publisher p
			ON bp.publisher = p.id
