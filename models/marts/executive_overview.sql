{{ config(materialized='view') }}

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    ROUND(SUM(p.payment_value), 2) AS total_revenue,
    ROUND(AVG(p.payment_value), 2) AS avg_order_value,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM {{ ref('olist_orders_dataset') }} o
LEFT JOIN {{ ref('olist_order_payments_dataset') }} p ON o.order_id = p.order_id
LEFT JOIN {{ ref('olist_order_reviews_dataset') }} r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'