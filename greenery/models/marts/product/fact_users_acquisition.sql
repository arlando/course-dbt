{{
  config(
    materialized='table'
  )
}}

SELECT 
date_trunc('hour', u.created_at) as hour,
count(DISTINCT u.user_id) as acquired_users
FROM {{ ref('int_users_addresses') }} as u
group by date_trunc('hour', u.created_at)