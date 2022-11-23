/*What is the highest sales amount in a day?
Ans: 21328 */
Select day(date), sum(sale_amt)
from sales_fact
group by day(date)
order by sum(sale_amt) desc;

/*What is the total sales of the category ‘Dairy’?
Ans: 53560 */
Select sum(sale_amt)
From sales_fact s
Inner Join category_dim c On s.product_id = c.product_id
where category_desc = "Dairy";

/*Which city has the highest sales?
Ans: Bangalore*/
Select city, sum(sale_amt)
From sales_fact s
Inner Join geography_dim c On s.store_id = c.store_id
Group by city;

/*How many customers spent less than Rs. 3000?
Ans: 21 */
Select count(customer_id)
From (Select customer_id
From sales_fact
Group by customer_id
Having sum(sale_amt) < 3000) as s2;

/*What is the sales of the category ‘Cereals’ in the city Bangalore?
Ans: 12522 */
Select sum(sale_amt)
From sales_fact s
Inner Join category_dim c on s.product_id = c.product_id
Inner Join geography_dim g on s.store_id = g.store_id
Where city = "Bangalore" and category_desc = "Cereals";

/*Which category is the top category in terms of sales for the location Mumbai?
Ans: Dairy */
Select category_desc,sum(sale_amt)
From sales_fact s
Inner Join category_dim c on s.product_id = c.product_id
Inner Join geography_dim g on s.store_id = g.store_id
Where city = "Mumbai"
Group by category_desc
order by sum(sale_amt) desc;

/*What is the highest sales value of category Drinks and Beverages in a single transaction? 
Value should reflect only sales of the mentioned category.
Ans. 3827 */
Select transaction_id,sum(sale_amt)
From sales_fact s
Inner Join category_dim c on s.product_id = c.product_id
Inner Join geography_dim g on s.store_id = g.store_id
Where category_desc = "Drinks & Bevrages"
Group by transaction_id
order by sum(sale_amt) desc;

/*What is the average amount spent per customer in Chennai?
Ans: 3387 */
Select sum(priceusd*quantity)/count(distinct customer_id) as avg_amt_spent
from
`sales_fact` a
inner join
`geography_dim` b
on a.store_id=b.store_id
where city='Chennai';

/*What is the sales amount of the lowest selling product in ‘Cereals’?
Ans: 3654 */
Select s.product_id,sum(sale_amt)
From sales_fact s
Inner Join category_dim c on s.product_id = c.product_id
Inner Join geography_dim g on s.store_id = g.store_id
Where category_desc = "Cereals"
Group by s.product_id
order by sum(sale_amt);

/*What is the average revenue per customer in Maharashtra?
Ans: 3205.86 */
Select sum(priceusd*quantity)/count(distinct customer_id) as avg_amt_spent
from
`sales_fact` a
inner join
`geography_dim` b
on a.store_id=b.store_id
where state='Maharashtra';

/*How many customers in Karnataka spent less than Rs 3000?
Ans: 5 */
Select count(customer_id)
From (
Select s.customer_id
From sales_fact s
Inner Join category_dim c on s.product_id = c.product_id
Inner Join geography_dim g on s.store_id = g.store_id
Where state = "Karnataka"
Group by s.customer_id
Having sum(sale_amt) < 3000) as s2;

/*How many cities have average revenue per customer lesser than Rs 3500?
Ans: 4 */
select Count(city)
From(
Select city
From sales_fact s
Inner Join category_dim c on s.product_id = c.product_id
Inner Join geography_dim g on s.store_id = g.store_id
Group by city
Having sum(priceusd*quantity)/count(distinct customer_id) < 3500 ) as S3;

/*Which product was bought by the most number of customers?
Ans: 10000333 */
Select s.product_id, count(distinct(customer_id))
From sales_fact s
Inner Join category_dim c on s.product_id = c.product_id
Inner Join geography_dim g on s.store_id = g.store_id
Group by s.product_id
Order by count(customer_id) desc;

/*How many products were bought by at least 5 customers in Maharashtra?
Ans: 26 */
Select count(cnt)
From (Select s.product_id, count(distinct(customer_id)) as cnt
From sales_fact s
Inner Join category_dim c on s.product_id = c.product_id
Inner Join geography_dim g on s.store_id = g.store_id
Where state = "Maharashtra"
Group by s.product_id
Having count(distinct(customer_id)) >=5
order by cnt desc) as f2;

/*What is the highest average amount spent per product by a customer?
Ans: 91.28 */
Select customer_id, sum(sale_amt)/sum(quantity) as avg_amt
From sales_fact
Group by customer_id
order by avg_amt desc;