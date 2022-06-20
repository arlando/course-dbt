{{
  config(
    materialized='table'
  )
}}

SELECT 
    o.order_id,
    o.user_id,
    o.promo_id,
    o.created_at,
    o.order_cost,
    o.shipping_cost,
    o.order_total,
    o.tracking_id,
    o.shipping_service,
    o.estimated_delivery_at,
    o.delivered_at,
    o.status
FROM {{ ref('int_orders') }} o