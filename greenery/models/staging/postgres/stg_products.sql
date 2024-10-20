select 
  product_id
, name as product_name
, price AS product_price
, inventory as product_inventory
from {{ source('postgres', 'products') }}