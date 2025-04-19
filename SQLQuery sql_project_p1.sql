-----create a sql database 
create database sql_project_p1;

-----create table 
if object_id (' [sql_project_p1].[dbo].[retail sales]','u') is not null 
drop table   [sql_project_p1].[dbo].[retail sales]

create table [sql_project_p1].[dbo].[retail sales]
(transactions_id int primary key ,	
sale_date date ,
sale_time time ,
customer_id	 int ,
gender nvarchar(20),
age	int ,
category nvarchar(50),
quantiy	 int  ,
price_per_unit float ,
cogs	float ,
total_sale float );

----to check the tables data 
 select * from [sql_project_p1].[dbo].[retail sales]

---you can also check the nulls in different ways
---1
 select * 
from [sql_project_p1].[dbo].[retail sales]
where transactions_id is null   

---2  this is for columns 
select * 
from  [sql_project_p1].[dbo].[retail sales]
where
	transactions_id is null 
	or 
	sale_date is null
	or 
	sale_time  is null
	or 
	customer_id is null 
	or 
	gender is null
	or
	age is null 
	or 
	category is null
	or 
	quantiy is null
	or
	price_per_unit  is null 
	or 
	cogs is null 
	or 
	total_sale is null

---3
select *,
case 
	when quantiy is null then 1
	else 0
end as quantiy_nulls 
from  [sql_project_p1].[dbo].[retail sales]

-----data exploration 
-- we see that how many categories are there 
select 
 distinct category
from [sql_project_p1].[dbo].[retail sales]

------data analysis & solve business problems 
----1) write a sql query to retrieve all columns for sales made on '2022-11-05'


select * from [sql_project_p1].[dbo].[retail sales]

select *
from  [sql_project_p1].[dbo].[retail sales]
where sale_date='2022-11-05'

---2)  write a sql query to retrieve all transactions where the category is 'clothing ' and the quantity sold is more than 3 in the month of nov-2022
select *
from [sql_project_p1].[dbo].[retail sales]
where category ='clothing'
and sale_date ='2022-11-05'
and quantiy >=3


--3) write sql query to calcualte the total sales for each category 

select 
category ,
sum(total_Sale) as total_sales ,
count(*) as total_orders
from [sql_project_p1].[dbo].[retail sales]
group by category 


---4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select 
category ,
round(avg(age),1) as average_age 
from [sql_project_p1].[dbo].[retail sales]
where category ='beauty'
group by category 

---5) Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select *
from [sql_project_p1].[dbo].[retail sales]
where total_sale >1000

--6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select 
category ,
gender,
count(*) as total_transactions 
from [sql_project_p1].[dbo].[retail sales]
group by category ,gender

---7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select * from(
	select 
		year(sale_date) as sales_year  ,
		month(sale_date )  as sales_month,
		avg(total_Sale) as avg_sales ,
		rank() over(partition by year(sale_date) order by avg(total_Sale) desc) as rank_flag 
	from [sql_project_p1].[dbo].[retail sales]
	group by
		year(sale_date) as sales_year  ,
		month(sale_date ) as  sales_month,
	order by
		year(sale_date) as sales_year  ,
		month(sale_date )as  sales_month 
		)t 
		where rank_flag =1

---8) **Write a SQL query to find the top 5 customers based on the highest total sales **:
select top 5
	customer_id ,
	sum(total_sale) as total_Sales  
from [sql_project_p1].[dbo].[retail sales]
group by customer_id 
order by sum(total_sale) desc

--9) Write a SQL query to find the number of unique customers who purchased items from each category.:
select 
category ,
count( distinct customer_id) as unique_customers 
from [sql_project_p1].[dbo].[retail sales]
group by category 

--10) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_sales as
(
	select 
	case 
		when (hour(sales_time) <12 then 'morning'
		when (hour(sale_time) between 12 and 17 then 'afternoon'
		else 'evening'
	end as shifts 
	from [sql_project_p1].[dbo].[retail sales])

select 
shifts,
count((*) as total_orders 
from hourly_sales 
group by shift 

-------end of the project 
