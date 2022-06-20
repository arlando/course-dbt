{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id,
    session_id,
    page_url,
    created_at,
    event_type,
    order_id,
    product_id,
    user_id,
    first_name,
    address_id
FROM {{ ref('int_users_events') }}
