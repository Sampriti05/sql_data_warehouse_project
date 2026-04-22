/*
Create Database and Schemas 

Script Purpose: 
   - to create a new database names 'DataWarehouse' after checkin if it already exists 
   - if already exists it is dropped and a new one is created 
   - script sets up 3 schema : 'Bronze' , 'Silver', 'Gold'

WARNING: Ensure you have proper backups before running this script as it will drop the entire 'DataWarehouse' database if it exists 
*/


USE master;
GO

--drop and recreate the 'DataWarehouse' database 
IF EXISTS (SELECT 1 from sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO

-- create database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO
  
USE DataWarehouse;
GO

-- create schemas 
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
