{% snapshot orders_status_snapshot %}

  {{
    config(
      target_schema='snapshot_orders_status',
      unique_key='order_id',

      strategy='check',
      check_cols=['status']
    )
  }}

  SELECT * FROM {{ ref('stg_greenery__orders') }}

{% endsnapshot %}
