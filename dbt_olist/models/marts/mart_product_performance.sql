WITH order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),

products AS (
    SELECT * FROM {{ ref('stg_products') }}
),

aggregated AS (
    SELECT
        oi.product_id,

        COUNT(oi.order_id) AS total_orders,
        SUM(oi.price) AS total_revenue,
        AVG(oi.price) AS avg_price

    FROM order_items oi
    GROUP BY oi.product_id
)

SELECT
    a.product_id,

    p.product_category_name,

    a.total_orders,
    a.total_revenue,
    a.avg_price

FROM aggregated a
LEFT JOIN products p
    ON a.product_id = p.product_id