/** Which authors books are available in paper back*/

SELECT
    a.[FirstName] + ' ' + a.[LastName] AS 'Name'
    ,b.[Title]
    ,p.[Name]
FROM
    [Book] b
INNER JOIN [BookPublishers] bp
    ON b.[id] = bp.Book
INNER JOIN [Publisher] p
    ON bp.[Publisher] = p.[id]
INNER JOIN [BooksAuthors] ba
    ON b.[id] = ba.[Book]
INNER JOIN [Author] a
    ON ba.[Author] = a.[id]
INNER JOIN [Format] f
    ON b.[Format] = f.[id]
WHERE f.Name = 'Paperback'
