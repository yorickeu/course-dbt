with events as (
  select 
    date(created_at_utc) as date
  , product_id
  , count(distinct session_id) as page_views
  from {{ ref('stg_events') }}
  where
    event_type = 'page_view'
  group by
    date
  , product_id
)

, products as (
  select
    product_id
  , product_name
  from {{ ref('stg_products') }}
)

select
  e.date
, e.product_id
, p.product_name
, e.page_views
from events as e
left join products as p
  on e.product_id = p.product_id