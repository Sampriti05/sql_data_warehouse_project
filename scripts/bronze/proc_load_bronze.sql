/*
Stored procedure: Load Bronze layer 
Script purpose: stored procedure loads data into the 'bronze' schema from external csv files.
truncates bronze tables before loadinf data, uses bulk insert command to load data from csv files to bronze tables 

usage example:
EXEC bronze.load_bronze;
*/

--save frequently used SQL code in stored procedures in database 
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
	SET @batch_start_time = GETDATE()
		-- bulk insert 
		PRINT 'LOADING BRONZE LAYER'
		PRINT '--------------------'
		PRINT 'LOADING CRM TABLES'
		PRINT '--------------------'
		SET @start_time = GETDATE()
		PRINT 'Truncating CRM table:bronze.crm_cust_info '
		TRUNCATE TABLE bronze.crm_cust_info --remove contents already existing in the table before inserting (prevents duplicate insertions)
		PRINT 'Inserting CRM table:bronze.crm_cust_info '
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\premi\Downloads\dwh_project\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)

		SET @start_time = GETDATE()
		PRINT 'Truncating CRM table:bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info --remove contents already existing in the table before inserting (prevents duplicate insertions)
		PRINT 'Inserting CRM table:bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\premi\Downloads\dwh_project\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)

		SET @start_time = GETDATE()
		PRINT 'Truncating CRM table:bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details --remove contents already existing in the table before inserting (prevents duplicate insertions)
		PRINT 'Inserting CRM table:bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\premi\Downloads\dwh_project\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)

		PRINT '--------------------'
		PRINT 'LOADING ERP TABLES'
		PRINT '--------------------'
		SET @start_time = GETDATE()
		PRINT 'Truncating ERP table:bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12 --remove contents already existing in the table before inserting (prevents duplicate insertions)
		PRINT 'Inserting ERP table:bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\premi\Downloads\dwh_project\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)

		SET @start_time = GETDATE()
		PRINT 'Truncating ERP table:bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101 --remove contents already existing in the table before inserting (prevents duplicate insertions)
		PRINT 'Inserting ERP table:bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\premi\Downloads\dwh_project\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)

		SET @start_time = GETDATE()
		PRINT 'Truncating ERP table:bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2 --remove contents already existing in the table before inserting (prevents duplicate insertions)
		PRINT 'Inserting ERP table:bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\premi\Downloads\dwh_project\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)
	SET @batch_end_time = GETDATE()
	PRINT '>> Total Load duration: ' + CAST(DATEDIFF(second, @batch_start_time,@batch_end_time) AS NVARCHAR)
	END TRY
	BEGIN CATCH 
		PRINT 'Error in Bronze layer '
		PRINT 'Error message: ' + ERROR_MESSAGE();
		PRINT 'Error number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error state: ' + CAST(ERROR_STATE() AS NVARCHAR);
	END CATCH
END 
