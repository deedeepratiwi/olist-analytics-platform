{{ config(materialized='table') }}

WITH orders AS (
    SELECT *
    FROM {{ ref('fct_orders') }}
),

customers AS (
    SELECT *
    FROM {{ ref('dim_customers') }}
),

aggregated AS (
    SELECT
        o.customer_id,

        COUNT(o.order_id) AS total_orders,
        SUM(o.total_revenue) AS lifetime_value,
        AVG(o.total_revenue) AS avg_order_value,

        MIN(o.order_purchase_ts) AS first_purchase_ts,
        MAX(o.order_purchase_ts) AS last_purchase_ts

    FROM orders o
    GROUP BY o.customer_id
)

SELECT
    a.customer_id,

    -- dimension attributes
    c.customer_city,
    c.customer_state,

    -- core metrics
    a.total_orders,
    a.lifetime_value,
    a.avg_order_value,

    -- time metrics
    a.first_purchase_ts,
    a.last_purchase_ts,

    DATE_DIFF(CURRENT_DATE(), DATE(a.last_purchase_ts), DAY) AS days_since_last_order,

    -- segmentation
    CASE 
        WHEN a.total_orders > 1 THEN TRUE
        ELSE FALSE
    END AS is_repeat_customer,

    CASE
        WHEN a.lifetime_value > 500 THEN 'high_value'
        WHEN a.lifetime_value > 200 THEN 'mid_value'
        ELSE 'low_value'
    END AS customer_segment,

    -- simple RFM-style features
    a.total_orders AS frequency,
    a.lifetime_value AS monetary

FROM aggregated a

LEFT JOIN customers c
    ON a.customer_id = c.customer_id