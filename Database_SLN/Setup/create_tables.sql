/**
* Create the base entity tables
**/
CREATE TABLE Author (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT(NEWID())
    ,FirstName VARCHAR(100) NOT NULL
    ,MiddleName VARCHAR(100) NULL
    ,LastName VARCHAR(100) NOT NULL
    ,DateOfBirth DATETIME2 NULL
    ,DateOfDeath DATETIME2 NULL
    ,BookCount INTEGER NULL
);

CREATE TABLE Genre (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT(NEWID()) 
    ,Name NVARCHAR(100) NOT NULL
    ,Description NVARCHAR(1000) NULL
);

CREATE TABLE Format (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT(NEWID())
    ,Name NVARCHAR(30) NOT NULL
);

CREATE TABLE Address (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT(NEWID())
    ,Address1 NVARCHAR(250) NOT NULL
    ,Address2 NVARCHAR(250) NULL
    ,Country NVARCHAR(250) NOT NULL
    ,Zip INTEGER NOT NULL
    ,StateCode NVARCHAR(2) NULL
);

CREATE TABLE Publisher (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT(NEWID())
    ,Name NVARCHAR(250) NOT NULL
    ,Address UNIQUEIDENTIFIER FOREIGN KEY REFERENCES [Address] (id)
);

CREATE TABLE Book (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT(NEWID())
    ,Title NVARCHAR(250) NOT NULL
    ,Subtitle NVARCHAR(250) NULL
    ,Description NVARCHAR(1000) NULL
    ,PublicationDate DATETIME2 NOT NULL
    ,ISBN NVARCHAR(250) NOT NULL
    ,Genre UNIQUEIDENTIFIER FOREIGN KEY REFERENCES [Genre] (id)
    ,Format UNIQUEIDENTIFIER FOREIGN KEY REFERENCES [Format] (id)
    ,Copyright NVARCHAR(250) NULL
);

/**
* Create the mapping (lookup/reference) tables
**/

CREATE TABLE BooksAuthors (
    Book UNIQUEIDENTIFIER FOREIGN KEY REFERENCES [Book] (id)
    ,Author UNIQUEIDENTIFIER FOREIGN KEY REFERENCES [Author](id)
    ,IsMainAuthor BIT NOT NULL
);

CREATE TABLE BookPublishers (
    Book UNIQUEIDENTIFIER FOREIGN KEY REFERENCES [Book] (id)
    ,Publisher UNIQUEIDENTIFIER FOREIGN KEY REFERENCES [Publisher] (id)
    ,IsMainPublisher BIT NOT NULL
);
