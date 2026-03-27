WITH orders AS (
    SELECT * FROM {{ ref('fct_orders') }}
),

customer_orders AS (
    SELECT
        customer_id,
        order_id,
        order_purchase_timestamp,
        order_value
    FROM orders
),

aggregated AS (
    SELECT
        customer_id,

        COUNT(order_id) AS total_orders,
        SUM(order_value) AS total_spent,
        AVG(order_value) AS avg_order_value,

        MIN(order_purchase_timestamp) AS first_purchase_date,
        MAX(order_purchase_timestamp) AS last_purchase_date

    FROM customer_orders
    GROUP BY customer_id
)

SELECT
    customer_id,

    total_orders,
    total_spent,
    avg_order_value,

    first_purchase_date,
    last_purchase_date,

    DATE_DIFF(CURRENT_DATE(), DATE(last_purchase_date), DAY) AS days_since_last_order,

    CASE 
        WHEN total_orders > 1 THEN TRUE
        ELSE FALSE
    END AS is_repeat_customer

FROM aggregated