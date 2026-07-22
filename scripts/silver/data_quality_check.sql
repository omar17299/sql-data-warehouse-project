-- SILVER.CRM_CUST_INFO TABLE--------
-- Checking for Null and duplicated values in primary key
-- excpectaion: no duplications or null values
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
