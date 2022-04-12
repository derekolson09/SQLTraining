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
 
 > Question: Which SQL Sub-language was used for this?
 
Now right click the "localhost" dropdown form the explorer panel and choose the refresh option and then open the databases folder and you should see Bookstore in it.
 
### Creating Tables

You will be creating tables that for the schema from the [Database Schema Diagram](https://drive.google.com/file/d/1A5l0ywoPEn-FteMqX7Z0-BqoqCvVXyUd/view?usp=sharing). I will break down most of the tables creation code here, and you will be challenged to setup a couple of tables yourself (don't look in the Database SLN folder unless you absolutely cannot figure it out yourself.)

The first table we will create will be the base Author table. To do that, create a new query (from the new query button) and execute the following code:

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
REFERENCES [Genre] (id) - Which table field from a foreign table will be constraining the Genre field within the book table. Breakdown: REFERENCES (Foreign Table Name) (Foreign Table Field Name)

> Challenge: Can you come up with a way to create the two missing relations from the schema diagram?
> <details>
    <summary> Hint </summary>
      Books_Languages Table
      Language Table

      If you cannot figure it out, you can go to the database_sln/Setup folder and look at the add_language_tables.sql file
  </details>

