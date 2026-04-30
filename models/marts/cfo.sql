{{ config(materialized='view') }}

SELECT
    date_trunc('month', o.order_purchase_timestamp) AS month,
    SUM(p.payment_value) AS revenue,
    AVG(p.payment_value) AS avg_order_value
FROM {{ ref('olist_orders_dataset') }} o
LEFT JOIN {{ ref('olist_order_payments_dataset') }} p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1