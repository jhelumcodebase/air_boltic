{{ 
    config(materialized='table') 
}}
-- We can change dbt configuration to incremental providing partition details in case the size of table increases



SELECT 
 origin_city,
 destination_city,
 SUM(price_in_euro) AS revenue_per_route
FROM `intricate-abbey-396419.air_boltic.orders` AS orders
LEFT JOIN `intricate-abbey-396419.air_boltic.trips` AS trips
       ON orders.trip_ID = trips.trip_ID
GROUP BY 1 , 2

 