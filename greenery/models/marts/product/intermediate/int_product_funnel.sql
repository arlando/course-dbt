{{
  config(
    materialized='table'
  )
}}

SELECT 
    session_id,
    (case when event_type = 'page_view' then 1 else 0 end) as page_view_event,
     (case when event_type = 'add_to_cart' then 1 else 0 end)  as add_to_cart_event,
    (case when event_type = 'checkout' then 1 else 0 end)  as checkout_event
FROM {{ ref('stg_greenery__events') }}
GROUP BY session_id, event_type