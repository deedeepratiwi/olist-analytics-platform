{{ config(materialized='table') }}

WITH order_items AS (
    SELECT *
    FROM {{ ref('fct_order_items') }}
),

products AS (
    SELECT *
    FROM {{ ref('dim_products') }}
),

aggregated AS (
    SELECT
        product_id,

        COUNT(*) AS total_units_sold,                     -- better than COUNT(order_id)
        COUNT(DISTINCT order_id) AS total_orders,         -- real order count

        SUM(price) AS total_revenue,
        AVG(price) AS avg_price,

        SUM(freight_value) AS total_freight

    FROM order_items
    GROUP BY product_id
)

SELECT
    a.product_id,

    -- dimension attributes
    p.product_category_name,
    p.product_category_name_english,

    -- metrics
    a.total_units_sold,
    a.total_orders,
    a.total_revenue,
    a.avg_price,
    a.total_freight

FROM aggregated a

LEFT JOIN products p
    ON a.product_id = p.product_id