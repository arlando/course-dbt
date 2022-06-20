# Week 2 Questions and Answers

## What is our user repeat rate?

0.79838709677419354839

```
SELECT (repeat_purchases::numeric / unique_purchasers::numeric ) AS user_repeat_orders 
FROM (
    SELECT count(distinct user_id) AS unique_purchasers,
    count(distinct user_id) FILTER (WHERE num_purchases >= 2) AS repeat_purchases
    FROM dbt_arlando_b.int_user_orders
    ) AS user_repeat_orders
```

## What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Good indicators

- Repeat website visits
- Funnel i.e. are they visiting from an email, facebook ad

Indicators for one off purchases

- How many items are in the order
- Did they use a promo code
- Did they visit in the last 30 days?

More data

- Did they make an account to purchase
- User engagement with brand
- User net worth
- User funnel i.e. snapchat or twitter, how did they get to our website
- Did the user abandon their cart

## Within each marts folder, create intermediate models and dimension/fact models.

`core`
- `int_user_orders` - Map of orders joined with users, addresses, and promos. We requery the address using the address id of the order, as the address related to the user could change.
- `int_user_addresses` - In the current schema a user can only have one active address, so I've joined the address table w/ the user table. From this folks can segment user by geographical dimensions (city, state, zipcode). This may be useful to marketing team to send out targeted promotions to subsets of our customers based on these geographical dimensions. Product may be interested in this to see how users are using our app from which geographical regions.
- `dim_products` - Historical product information
- `dim_users` - Users w/o address information. 
- `fact_events` - Fact table showing website events
- `fact_orders` - Fact table showing order events

`marketing`
- `fact_user_orders` - This model contains order with address, promo, and user information. I imagine marketing may want to see how many times a particular promo code was used, or be able to do targeted marketing based on order history.
- `int_user_order_counts` - This model groups together orders by unique user id. This could be used to target repeat customers.
- `int_orders_order_items` - This model joins orders and order items. It could be used by marketing to figure out popular products and then be used to recommend these products to other users.

`product`
- `int_users_events` - This intermediate table joins users to the events table
- `fact_page_views` - This gives a historical count of the page views (this might be more useful broken down into days)
- `fact_users_acquisition` - This gives the number of new users who signed up in the last hour, it could help to make sure that our customer base is growing at a healthy rate.
- `fact_users_events` - Mapping of events to users

# Part 2 - Tests

## Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

I would run the `dbt test` periodically during business hours using a continuous integration tool. I would store test results somewhere so that we have an idea of the history of a test. If the test failed I would alert the stakeholders about bad data via Slack, email, or PagerDuty.

If the bad data has already existed and will require adjustments I would have to have a deeper and longer conversation with the stakeholders about what assumptions were made and why they are now invalid. 