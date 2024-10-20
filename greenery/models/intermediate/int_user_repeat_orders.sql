with user_orders AS (
  select
    user_id
  , count(distinct order_id) as orders_placed
  from {{ ref('stg_orders') }}
  group by 
    user_id
)

select
  user_id
, orders_placed
, case
    when orders_placed = 1 then 'once'
    when orders_placed >= 2 then 'repeat'
  end as user_repeat_type
from user_orders
