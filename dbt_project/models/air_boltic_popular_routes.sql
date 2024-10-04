{{ 
    config(materialized='table') 
}}

WITH popular_routes AS (
SELECT 
origin_city,
destination_city,
MAX(ABS(TIMESTAMP_DIFF(end_timestamp, start_timestamp, HOUR))) AS duration_seconds,
COUNT(*) trip_counts,
FROM `intricate-abbey-396419.air_boltic.orders` AS orders
LEFT JOIN `intricate-abbey-396419.air_boltic.trips` AS trips
       ON orders.trip_ID = trips.trip_ID
GROUP BY 1 , 2
ORDER BY trip_counts DESC
)

SELECT 
origin_city,
destination_city,
trip_counts,
duration_seconds
FROM popular_routes WHERE trip_counts > 3