{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id,
    session_id,
    page_url,
    e.created_at,
    event_type,
    order_id,
    product_id,
    u.user_id,
    u.first_name,
    u.address_id
FROM {{ ref('stg_greenery__events') }} e
JOIN {{ ref('stg_greenery__users') }} u
ON e.user_id = u.user_id