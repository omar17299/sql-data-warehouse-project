
/* this file contains some data quality queries 
   to check for bad data like null values, duplicated values, invalid date column,
   white spaces,.... so on */



-- Checking for Null and duplicated values in primary key
-- excpectaion: no duplications or null values
-- SILVER.CRM_CUST_INFO TABLE--------
SELECT 
	cst_id, 
	COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- checking unwanted spaces
-- expectation: no result
SELECT 
	cst_key
FROM silver.crm_cust_info
WHERE cst_key <> TRIM(cst_key);

-- Data standarization & consistency 
SELECT 
	DISTINCT cst_gndr
FROM silver.crm_cust_info
----
SELECT 
	DISTINCT cst_marital_status
FROM silver.crm_cust_info
---------------------------------------------
------------------------------------------------
--silver.crm_prd_info--------

SELECT 
	prd_id, 
	COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;
----------------------------------------

SELECT 
	prd_nm
FROM silver.crm_prd_info
WHERE prd_nm <> TRIM(prd_nm);
------------------------------------
-- checking for cost if it had nulls or negative costs

SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0
---------------------------------------------

SELECT 
	DISTINCT prd_line
FROM silver.crm_prd_info

------------------------------------
--Check for invalid date order

SELECT 
	*
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt
----------------------------------------------------
------------------------------------------
---------- crm_sales_details ---------
--Check for invaled date

SELECT 
	NULLIF(sls_order_dt,0) sls_order_dt
FROM bronze.crm_sales_details
WHERE LEN(sls_order_dt) <> 8
	OR sls_order_dt > 20501010
	OR sls_order_dt < 19001010
----------------------------------------------
--- find duplicates in primary key
SELECT 
	sls_ord_num, 
	COUNT(*)
FROM bronze.crm_sales_details
GROUP BY sls_ord_num
HAVING COUNT(*) > 1 OR sls_ord_num IS NULL;
----------------------------------------
-- trailling white spaces
SELECT 
	sls_prd_key
FROM silver.crm_sales_details
WHERE sls_prd_key <> TRIM(sls_prd_key);
------------------------------------


WITH cleaned AS (
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY sls_ord_num ORDER BY sls_order_dt) AS rownumber
FROM bronze.crm_sales_details
)
SELECT * FROM cleaned
ORDER BY rownumber DESC
----------------------------------------------------------------
---- checking for bad data in sales columns
SELECT 
	sls_sales,
	sls_price,
	sls_quantity
FROM silver.crm_sales_details
WHERE sls_sales <> sls_price * sls_quantity
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price
-------------------------------------------------------------

-- erp_cust_az12---------
---- Checking for invalid date
SELECT birth_date
FROM bronze.erp_cust_az12
WHERE birth_date > GETDATE() OR birth_date < '1925-01-01'

SELECT DISTINCT gender
FROM bronze.erp_cust_az12
------------------------------------------------------------------

---    bronze.erp_loc_a101----

SELECT DISTINCT

	country,
	CASE
		WHEN TRIM(country) = 'DE' THEN 'Germany'
		WHEN TRIM(country) IN ('US', 'USA') THEN 'United States'
		WHEN TRIM(country) = '' OR country IS NULL THEN 'n/a'
	ELSE TRIM(country)
	END AS country

FROM bronze.erp_loc_a101

