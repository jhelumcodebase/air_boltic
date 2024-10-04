{{ config(materialized='table') }}

WITH active_users AS (
    SELECT 
        orders.customer_ID , 
        DATE(start_timestamp) as activity_date
    FROM `intricate-abbey-396419.air_boltic.orders` AS orders
    LEFT JOIN `intricate-abbey-396419.air_boltic.trips` AS trips
           ON orders.trip_ID = trips.trip_ID
)

-- Weekly Active Users (WAU)
SELECT 
    activity_date, 
    COUNT(DISTINCT customer_ID) as WAU
FROM active_users
WHERE activity_date >= CURRENT_DATE - INTERVAL '7' DAY
GROUP BY activity_date

