SELECT
    b.[Title]
    ,l.[Name]
FROM
    [Book] b
INNER JOIN BooksLanguages bl
    ON b.[id] = bl.[Book]
INNER JOIN Language l
    ON bl.[Language] = l.[id]
WHERE
 b.[Title] = (
    SELECT
        b.[Title]
    FROM
        [Book] b
    INNER JOIN BooksLanguages bl
        ON b.[id] = bl.[Book]
    INNER JOIN Language l
        ON bl.[Language] = l.[id]
    GROUP BY
        b.[Title]
    HAVING COUNT(b.[Title]) > 1
 )
ORDER BY
    l.[Name]