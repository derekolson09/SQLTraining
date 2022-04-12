/**
* SOURCE: https://en.wikipedia.org/wiki/List_of_best-selling_fiction_authors
**/
INSERT INTO Author (
    FirstName
    ,MiddleName
    ,LastName
    ,DateOfBirth 
    ,DateOfDeath
    ,BookCount
)
VALUES
    ('William', NULL, 'Shakespeare', '1904-01-22', '1904-04-23', 42)
    ,('Agatha', NULL, 'Christie', '1904-05-11', '1976-01-12', 85)
    ,('J.', 'K.', 'Rowling', '1973-10-03', NULL, 15)
    ,('R.', 'L.', 'Stine', '1943-10-08', NULL, 430)
    ,('Corín', NULL, 'Tellado', '1927-04-25', '2009-04-11', 4000)
    ,('J.', 'R. R.', 'Tolkein', '1904-01-03', '1973-09-02', 36)

INSERT INTO Genre (
    Name
    ,Description
)
VALUES 
    ('Plays', NULL)
    ,('Poetry', NULL)
    ,('Whodunits', NULL)
    ,('Fantasy', NULL)
    ,('Crime Fiction', NULL)
    ,('Horror', NULL)
    ,('Comedy', NULL)
    ,('Romance', NULL)

INSERT INTO Format (
    Name
)
VALUES
    ('Hard Cover')
    ,('Paperback')
    ,('Pdf')
    ,('eBook')

INSERT INTO Address (
    Address1
    ,Address2
    ,Country
    ,Zip
    ,StateCode
)
VALUES 
    ('400 Bennett Cerf Drive', NULL, 'United States', 21157, 'MD')
    ,('58 Rue Jean Bleuzen', NULL, 'France', 92170, NULL)
    ,('195 Broadway new York City', NULL, 'United States', 10007, 'NY')
    ,('120 Broadway new York City', NULL, 'United States', 10271, 'NY')
    ,('1230 Avenue of the Americas new York City', NULL, 'United States', 10020, 'NY')

INSERT INTO Publisher (
    Name
    ,Address
)
    VALUES
    ('Penguin Random House', (SELECT id FROM Address WHERE Address1 = '400 Bennett Cerf Drive'))
    ,('Hachette Livre', (SELECT id FROM Address WHERE Address1 = '58 Rue Jean Bleuzen'))
    ,('HarperCollins', (SELECT id FROM Address WHERE Address1 = '195 Broadway new York City'))
    ,('Macmillan Publishers', (SELECT id FROM Address WHERE Address1 = '120 Broadway new York City'))
    ,('Simon & Schuster', (SELECT id FROM Address WHERE Address1 = '1230 Avenue of the Americas new York City'))

INSERT INTO Book (
    Title 
    ,Subtitle 
    ,Description 
    ,PublicationDate 
    ,ISBN
    ,Genre 
    ,Format 
    ,Copyright
)
    VALUES
    ('The Tempest', NULL, NULL, '1904-01-01', '9780174435686', (SELECT id FROM Genre WHERE Name = 'Plays'), (SELECT id FROM Format WHERE Name='Hard Cover'), NULL) -- Shakespeare
    ,('The Thirteen Problems', NULL, NULL, '1932-07-01', '9780006162742', (SELECT id FROM Genre WHERE Name = 'Crime Fiction'), (SELECT id FROM Format WHERE Name='Paperback'), NULL) -- Agatha Christie
    ,('Harry Potter and the Philosophers Stone', NULL, NULL, '1997-06-26', '9780939173341', (SELECT id FROM Genre WHERE Name = 'Fantasy'), (SELECT id FROM Format WHERE Name='Paperback'), NULL) -- JK
    ,('The Fellowship of the Ring', NULL, NULL, '1954-07-29', '9780007171972', (SELECT id FROM Genre WHERE Name = 'Fantasy'), (SELECT id FROM Format WHERE Name='Paperback'), NULL) -- Tolkein

INSERT INTO BooksAuthors (
    Book 
    ,Author 
    ,IsMainAuthor 
)
    VALUES
    ((SELECT id FROM Book WHERE Title = 'The Tempest'), (SELECT id FROM Author WHERE LastName = 'Shakespeare'), 1)
    ,((SELECT id FROM Book WHERE Title = 'The Thirteen Problems'), (SELECT id FROM Author WHERE LastName = 'Christie'), 1)
    ,((SELECT id FROM Book WHERE Title = 'Harry Potter and the Philosophers Stone'), (SELECT id FROM Author WHERE LastName = 'Rowling'), 1)
    ,((SELECT id FROM Book WHERE Title = 'The Fellowship of the Ring'), (SELECT id FROM Author WHERE LastName = 'Tolkein'), 1)
INSERT INTO BookPublishers (
    Book
    ,Publisher
    ,IsMainPublisher
)
    VALUES
    ((SELECT id FROM Book WHERE Title = 'The Tempest'), (SELECT id FROM Publisher WHERE Name = 'Penguin Random House'), 1)
    ,((SELECT id FROM Book WHERE Title = 'The Thirteen Problems'), (SELECT id FROM Publisher WHERE Name = 'Hachette Livre'), 1)
    ,((SELECT id FROM Book WHERE Title = 'Harry Potter and the Philosophers Stone'), (SELECT id FROM Publisher WHERE Name = 'Penguin Random House'), 1)
    ,((SELECT id FROM Book WHERE Title = 'The Fellowship of the Ring'), (SELECT id FROM Publisher WHERE Name = 'HarperCollins'), 1)
