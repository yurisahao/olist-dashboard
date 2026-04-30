{{ config(materialized='view') }}

SELECT
    s.seller_id,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.price) AS total_sales
FROM {{ ref('olist_order_items_dataset') }} oi
JOIN {{ ref('olist_sellers_dataset') }} s ON oi.seller_id = s.seller_id
GROUP BY 1
ORDER BY total_sales DESC
limit 10