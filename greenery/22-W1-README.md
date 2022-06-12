# Week 1 Questions and Answers

### How many users do we have?

130 users

```
select count(*) from users
```

### On average, how many orders do we receive per hour?

~ 15

```
select (sum(num_orders)/count(num_orders)) from (select 
date_part('hour', created_at) as order_time,
count(distinct order_id) as num_orders
from dbt_arlando_b.stg_orders
group by order_time
order by 1) as order_per_hour;
```

### On average, how long does an order take from being placed to being delivered?

~ 3 days 21:24:11.803279

```
select (sum(delivery_duration)/count (distinct order_id)) as avg_delivery_duration 
from
    (select (delivered_at - created_at) as delivery_duration, order_id
    from dbt_arlando_b.stg_orders
    where delivered_at is not null) as delivery_durations;
```

### How many users have only made one purchase? Two purchases? Three+ purchases?

25 users have only made one purchase

28 users have made two purchases

71 users have made three+ purchases

```
select
  count(distinct user_id) filter (where total_orders = 1) as one_purchase,
  count(distinct user_id) filter (where total_orders = 2) as two_purchases,
  count(distinct user_id) filter (where total_orders > 2) as threeplus_purchases
  from
(select count(distinct order_id) as total_orders, user_id from
dbt_arlando_b.stg_orders
group by user_id) as orders_users;
```

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

### On average, how many unique sessions do we have per hour?

39

```
select count(session_id)/count(distinct session_hour) as avg_sess from
  (select distinct 
  date_part('hour', created_at) as session_hour, 
  session_id from events
  order by session_hour) as sessions;
  ``
