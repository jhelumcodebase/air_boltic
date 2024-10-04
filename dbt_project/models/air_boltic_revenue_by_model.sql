{{ 
    config(materialized='table') 
}}

WITH revenue AS (
SELECT 
 aeroplane.airplane_model AS aeroplane_model,
 SUM(price_in_euro) AS revenue_per_model
FROM `intricate-abbey-396419.air_boltic.orders` AS orders
LEFT JOIN `intricate-abbey-396419.air_boltic.trips` AS trips
       ON orders.trip_ID = trips.trip_ID
LEFT JOIN `intricate-abbey-396419.air_boltic.aeroplanes` AS aeroplane
       ON trips.trip_ID = aeroplane.airplane_ID
GROUP BY 1
)
SELECT 
  revenue.aeroplane_model,
  aeroplane_model.engine_type,
  aeroplane_model.manufacturer,
  aeroplane_model.max_seats,
  revenue.revenue_per_model
FROm revenue
LEFT JOIN `intricate-abbey-396419.air_boltic.aeroplane_model` AS aeroplane_model
       ON revenue.aeroplane_model = aeroplane_model.model
