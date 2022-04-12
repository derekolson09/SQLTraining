ALTER TABLE Book
    ADD UnitsInStock INT DEFAULT(0)
GO

UPDATE Book
	SET UnitsInStock = 50
WHERE [Title] = 'The Tempest'
GO

UPDATE Book
	SET UnitsInStock = 12
WHERE [Title] = 'The Thirteen Problems'
GO

UPDATE Book
	SET UnitsInStock = 27
WHERE [Title] = 'Harry Potter and the Philosophers Stone'
GO

UPDATE Book
	SET UnitsInStock = 5
WHERE [Title] = 'The Fellowship of the Ring'
GO
