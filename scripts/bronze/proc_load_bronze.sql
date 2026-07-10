/*
=============================
Stored procedure : Load bronze layer (from Source to bronze)
=============================================
Script Purpose : 
    This script loads the data from the csv files (source) to bronze schema tables.
    It performs the following actions : 
        - Truncate the tables if they exists (to prevent duplication by mistake)
        - Using BULK INSERT to insert the data to the schema tables 

    Params : 
        NONE -> this stored procedure deos not need any parameters

    Usage Example:
      EXEC bronze.load_bronze;
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    declare @start_date DATE, @end_date DATE, @layer_sdate DATE, @layer_edate DATE 

	BEGIN TRY

		PRINT('Loading bronze layer');
		PRINT('====================================');

		PRINT('-------------------------------')
		PRINT('Loading crm tables')
		PRINT('-------------------------------')

		SET @layer_sdate = GETDATE();
		SET @start_date = GETDATE();

		--deleting all the records from the table to make sure there is no duplication happens if the query runs more than one time
		TRUNCATE TABLE bronze.crm_cust_info;
		-- Loading the values from csv file to database table using BULK insert
		PRINT '>>>Inserting the bronze.crm_cust_info Table'
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\warehouse project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_date = GETDATE();
		PRINT 'Loading Duration = ' + CAST(DATEDIFF(second, @start_date, @end_date)  AS NVARCHAR) + ' seconds';
		PRINT '-------------------';


		SET @start_date = GETDATE();
		PRINT '>>>Inserting the bronze.crm_prd_info Table'
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\warehouse project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_date = GETDATE();
		PRINT 'Loading Duration = ' + CAST(DATEDIFF(second, @start_date, @end_date)  AS NVARCHAR) + ' seconds';
		PRINT '-------------------';


		SET @start_date = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>>>Inserting the bronze.crm_sales_details Table'
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\warehouse project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_date = GETDATE();
		PRINT 'Loading Duration = ' + CAST(DATEDIFF(second, @start_date, @end_date)  AS NVARCHAR) + ' seconds';
		PRINT '-------------------';


		PRINT('-------------------------------');
		PRINT('Loading erp tables');
		PRINT('-------------------------------');


		SET @start_date = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>>>Inserting the bronze.erp_cust_az12 Table'
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\warehouse project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_date = GETDATE();
		PRINT 'Loading Duration = ' + CAST(DATEDIFF(second, @start_date, @end_date)  AS NVARCHAR) + ' seconds';
		PRINT '-------------------';


		SET @start_date = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>>>Inserting the bronze.erp_loc_a101 Table'
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\warehouse project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_date = GETDATE();
		PRINT 'Loading Duration = ' + CAST(DATEDIFF(second, @start_date, @end_date)  AS NVARCHAR) + ' seconds';
		PRINT '-------------------';


		SET @start_date = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>>>Inserting bronze.erp_px_cat_g1v2 Table'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\warehouse project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_date = GETDATE();
		PRINT 'Loading Duration = ' + CAST(DATEDIFF(second, @start_date, @end_date)  AS NVARCHAR) + ' seconds';
		PRINT '-------------------';
		SET @layer_edate = GETDATE();
		PRINT '>>>>>>>The Total Time Taken To Loading The Whole Layer = ' + CAST(DATEDIFF(second, @layer_sdate, @layer_edate) AS NVARCHAR) + ' seconds'

	END TRY
	BEGIN CATCH
	PRINT 'ERROR OCURED'
	PRINT ('ERROR MESSAGE' + ERROR_MESSAGE())
	PRINT ('ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR))
	END CATCH
END
