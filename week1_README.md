# Week 1

## 1. How many users do we have?

### Answer
There are 130 users.

### Query
```sql
select 
  count(distinct user_id) as number_of_users
from users;
```

## 2. On average, how many orders do we receive per hour?

### Answer
On average 7.520833 orders are placed every hour.

### Query
```sql
with orders_per_hour as (
  select
    date_trunc('hour', created_at) as order_hour
  , count(distinct(order_id)) as number_of_orders
  from orders
  group by order_hour
)

select
  avg(number_of_orders) AS avg_orders_per_hour
from orders_per_hour;
```

## 3. On average, how long does an order take from being placed to being delivered?

### Answer
On average an order was delivered in 3.891803 days.

### Query
```sql
with delivery_time AS (
  select
    order_id
  , created_at
  , delivered_at
  , timestampdiff(day, created_at, delivered_at) AS delivery_days
  from orders
  where delivered_at is not null -- We only want completed orders
)

select
  avg(delivery_days) AS avg_delivery_days
from delivery_time;
```

## 4. How many users have only made one purchase? Two purchases? Three+ purchases?

### Answer
- 25 users placed 1 order
- 28 users placed 2 orders
- 71 users placed 3 or more orders

### Query
```sql
with orders_per_user AS (
  select
    user_id
  , count(distinct order_id) AS number_of_orders
  from orders
  group by user_id
)

select
  count(user_id) as users
, case
    when number_of_orders = 1 then '1 order'
    when number_of_orders = 2 then '2 orders'
    when number_of_orders >= 3 then '3 or more orders'
  end as orders_per_user
from orders_per_user
group by orders_per_user
order by orders_per_user;
```    

## 5. On average, how many unique sessions do we have per hour?

### Answer
On average we see 16.327586 unique sessions per hour.

### Query

```sql
with sessions_per_hour as (
  select
    date_trunc('hour', created_at) as session_hour
  , count(distinct(session_id)) as number_of_sessions
  from events
  group by session_hour
)

select
  avg(number_of_sessions) AS avg_sessions_per_hour
from sessions_per_hour;
```