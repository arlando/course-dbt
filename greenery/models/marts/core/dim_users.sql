{{
  config(
    materialized='table'
  )
}}

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.created_at,
    u.updated_at,
    u.address,
    u.zipcode,
    u.state,
    u.country
FROM {{ ref('int_users_addresses') }} u