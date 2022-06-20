{{
  config(
    materialized='table'
  )
}}

SELECT 
    o.order_id,
    o.created_at,
    o.order_cost,
    o.shipping_cost,
    o.order_total,
    o.status,
    o.first_name,
    o.last_name,
    o.email,
    o.phone_number,
    o.address,
    o.zipcode,
    o.state,
    o.country,
    o.promo_discount_pct,
    o.promo_status
FROM {{ ref('int_orders') }} o