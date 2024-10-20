with order_items as (
  select
    order_id
  , product_id
  , quantity
  from {{ ref('stg_order_items') }}
)

, order_date as (
  select
    date(created_at_utc) as order_date
  , order_id
  from {{ ref('stg_orders') }}
)

, products as (
  select
    product_id
  , product_name
  from {{ ref('stg_products') }}
)

, products_ordered as (
  select
    o.order_id
  , d.order_date
  , o.product_id
  , p.product_name
  , o.quantity
  from order_items as o
  left join order_date as d
    on o.order_id = d.order_id
  left join products as p
    on o.product_id = p.product_id
)

select
  order_date
, product_id
, product_name
, SUM(quantity) as quantity
from products_ordered
group by
  order_date
, product_id
, product_name