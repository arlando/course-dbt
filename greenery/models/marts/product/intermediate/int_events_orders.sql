{{
  config(
    materialized='table'
  )
}}

select distinct e.session_id, e.event_type, e.order_id, oi.product_id
from {{ ref('stg_greenery__events') }} e
join {{ ref('stg_greenery__order_items') }} oi
on oi.order_id = e.order_id