# SQLTraining - Overview

This repository is meant to be a starting point for learning the basics of SQL. Included in it is practice using joins, transact sql, selections, stored procedures, views. It will be rather extensive. This is specific for MSSQL Server. This tutorial is based off using Windows OS, but can be altered to Unix systems accordingly, you will just have to do a bit of googleing.

# Tool Recommendations

* IDE: [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15)
* MSSQL Developer Server: [Developer Edition](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (Should be on left side if you scroll down)

# Resources

* [Database Schema Diagram](https://drive.google.com/file/d/1A5l0ywoPEn-FteMqX7Z0-BqoqCvVXyUd/view?usp=sharing)

# Parts of the MSSQL Sub-language

> Don't get too caught up on definitions, this is here for reference.

* DML: Data Manipulation Language - Do stuff with the data
  * Keyword Examples: INSERT, JOIN, MERGE, ORDER BY
* DDL: Data Definition Langauge - Do stuff with the things that hold the data
  * Keyword Examples: CREATE, DROP, ALTER
* DQL: Data Query Language - Figure out what data is there
  * Keyword Examples: SELECT
* DCL: Data Control Language - Determine who has access to the data
  * Keyword Examples: GRANT, REVOKE, DENY
* TCL: Transactional Control Language - Manage changes made by dml statements
  * Keyword Examples: COMMIT, ROLLBACK

## Getting Started

Once you have downloaded the suggested tools (note that there are other tools available to do this with, I am just using the stuff here for simplicity). You can then connect to the database you have downloaded.

To connect to your running sql server instance from Azure Data Studio:

1. In the top left select the Connections Icon (looks like a server). 
2. Select the add connectiojn button, (should be along the servers folder line)
3. A panel should appear on the left for the connection type select "Microsoft SQL Server"
4. For the server field select localhost
5. Then select the connect button

> Note: You should now see a new folder that popped up in the explorer panel on the left, should read something like "localhost <default> windows authentication"
 
 Once you have that setup we will create our database.
 
 ### Creating the Bookstore Database
 
 This is actually rather simple to do. First, select the server you have created called "localhost" in the explorer panel, and there should be a "new query button" in the center top of the screen (next to new notebook and restore buttons). Select the new query button. You should see that you are connected to the master database in a dropdown menu (a default database instance used by sql server to manage databases).
 
 Write and execute (either press the f5 key or the run button) the following query on the master database
 
 ```sql
 CREATE DATABASE Bookstore
 ```

Voila! You've now executed your first piece of SQL
 
 > **Question:** Which SQL Sub-language was used for this?
 
Now right click the "localhost" dropdown form the explorer panel and choose the refresh option and then open the databases folder and you should see Bookstore in it.
 
### Creating Tables

You will be creating tables that for the schema from the [Database Schema Diagram](https://drive.google.com/file/d/1A5l0ywoPEn-FteMqX7Z0-BqoqCvVXyUd/view?usp=sharing). I will break down most of the tables creation code here, and you will be challenged to setup a couple of tables yourself (don't look in the Database SLN folder unless you absolutely cannot figure it out yourself.)

The first table we will create will be the base Author table. To do that, select the 'Bookstore' database from the dropdown in the top center of azure data studio. It should say master in it, then create a new query (from the new query button) and execute the following code:

```sql
CREATE TABLE Author (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT(NEWID())
    ,FirstName VARCHAR(100) NOT NULL
    ,MiddleName VARCHAR(100) NULL
    ,LastName VARCHAR(100) NOT NULL
    ,DateOfBirth DATETIME2 NULL
    ,DateOfDeath DATETIME2 NULL
    ,BookCount INTEGER NULL
);
```

This code is part of the DDL syntax used to create relations in SQL. First we define what we are creating, in this case a table, then we identify the name of the table, and its schema. The UNIQUEIDENTIFIER Keyword is the datatype of the id field it is a UUID format rather than an INTEGER, and is autopopulated using the DEFAULT Keyword and passing in the output from the NEWID() function. The NEWID() function is a MSSQL Server function that generates a new UUID and returns it. The rest of the lines are defining the other fields, some of which are optional (NULL) and some are not optional (NOT NULL) meaning that when a new record is inserted into the table, the NOT NULL fields cannot be of a NULL value. The PRIMARY KEY syntax denotes that the specific field that it is executed on must be a constrained to unique value.

Next you will create the other base tables by executing a new query with the following sql:

```sql
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
```

There is something new in this section of code that you executed, you have also applied a FOREIGN KEY constraint on a few fields. Let's take the line from the CREATE TABLE Book section: "Genre UNIQUEIDENTIFIER FOREIGN KEY REFERENCES [Genre] (id)" and break it down into what is actually being conducted.

Genre - Denotes the name of the field being created on the Book Table
 
UNIQUEIDENTIFIER - Datatype of the Genre field
 
FOREIGN KEY - Constraint on the field
 
REFERENCES [Genre] (id) - Which table field from a foreign table will be constraining the Genre field within the book table. 

Breakdown: REFERENCES (Foreign Table Name) (Foreign Table Field Name)

> **Challenge:** Can you come up with a way to create the two missing relations from the schema diagram?
<details>
   <summary> Hint </summary>
     
     Books_Languages Table
 
     Language Table

</details>

<details>
  <summary> Solution </summary>

  Look at the Database_SLN/Setup/add_language_tables.sql file for the solution

</details>

### Populating Data

Now that you have built out all the tables in the database, it would be nice to actually have stuff in them. To do this you will use a basic INSERT INTO statement. Again, start witht the Author table. Execute the following sql in a new query:

```sql
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
```

What is happening here is we are defining the table we want to insert multiple rows into. The VALUES statement denotes each row as a comma dilimited list within a parenthesis pair, each row is separated by a comma outside the parenthesis pair.

Go ahead and add some more data by executing:

```sql
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
```

Note that there is something more complex happening in some insertion statements like the one into the BookPublishers table. If you look at the first row we are inserting:

"((SELECT id FROM Book WHERE Title = 'The Tempest'), (SELECT id FROM Publisher WHERE Name = 'Penguin Random House'), 1)"

The first field of BookPublishers Table is the Book field. If you recall, this is a foreign key field, which means you need to populate it with a valid primary key value from the Book table. To do this, you are using a sub-query. The subquery is defined as ( SELECT id FROM Book WHERE Title = 'The Tempest' ) The sub-query is broken into the following:

SELECT - DQL statement for getting some data

id - Field name in the Book table

FROM - DQL statement for determing which schema object to search through

Book - Schema object title

WHERE - DML statement for filtering data results returned from SELECT statement

Title - Field name in the Book table

= - Equivalence check

'The Tempest' - Value to check for equivalence (a string in MSSQL is denoted by single quotations)


The evaluation of this subquery must return a single value to then be used as the foreign key for the BookPublishers Book field. This is repeated for the Publisher foreign key field as well.

 > **Challenge:** You created two tables in the last section (Language and BooksLanguages). Insert the languages Chinese, English, Spanish, Hindi, Arabic, German, French and Italian in to the Language table. Also insert 3 rows into the BooksLanguages tables, mapping the book the book titled 'Harry Potter and the Philosophers Stone' to the language English where it is the primary language, and the book titled 'The Tempest' to the languages English and Spanish where english is the primary language and spanish is the secondary language.

<details>
  <summary> Hint 1 </summary>

  First insert the languages into the languages table, then insert the rows into the BooksLanguages table. 

</details>

<details>
  <summary> Hint 2 </summary>

  For the BooksLanguages table, take a look at how the insertions are done for the BookPublishers table, it should be relatively similar

</details>

<details>
  <summary> Solution </summary>

  Look at the Database_SLN/Data/insert_lang_data.sql file

</details>


### Query the Data - Select

As you work with data it is important to be able to view what data you have and in what contexts you have them. Now that you have populated the data relations in your bookstore table you can start answering questions about your data. To do this you will use a SELECT statement, which simply returns some data from your database for you to view or use in some way. In a basic generic form it will look like this:

#### SELECT

```sql
SELECT 
  column1
  ,column2
FROM
  table
```

#### WHERE

To refine your query results you can use a WHERE clause, the generic form looks like:

```sql
SELECT 
  column1
  ,column2
FROM
  table
WHERE 
  condition
```

A where clause can have the following operators in it:

 > Note: you don't need to memorize this, this is for reference

* = - Equal
* \< - Greater than
* \> - Less than
* \> = - Greater than or equal
* \< = - Less than or equal
* <> - not equal
* BETWEEN - Between a certain range
* LIKE - Search for pattern
* IN - To specify multiple possible values for a column

#### ORDER BY
To sort the results from a query you can use the ORDER BY clause. The generic form looks like:

```sql
SELECT 
  column1
  ,column2
FROM
  table
WHERE 
  condition
ORDER BY
  column1 ASC | DSC
```

The ASC stands for ascending and DSC stands for descending. They are keywords for defining order.


#### INNER JOIN
To join two tables on a primary key only where the primary keys are equivalent, use an INNER JOIN. The generic form looks like:

```sql
SELECT 
  t1.column1
  ,t2.column2
FROM
  table t1
INNER JOIN 
  table t2
ON t1.column1 = t2.column2
WHERE 
  condition
ORDER BY
  column1 ASC | DSC
```

Note that with this query we use table aliases (t1, t2). The table aliases were determined in the from clause and the inner join clause. They are used to differentiate two different table fields that may have the same table name. You do this to make sure that the columns being selected aren't ambiguous. An inner join is like a theta join in relational algebra.

#### LEFT JOIN

Joins two tables on a primary key, but unlike the INNER JOIN it returns all records from the left table (the first table defined in the select statement) and the mathed records from the right table. This returns 0 records from the right table if there are no primary key matches. The generic form looks like:

```sql
SELECT 
  t1.column1
  ,t2.column2
FROM
  table t1
LEFT JOIN 
  table t2
ON t1.column1 = t2.column2
```

#### RIGHT JOIN

A RIGHT JOIN is just like a LEFT JOIN but in the opposite direction. The generic form looks like:

```sql
SELECT 
  t1.column1
  ,t2.column2
FROM
  table t1
LEFT JOIN 
  table t2
ON t1.column1 = t2.column2
```

#### FULL JOIN

A FULL JOIN is the equivalent to a FULL OUTER JOIN where it returns all records where there is a match in the left table and the right table records. You can think of it as returning all possible values. This is a fully materialized result which makes it the longest of the described joins thus far since it is similar to a cross multiplication in relational algebra. The generic form looks like:

```sql
SELECT 
  t1.column1
  ,t2.column2
FROM
  table t1
FULL JOIN 
  table t2
ON t1.column1 = t2.column2
WHERE 
  condition
```

#### UNION

A UNION combines the result sets of two or more SELECT statements. Each SELECT within a UNION must have the same amount of fields in them. The fields must have equivalent data types and they must be in the same order. A generic form will look like:

```sql
SELECT column1 FROM table1
UNION
SELECT column2 FROM table2;
```

#### GROUP BY

A group by statement will group rows of the same value into aggregate rows. It is also used alongside aggregate functions such as COUNT(), MAX() etc. to grtoup the results by one or more columns. A generic form looks like:

```sql
SELECT 
  column1
  ,MAX(column2)
FROM
  table
WHERE 
  condition
GROUP BY
  column1
ORDER BY
  column1 ASC | DSC
```
