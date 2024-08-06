{{ config(enabled=var('customer360__using_stripe', true)) }}

{{
    fivetran_utils.union_data(
        table_identifier='balance_transaction', 
        database_variable='stripe_database', 
        schema_variable='stripe_schema', 
        default_database=target.database,
        default_schema='stripe',
        default_variable='balance_transaction',
        union_schema_variable='stripe_union_schemas',
        union_database_variable='stripe_union_databases'
    )
}}