{{
  config(
    materialized='table'
  )
}}

SELECT 
    page_url,
    count(page_url) as num_views
FROM {{ ref('int_users_events') }}
GROUP BY page_url