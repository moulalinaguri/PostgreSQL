create table sales (
product_id int
, year int
, total_sales_revenue int
);

insert into sales values (1, 2019, 1000);
insert into sales values (1, 2020, 1200);
insert into sales values (1, 2021, 1100);
insert into sales values (2, 2019, 500);
insert into sales values (2, 2020, 600);
insert into sales values (2, 2021, 900);
insert into sales values (3, 2019, 300);
insert into sales values (3, 2020, 450);
insert into sales values (3, 2021, 400);

select * from sales;

create table products (
products_id int
, product_name varchar(50)
, category varchar(50)
);


insert into products values (1, 'Laptops', 'Electronics');
insert into products values (2, 'Jeans', 'Clothing');
insert into products values (3, 'Chairs', 'Home Appliances');

select * from products;

with cte as (
SELECT product_id
     , year
	 , total_sales_revenue
	 , lag(total_sales_revenue) over (partition by product_id order by year) as prev_year_sales
	 , total_sales_revenue - lag(total_sales_revenue) over (partition by product_id order by year) as difference
FROM sales),
cte2 as (
select product_id, min(difference)
from cte 
group by product_id
having min(difference) > 0)

select s.product_id, p.product_name, p.category
from cte2 s
inner join products p on s.product_id=p.products_id;
