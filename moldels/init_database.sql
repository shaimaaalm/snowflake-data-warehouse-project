/*
==================================================
Create Database and Schemas
==================================================
Script Purpose:
    This script creates a new database named 'GLOBALFLOW' after checking if it already exists.
    If the database exists, it is dropped and recreated. Additionally, the script sets up four schemas
    within the database: 'bronze', 'silver', and 'gold'. ,'snapshots'

WARNING:
    Running this script will drop the entire 'GlOBALFLOW' database if it exists.
    All data in the database will be permanently deleted. Proceed with caution
    and ensure you have proper backups before running this script.

*/

USE compute_WH;
GO

-- Drop and recreate the 'globalflow_db' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'globalflow')
BEGIN
    ALTER DATABASE globalflow SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE globalflow;
END;
GO

-- Create the 'globalflow' database
CREATE DATABASE globalflow;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA globalflow_bronze;
GO

CREATE SCHEMA globalflow_silver;
GO

create schema GLOBALFLOW_gold;

GO
create schema GLOBALFLOW_snapshots;

GO
create or replace file format json_format
type = json;

GO
create or replace stage globalflow_json_stage
file_format = json_format;
