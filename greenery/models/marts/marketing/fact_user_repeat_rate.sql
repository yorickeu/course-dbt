with user_repeat_orders AS (
  select
    user_id
  , orders_placed
  , user_repeat_type
  from {{ ref('int_user_repeat_orders') }}
)

select
  count(distinct user_id) as total_users
, count_if(user_repeat_type = 'once') as order_once_user
, count_if(user_repeat_type = 'repeat') as order_repeat_user
, DIV0(count_if(user_repeat_type = 'once'), count(distinct user_id)) as order_once_user_perc
, DIV0(count_if(user_repeat_type = 'repeat'), count(distinct user_id)) as order_repeat_user_perc
from user_repeat_orders
