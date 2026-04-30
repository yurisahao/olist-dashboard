{{ config(materialized='view') }}

SELECT
    AVG(
        DATE_DIFF(('day',
            o.order_purchase_timestamp,
            o.order_delivered_customer_date
        )
    ) AS avg_delivery_time_days
FROM {{ ref('olist_orders_dataset') }} o
WHERE o.order_status = 'delivered'