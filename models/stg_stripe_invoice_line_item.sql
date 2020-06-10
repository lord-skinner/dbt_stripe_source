{{ config(enabled=var('using_invoices', True)) }}

with invoice_line_item as (

    select *
    from {{ source('stripe', 'invoice_line_item') }}

), fields as (

    select
      id as invoice_line_item_id,
      invoice_id,
      amount,
      currency,
      description,
      discountable as is_discountable,
      plan_id,
      proration,
      quantity,
      subscription_id,
      subscription_item_id,
      type,
      unique_id
    from invoice_line_item
    where id not like 'sub%'

)

select * from fields