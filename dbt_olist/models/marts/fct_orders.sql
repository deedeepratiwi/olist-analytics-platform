{{ config(
    materialized='table',
    partition_by={
        "field": "order_purchase_timestamp",
        "data_type": "timestamp"
    },
    cluster_by=["customer_id"]
) }}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
)

SELECT
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp,

    COUNT(oi.product_id) AS total_items,
    SUM(oi.price) AS total_price,
    SUM(oi.freight_value) AS total_freight,
    SUM(oi.price + oi.freight_value) AS order_value

FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id

GROUP BY
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp
