{{
  config(
    materialized='table'
  )
}}

with

-- Conversion rate by product is defined as the # of unique sessions with a 
-- purchase event of that product / total number of unique sessions that viewed that product

product_views as (
  select distinct session_id, event_type, product_id
    from {{ ref('stg_greenery__events') }}
    where product_id is not null
    and event_type = 'page_view'
),

conversions_per_product as (
  select product_id, 
  count(product_id)/(select count(session_id) from product_views where product_views.product_id = product_id)::numeric as conversion_rate
  from {{ ref('int_events_orders') }}
  where event_type = 'checkout'
  group by product_id
)

select * from conversions_per_product
