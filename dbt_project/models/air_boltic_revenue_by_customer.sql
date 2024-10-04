{{ 
    config(materialized='table') 
}}

SELECT 
 customer_grp.type AS customer_type,
 SUM(price_in_euro) AS revenue_per_customer
FROM `intricate-abbey-396419.air_boltic.orders` AS orders
LEFT JOIN `intricate-abbey-396419.air_boltic.customers` AS customers
       ON orders.customer_ID = customers.customer_ID
LEFT JOIN `intricate-abbey-396419.air_boltic.customer_groups` AS customer_grp
       ON customer_grp.ID = customers.customer_group_ID
WHERE customer_grp.type IS NOT NULL
GROUP BY customer_type

 