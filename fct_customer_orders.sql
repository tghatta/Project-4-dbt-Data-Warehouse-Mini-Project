with orders as (
    select * from {{ ref('stg_ecom_orders') }}
),
users as (
    select * from {{ source('raw_ecom', 'users') }}
)
select
    u.id as customer_id,
    u.email as customer_email,
    count(o.order_id) as lifetime_total_orders,
    coalesce(sum(o.order_revenue), 0) as lifetime_value_usd,
    min(o.order_timestamp) as first_purchase_timestamp
from users u
left join orders o on u.id = o.user_id
group by 1, 2
