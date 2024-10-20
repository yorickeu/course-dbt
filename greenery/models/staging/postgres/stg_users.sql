select 
  user_id
, first_name
, last_name
, email
, phone_number
, convert_timezone('UTC', created_at) as created_at_utc
, convert_timezone('UTC', updated_at) as updated_at_utc
, address_id
from {{ source('postgres', 'users') }}