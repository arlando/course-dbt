{{
  config(
    materialized='table'
  )
}}

SELECT 
   product_id,
   name,
   price as price_usd,
   inventory
FROM {{ ref('stg_greenery__products') }}