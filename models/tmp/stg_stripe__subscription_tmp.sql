{{ config(enabled=var('stripe__using_subscriptions', True)) }}

select * from (

{% if var('stripe__using_subscription_history', does_table_exist('subscription_history')) %}

{{
    fivetran_utils.union_data(
        table_identifier='subscription_history', 
        database_variable='stripe_database', 
        schema_variable='stripe_schema', 
        default_database=target.database,
        default_schema='stripe',
        default_variable='subscription_history',
        union_schema_variable='stripe_union_schemas',
        union_database_variable='stripe_union_databases'
    )
}}

{% else %}

{{
    fivetran_utils.union_data(
        table_identifier='subscription', 
        database_variable='stripe_database', 
        schema_variable='stripe_schema', 
        default_database=target.database,
        default_schema='stripe',
        default_variable='subscription',
        union_schema_variable='stripe_union_schemas',
        union_database_variable='stripe_union_databases'
    )
}}

{% endif %}

) as fields

{{ livemode_predicate() }}
{% if var('stripe__using_subscription_history', does_table_exist('subscription_history')) %}
    and coalesce(_fivetran_active, true)
{% endif %}

