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
    o.tracking_id,
    o.shipping_service,
    o.estimated_delivery_at,
    o.delivered_at,
    o.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    a.address,
    a.zipcode,
    a.state,
    a.country,
    p.promo_id,
    p.discount as promo_discount_pct,
    p.status as promo_status
FROM {{ ref('stg_greenery__orders') }} o
JOIN {{ ref('stg_greenery__users') }} u
    ON o.user_id = u.user_id
JOIN {{ ref('stg_greenery__addresses') }} a
-- It is possible that a user created a temporary address to ship too, so we cannot rely on the
-- intermediate table.
    ON o.address_id = a.address_id
JOIN {{ ref('stg_greenery__promos') }} p
    ON o.promo_id = p.promo_id