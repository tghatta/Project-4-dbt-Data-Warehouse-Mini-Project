with source as (
    select * from {{ source('raw_ecom', 'orders') }}
)
select
    id as order_id,
    user_id,
    cast(order_date as timestamp) as order_timestamp,
    status as order_status,
    round(cast(revenue as numeric), 2) as order_revenue
from source
