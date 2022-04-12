# SQLTraining - Overview

This repository is meant to be a starting point for learning the basics of SQL. Included in it is practice using joins, transact sql, selections, stored procedures, views. It will be rather extensive. This is specific for MSSQL Server. This tutorial is based off using Windows OS, but can be altered to Unix systems accordingly, you will just have to do a bit of googleing.

# Tool Recommendations

* IDE: (https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15)[Azure Data Studio]
* MSSQL Developer Server: (https://www.microsoft.com/en-us/sql-server/sql-server-downloads)[Developer Edition] (Should be in left panel if you scroll down)

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

