{{ config(materialized='table') }}

WITH dates AS (
    SELECT DISTINCT
        DATE(order_purchase_timestamp) AS date
    FROM {{ ref('stg_orders') }}
)

SELECT
    date,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    EXTRACT(DAY FROM date) AS day,
    EXTRACT(WEEK FROM date) AS week,
    EXTRACT(QUARTER FROM date) AS quarter,
    FORMAT_DATE('%Y-%m', date) AS year_month
FROM dates