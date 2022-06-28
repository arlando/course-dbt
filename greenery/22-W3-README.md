# Week 3

## What is our overall conversion rate?

0.62456747404844290657

~ 62%

```
{{
  config(
    materialized='table'
  )
}}

with

unique_sessions_with_event_type as (
  select distinct session_id, event_type
  from {{ ref('stg_greenery__events') }}
),

unique_sessions as (
  select distinct session_id
    from unique_sessions_with_event_type
),

unique_sessions_with_purchase as (
  select distinct session_id
  from unique_sessions_with_event_type
  where event_type = 'checkout'
),

conversion_rate as (
  select
    (select count(session_id) from unique_sessions_with_purchase)::numeric /
    (select count(session_id) from unique_sessions)::numeric
    as conversion_rate_pct
)

select * from conversion_rate
```

## What is our conversion rate by product?

| product_id                           | conversion_rate        |
| ------------------------------------ | ---------------------- |
| 05df0866-1a66-41d8-9ed7-e2bbcddd6a3d | 0.01463414634146341463 |
| 35550082-a52d-4301-8f06-05b30f6f3616 | 0.01192411924119241192 |
| 37e0062f-bd15-4c3e-b272-558a86d90598 | 0.01571815718157181572 |
| 4cda01b9-62e2-46c5-830f-b7f262a58fb1 | 0.01138211382113821138 |
| 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3 | 0.01626016260162601626 |
| 579f4cd0-1f45-49d2-af55-9ab2b72c3b35 | 0.01517615176151761518 |
| 58b575f2-2192-4a53-9d21-df9a0c14fc25 | 0.01300813008130081301 |
| 5b50b820-1d0a-4231-9422-75e7f6b0cecf | 0.01517615176151761518 |
| 5ceddd13-cf00-481f-9285-8340ab95d06d | 0.01788617886178861789 |
| 615695d3-8ffd-4850-bcf7-944cf6d3685b | 0.01734417344173441734 |
| 64d39754-03e4-4fa0-b1ea-5f4293315f67 | 0.01517615176151761518 |
| 689fb64e-a4a2-45c5-b9f2-480c2155624d | 0.01951219512195121951 |
| 6f3a3072-a24d-4d11-9cef-25b0b5f8a4af | 0.01138211382113821138 |
| 74aeb414-e3dd-4e8a-beef-0fa45225214d | 0.01897018970189701897 |
| 80eda933-749d-4fc6-91d5-613d29eb126f | 0.01680216802168021680 |
| 843b6553-dc6a-4fc4-bceb-02cd39af0168 | 0.01571815718157181572 |
| a88a23ef-679c-4743-b151-dc7722040d8c | 0.01192411924119241192 |
| b66a7143-c18a-43bb-b5dc-06bb5d1d3160 | 0.01842818428184281843 |
| b86ae24b-6f59-47e8-8adc-b17d88cbd367 | 0.01463414634146341463 |
| bb19d194-e1bd-4358-819e-cd1f1b401c0c | 0.01788617886178861789 |
| be49171b-9f72-4fc9-bf7a-9a52e259836b | 0.01355013550135501355 |
| c17e63f7-0d28-4a95-8248-b01ea354840e | 0.01626016260162601626 |
| c7050c3b-a898-424d-8d98-ab0aaad7bef4 | 0.01842818428184281843 |
| d3e228db-8ca5-42ad-bb0a-2148e876cc59 | 0.01409214092140921409 |
| e18f33a6-b89a-4fbc-82ad-ccba5bb261cc | 0.01517615176151761518 |
| e2e78dfc-f25c-4fec-a002-8e280d61a2f2 | 0.01409214092140921409 |
| e5ee99b6-519f-4218-8b41-62f48f59f700 | 0.01463414634146341463 |
| e706ab70-b396-4d30-a6b2-a1ccf3625b52 | 0.01517615176151761518 |
| e8b6528e-a830-4d03-a027-473b411c7f02 | 0.01571815718157181572 |
| fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80 | 0.02113821138211382114 |

