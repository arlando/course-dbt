{{
  config(
    materialized='table'
  )
}}

SELECT
    item.product_id,
    item.order_id,
    item.quantity,
    p.name,
    p.price as price_usd,
    p.inventory,
    o.created_at as created_at_utc,
    o.order_total as order_total_usd
FROM {{ ref('stg_greenery__order_items') }} item
JOIN {{ ref('stg_greenery__products') }} p
ON item.product_id = p.product_id
JOIN {{ ref('stg_greenery__orders') }} o
ON item.order_id = o.order_id
