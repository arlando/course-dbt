{{
  config(
    materialized='table'
  )
}}

with

-- Conversion rate is defined as the # of unique sessions 
-- with a purchase event / total number of unique sessions

unique_sessions as (
  select distinct session_id
    from {{ ref('int_unique_sessions') }}
),

unique_sessions_with_purchase as (
  select distinct session_id
  from {{ ref('int_unique_sessions') }}
  where event_type = 'checkout'
),

conversion_rate as (
  select
    (select count(session_id) from unique_sessions_with_purchase)::numeric /
    (select count(session_id) from unique_sessions)::numeric
    as conversion_rate_pct
)

select * from conversion_rate
