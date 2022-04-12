# SQLTraining - Overview

This repository is meant to be a starting point for learning the basics of SQL. Included in it is practice using joins, transact sql, selections, stored procedures, views. It will be rather extensive. This is specific for MSSQL Server. This tutorial is based off using Windows OS, but can be altered to Unix systems accordingly, you will just have to do a bit of googleing.

# Tool Recommendations

* IDE: [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15)
* MSSQL Developer Server: [Developer Edition](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (Should be on left side if you scroll down)

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
 
 ### Creating a couple of 
