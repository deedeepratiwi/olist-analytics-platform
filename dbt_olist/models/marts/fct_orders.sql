{{ config(
    materialized='table',
    partition_by={
        "field": "order_purchase_ts",
        "data_type": "timestamp"
    },
    cluster_by=["customer_id"]
) }}

WITH orders AS (
    SELECT 
        order_id,
        customer_id,
        TIMESTAMP(order_purchase_timestamp) AS order_purchase_ts,
        DATE(order_purchase_timestamp) AS order_date,
        order_status,
        order_delivered_customer_date
    FROM {{ ref('stg_orders') }}
),

order_items AS (
    SELECT 
        order_id,
        price,
        freight_value
    FROM {{ ref('stg_order_items') }}
),

payments AS (
    SELECT 
        order_id,
        payment_value
    FROM {{ ref('stg_order_payments') }}
)

SELECT
    o.order_id,
    o.customer_id,

    -- time
    o.order_purchase_ts,
    o.order_date,

    -- status
    o.order_status,

    -- metrics
    COUNT(oi.order_id) AS total_items,

    SUM(oi.price) AS total_product_value,
    SUM(oi.freight_value) AS total_freight_value,

    -- more accurate revenue source
    SUM(p.payment_value) AS total_revenue,

    -- fallback total (if needed)
    SUM(oi.price + oi.freight_value) AS gross_order_value,

    -- delivery
    DATE_DIFF(
        DATE(o.order_delivered_customer_date),
        o.order_date,
        DAY
    ) AS delivery_days

FROM orders o

LEFT JOIN order_items oi
    ON o.order_id = oi.order_id

LEFT JOIN payments p
    ON o.order_id = p.order_id

GROUP BY
    o.order_id,
    o.customer_id,
    o.order_purchase_ts,
    o.order_date,
    o.order_status,
    o.order_delivered_customer_date