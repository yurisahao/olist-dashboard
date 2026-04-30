{{ config(materialized='view') }}

SELECT
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    COUNT(DISTINCT oi.order_item_id) AS total_items,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(SUM(oi.freight_value), 2) AS freight_revenue,
    ROUND(MAX(op.total_payment_value), 2) AS payment_value,
    MAX(op.max_installments) AS max_installments,
    STRING_AGG(DISTINCT op.payment_types, ', ') AS payment_types,
    STRING_AGG(DISTINCT p.product_category_name, ', ') AS product_categories
FROM {{ ref('olist_orders_dataset') }} o
LEFT JOIN {{ ref('olist_order_items_dataset') }} oi ON o.order_id = oi.order_id
LEFT JOIN (
    SELECT
        order_id,
        SUM(payment_value) AS total_payment_value,
        MAX(payment_installments) AS max_installments,
        STRING_AGG(DISTINCT payment_type, ', ') AS payment_types
    FROM {{ ref('olist_order_payments_dataset') }}
    GROUP BY order_id
) op
    ON o.order_id = op.order_id
LEFT JOIN {{ ref('olist_products_dataset') }} p ON p.product_id = oi.product_id
WHERE o.order_status = 'delivered'
GROUP BY
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at