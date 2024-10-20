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
