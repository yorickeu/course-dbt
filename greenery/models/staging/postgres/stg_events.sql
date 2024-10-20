select 
  event_id
, session_id
, user_id
, page_url
, convert_timezone('UTC', created_at) as created_at_utc
, event_type
, order_id
, product_id
from {{ source('postgres', 'events') }}