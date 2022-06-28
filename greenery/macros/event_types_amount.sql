{% macro event_types_amount() %}

{% set event_types = dbt_utils.get_column_values(
    table=ref('stg_greenery__events'),
    column='event_type'
) %}

{% set event_types_query %}
SELECT
    {% for event_type in event_types %}
    count(case when event_type = '{{event_type}}' then event_type end) as {{event_type}}_amount,
    {% endfor %}
    count(event_type) as total_event_amount
from {{ ref('stg_greenery__events') }}
order by 1
{% endset %}

{% set results = run_query(event_types_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ log(results_list, info=True) }}

{{ return(results_list) }}

{% endmacro %}