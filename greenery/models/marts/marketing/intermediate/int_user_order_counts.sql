{{
  config(
    materialized='table'
  )
}}

SELECT
    o.user_id,
    count(distinct o.order_id) as num_purchases
FROM {{ ref('int_orders') }} o
GROUP BY o.user_id