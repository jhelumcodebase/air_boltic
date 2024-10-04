{{
    config(materialized='table')
}}
WITH raw_data AS (
    SELECT *
    FROM UNNEST(
        JSON_EXTRACT_ARRAY(
            '''
            [
                {
                    "manufacturer": "Boeing",
                    "model": "737-800",
                    "max_seats": 189,
                    "max_weight": 79015,
                    "max_distance": 2935,
                    "engine_type": "CFM56-7B"
                },
                {
                    "manufacturer": "Airbus",
                    "model": "A320neo",
                    "max_seats": 194,
                    "max_weight": 79000,
                    "max_distance": 3700,
                    "engine_type": "CFM LEAP-1A"
                }
                // Add all your JSON entries here
            ]
            ''',
            '$'
        )
    ) AS aircraft
)
SELECT
    JSON_EXTRACT_SCALAR(aircraft, '$.manufacturer') AS manufacturer,
    JSON_EXTRACT_SCALAR(aircraft, '$.model') AS model,
    CAST(JSON_EXTRACT_SCALAR(aircraft, '$.max_seats') AS INT64) AS max_seats,
    CAST(JSON_EXTRACT_SCALAR(aircraft, '$.max_weight') AS FLOAT64) AS max_weight,
    CAST(JSON_EXTRACT_SCALAR(aircraft, '$.max_distance') AS FLOAT64) AS max_distance,
    JSON_EXTRACT_SCALAR(aircraft, '$.engine_type') AS engine_type
FROM raw_data
