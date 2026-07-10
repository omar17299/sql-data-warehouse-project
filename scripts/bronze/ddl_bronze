/*
=====================================
DDL Script : Create Bronze Tables
=====================================
Script Purpose :
    This script for creating 'bronze layer' schema tables, droping the tables if they already exsis.
    running this script will re-define the DDL structure for 'bronze' tables
===================================================================================
*/

/* Creating the required tables with the correct columns 
   to move the data from the csv files into it
*/

IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname VARCHAR(50),
	cst_lastname VARCHAR(50),
	cst_marital_status VARCHAR(50),
	cst_gndr VARCHAR(50),
	cst_create_date DATE
)

IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
	prd_id INT,
	prd_key VARCHAR(50),
	prd_nm VARCHAR(50),
	prd_cost NUMERIC (10,2),
	prd_line VARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE
)


IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num VARCHAR(50),
	sls_prd_key VARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales NUMERIC(10,2),
	sls_quantity INT,
	sls_price NUMERIC(10,2)
);

IF OBJECT_ID ('bronze.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12(
	cid VARCHAR(50),
	birth_date DATE,
	gender VARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101(
	cid INT,
	country VARCHAR(50)
);


IF OBJECT_ID ('bronze.erp_px_catg1v2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_catg1v2;
CREATE TABLE bronze.erp_px_catg1v2(
	id INT,
	category VARCHAR(50),
	sub_category VARCHAR(50),
	maintenance VARCHAR(5)
	)
