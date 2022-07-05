{{
  config(
    materialized='table'
  )
}}

with

pct_page_views AS (
    select sum(page_view_event) / sum(page_view_event) as pct_page_views
    from {{ ref('int_product_funnel') }}
),
    
pct_add_to_cart as (
    (select sum(add_to_cart_event)::numeric / sum(page_view_event)::numeric as pct_add_to_cart
    from {{ ref('int_product_funnel') }})
),


pct_checkout as (
    select sum(checkout_event)::numeric / 
        (select sum(add_to_cart_event))::numeric as pct_checkout
    from {{ ref('int_product_funnel') }}
    )



SELECT 
    (select * from pct_page_views),
    (select * from pct_add_to_cart),
     * from pct_checkout
