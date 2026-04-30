{{ config(materialized='view') }}

SELECT
    COALESCE(t.product_category_name_english, p.product_category_name) AS category,
    COUNT(*) AS total_items_sold,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS revenue
FROM {{ ref('olist_order_items_dataset') }} oi
LEFT JOIN {{ ref('olist_orders_dataset') }} o ON oi.order_id = o.order_id
LEFT JOIN {{ ref('olist_products_dataset') }} p ON oi.product_id = p.product_id
LEFT JOIN {{ ref('product_category_name_translation') }} t ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY revenue DESC
limit 10