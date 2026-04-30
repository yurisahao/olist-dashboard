{{ config(materialized='view') }}

SELECT
    STRFTIME(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(p.payment_value), 2) AS revenue
FROM {{ ref('olist_orders_dataset') }} o
JOIN {{ ref('olist_order_payments_dataset') }} p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1