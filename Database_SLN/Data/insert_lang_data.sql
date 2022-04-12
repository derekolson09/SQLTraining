INSERT INTO Language (Name) 
        VALUES 
            ('Chinese')
            ,('English')
            ,('Spanish')
            ,('Hindi')
            ,('Arabic')
            ,('German')
            ,('French')
            ,('Italian')
;
GO
INSERT INTO BooksLanguages (
        Book
        ,Language
        ,IsPrimaryLanguage
    )
    VALUES
        ((SELECT id FROM Book WHERE Title = 'The Tempest'),(SELECT id FROM Language WHERE Name = 'English'), 1)
        ,((SELECT id FROM Book WHERE Title = 'The Tempest'),(SELECT id FROM Language WHERE Name = 'Spanish'), 0)
        ,((SELECT id FROM Book WHERE Title = 'Harry Potter and the Philosophers Stone'),(SELECT id FROM Language WHERE Name = 'English'), 1)
;
GO
