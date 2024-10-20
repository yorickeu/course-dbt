select 
  order_id
, user_id
, promo_id
, address_id
, convert_timezone('UTC', created_at) as created_at_utc
, order_cost
, shipping_cost
, order_total
, tracking_id
, shipping_service
, convert_timezone('UTC', estimated_delivery_at) as estimated_delivery_at_utc
, convert_timezone('UTC', delivered_at) as delivered_at_utc
, status
from {{ source('postgres', 'orders') }}