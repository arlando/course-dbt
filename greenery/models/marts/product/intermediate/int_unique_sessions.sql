
  {{
  config(
    materialized='table'
  )
}}

select distinct session_id, event_type
from {{ ref('stg_greenery__events') }}
