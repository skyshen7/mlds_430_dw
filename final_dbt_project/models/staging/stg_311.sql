{{ config(materialized="view") }}

-- Selecting the data from raw_311 table
WITH source AS (
    SELECT
        CREATED_DATE,
        CLOSED_DATE,
        AGENCY,
        COMPLAINT_TYPE,
        DESCRIPTOR,
        STATUS,
        INCIDENT_ZIP,
        INCIDENT_ADDRESS,
        RESOLUTION_DESCRIPTION,
        LATITUDE,
        LONGITUDE
    FROM {{ source('kangaroo_final', 'raw_311') }}
),

-- Making sure all the data types are correct and no null values.
cleaned AS (
    SELECT
        TO_TIMESTAMP(CREATED_DATE) AS created_ts,
        TO_TIMESTAMP(CLOSED_DATE) AS closed_ts,
        AGENCY,
        COMPLAINT_TYPE,
        DESCRIPTOR,
        STATUS,
        TRY_TO_NUMBER(INCIDENT_ZIP) AS incident_zip,
        INCIDENT_ADDRESS,
        RESOLUTION_DESCRIPTION,
        TRY_TO_DOUBLE(LATITUDE) AS latitude,
        TRY_TO_DOUBLE(LONGITUDE) AS longitude
    FROM source
    WHERE LATITUDE IS NOT NULL
      AND LONGITUDE IS NOT NULL
      AND INCIDENT_ZIP IS NOT NULL
      AND INCIDENT_ADDRESS IS NOT NULL
      AND RESOLUTION_DESCRIPTION IS NOT NULL
      AND CLOSED_DATE IS NOT NULL
)

SELECT * FROM cleaned
