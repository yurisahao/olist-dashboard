{{ config(materialized='view') }}

SELECT
    AVG(review_score) AS avg_score,
    COUNT(*) AS total_reviews
FROM {{ ref('olist_order_reviews_dataset') }}