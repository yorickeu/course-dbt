# Week 2

## Part 1: Models

### 1. What is our user repeat rate?
Repeat Rate = Users who purchased 2 or more times / users who purchased

#### Answer
The user repeat order rate is 79.84 %

#### Query
I've created an intermediate model and mart to answer this question.
```sql
select
  round(order_repeat_user_perc * 100, 2) as repeat_rate
from
  dev_db.dbt_yorickschekermansgreenpeaceorg.fact_user_repeat_rate;
```

### 2. What are good indicators of a user who will likely purchase again?
What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

#### Answer
User likely to buy again could have many indicators:
- They are already repeat customers with multiple orders.
- The source of their vistit is direct to the website. If they came via an advertisement or price comparison website (i.e. Google Shopping) then we know their brand retention is lower and they are more likely to be price shoppers.
- Demographics: male/female, homeowner/renter, income bracket, payment method, location (welthy/poor neighborhood), external bought buying behavior, etc.


### 3. Create a marts folder, so we can organize our models. Within each marts folder, create intermediate models and dimension/fact models.
With the following subfolders for business units:
- Product -- required
- Core -- optional
- Marketing -- optional 

#### Answer
See Github: https://github.com/yorickeu/course-dbt/tree/main/greenery/models
I am not sure if I placed the intermediate folder correctly or whether each mart should have its own intermediate folder?


### 4. Explain the product mart models you added. Why did you organize the models in the way you did?

#### Answer
I mainly wanted to answer the questions for this week. So I created these marts:
- fact_page_views
- fact_products_ordered
- fact_user_repeat_rate

For the last mart I needed to do more processing, so I decided to split this into a intermediate model:
- int_user_repeat_orders

I could probably add many more intermediate tables, and them dimension and marts. Do you have any suggestions?


### 5. Use the dbt docs to visualize your model DAGs to ensure the model layers make sense

#### Answer
![DAG image](<images/week2_dag_image.png>)


## Part 2: Tests

### 1. What assumptions are you making about each model?

#### Answer
See the tests here:
https://github.com/yorickeu/course-dbt/blob/main/greenery/models/staging/postgres/_postgres__models.yml

I mainly test for ID values to be not null and unique. And then for quantities and prices to be not null and positive. There is probablt much more I could test for. I a would be interested in relational tests when you can test for mutual ID's being present in 2 tables. But I do not know how to do that yet.


### 2. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

#### Answer
No I did not find any "bad" data with the simple tests I used... I think the data is very clean compared to what I am used to in a corporate environment.


### 3. Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

#### Answer
I would set-up many more data tests in DBT, and run them daily. On a warning or failure I would automatically send a Slack or email message to alert the Analytics team first, and possibly the stakeholder directly if they were consuming the data directly.


## Part 3: dbt Snapshots

### 1. Which products had their inventory change from week 1 to week 2? 

#### Answer
![Inventory changed image](<images/week2_changed_inventory.png >)

```sql
with inventory_week1 AS (
  select
    product_id
  , name
  , inventory
  from dev_db.dbt_yorickschekermansgreenpeaceorg.inventory_snapshot
  where date(dbt_valid_to) >= '2024-10-20'
)

, inventory_week2 AS (
  select
    product_id
  , name
  , inventory
  from dev_db.dbt_yorickschekermansgreenpeaceorg.inventory_snapshot
  where date(dbt_valid_from) >= '2024-10-20'
)

select
  w1.name
, w1.inventory AS w1_inventory
, w2.inventory AS w2_inventory
, w2.inventory - w1.inventory as changed_inventory
from
  inventory_week1 as w1
left join inventory_week2 as w2
  on w1.product_id = w2.product_id;
```