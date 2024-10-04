{{ 
    config(materialized='table') 
}}

WITH active_users AS (
    SELECT 
        orders.customer_ID , 
        DATE(start_timestamp) as activity_date
    FROM `intricate-abbey-396419.air_boltic.orders` AS orders
    LEFT JOIN `intricate-abbey-396419.air_boltic.trips` AS trips
           ON orders.trip_ID = trips.trip_ID
)

-- Daily Active Users (DAU)
SELECT 
    activity_date, 
    COUNT(DISTINCT customer_ID) as DAU
FROM active_users
GROUP BY activity_date

