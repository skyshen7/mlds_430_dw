CREATE SCHEMA IF NOT EXISTS MLDS430.KANGAROO_FINAL;

USE DATABASE MLDS430;
USE SCHEMA KANGAROO_FINAL;

CREATE OR REPLACE TABLE MLDS430.KANGAROO_FINAL.RAW_311 (
    created_date STRING,
    closed_date STRING,
    agency STRING,
    complaint_type STRING,
    descriptor STRING,
    status STRING,
    incident_zip STRING,
    incident_address STRING,
    resolution_description STRING,
    latitude STRING,
    longitude STRING
);

SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN created_ts IS NULL THEN 1 ELSE 0 END) AS null_created_ts,
    SUM(CASE WHEN closed_ts IS NULL THEN 1 ELSE 0 END) AS null_closed_ts,
    SUM(CASE WHEN incident_zip IS NULL THEN 1 ELSE 0 END) AS null_incident_zip,
    SUM(CASE WHEN incident_address IS NULL THEN 1 ELSE 0 END) AS null_incident_address,
    SUM(CASE WHEN resolution_description IS NULL THEN 1 ELSE 0 END) AS null_resolution_description,
    SUM(CASE WHEN latitude IS NULL THEN 1 ELSE 0 END) AS null_latitude,
    SUM(CASE WHEN longitude IS NULL THEN 1 ELSE 0 END) AS null_longitude
FROM MLDS430.KANGAROO_FINAL.stg_311;


SELECT *
FROM MLDS430.KANGAROO_FINAL.RAW_311
LIMIT 5;


SELECT *
FROM MLDS430.KANGAROO_FINAL.stg_311
LIMIT 5;



SELECT *
FROM MLDS430.KANGAROO_FINAL.fct_311
LIMIT 5;


