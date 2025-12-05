{{ config(materialized="table") }}

-- Selecting the data from stg_311 table
WITH base AS (
    SELECT * FROM {{ ref('stg_311') }}
),

-- Feature engineerings
features AS (
    SELECT
        *,
        ROUND(DATEDIFF('hour', created_ts, closed_ts), 2) AS case_duration_hours,
        CASE WHEN DAYOFWEEK(created_ts) IN (1,7) THEN 'Weekend' ELSE 'Weekday' END AS is_weekend,
        EXTRACT(hour FROM created_ts) AS hour_of_day,
        CASE 
            WHEN DATEDIFF('hour', created_ts, closed_ts) <= 2 THEN 'Fast'
            WHEN DATEDIFF('hour', created_ts, closed_ts) <= 12 THEN 'Medium'
            ELSE 'Slow'
        END AS response_speed_category
    FROM base
)

SELECT * FROM features
