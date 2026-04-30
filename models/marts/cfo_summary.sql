{{ config(materialized='view') }}

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(payment_value), 2) AS total_revenue,
    ROUND(AVG(payment_value), 2) AS avg_order_value,
    ROUND(SUM(product_revenue), 2) AS product_revenue,
    ROUND(SUM(freight_revenue), 2) AS freight_revenue
FROM {{ ref('cfo_view') }}
WHERE order_status = 'delivered'