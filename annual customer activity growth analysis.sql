--Monthly Active User
with cust_count_each_month as(
select 
	date_part ('month',od.order_purchase_timestamp) as purchase_month, 
	date_part ('year',od.order_purchase_timestamp) as purchase_year,
	count (distinct cd.customer_unique_id) as count_customer
from orders_dataset as od
join customers_dataset as cd
	on od.customer_id = cd.customer_id
group by date_part ('month',order_purchase_timestamp), date_part ('year',order_purchase_timestamp)
order by purchase_year
	)
select 
	purchase_year, 
	round(avg(count_customer),2) as average_monthly_active_user
from cust_count_each_month
group by purchase_year
order by purchase_year 
;


--Count New Customer per Year
with first_purchase as(
select
	cd.customer_unique_id,
	min(od.order_purchase_timestamp) as firsttime_purchase
from orders_dataset as od
join customers_dataset as cd
on cd.customer_id = od.customer_id
group by cd.customer_unique_id
	)
select
	date_part('year',firsttime_purchase) as purchase_year,
	count(customer_unique_id) as new_customer
from first_purchase
group by purchase_year
order by purchase_year
;


--Repeating customer per year
with repeat_customer_per_year as(
select
	date_part('year', od.order_purchase_timestamp) as purchase_year,
	cd.customer_unique_id,
	count(cd.customer_unique_id) as purchase_frequency
from orders_dataset od
join customers_dataset cd 
	on cd.customer_id = od.customer_id
group by purchase_year,cd.customer_unique_id
having count(date_part('year', od.order_purchase_timestamp)) > 1
)
select
	purchase_year,
	count(purchase_frequency) as total_repeating_customer
from repeat_customer_per_year
group by purchase_year
order by purchase_year
;

-- Average Customer Order per Year
with avg_order_per_year as(
select
	date_part('year', od.order_purchase_timestamp) as purchase_year,
	cd.customer_unique_id,
	count(cd.customer_unique_id) as purchase_frequency
from orders_dataset od
join customers_dataset cd 
	on cd.customer_id = od.customer_id
group by purchase_year,cd.customer_unique_id
)
select
	purchase_year,
	round(avg(purchase_frequency),2) as avg_order
from avg_order_per_year
group by purchase_year
order by purchase_year

-- summary
with 
avg_mau as(
with cust_count_each_month as(
		select 
			date_part ('month',od.order_purchase_timestamp) as purchase_month, 
			date_part ('year',od.order_purchase_timestamp) as purchase_year,
			count (distinct cd.customer_unique_id) as count_customer
		from orders_dataset as od
		join customers_dataset as cd
			on od.customer_id = cd.customer_id
		group by date_part ('month',order_purchase_timestamp), date_part ('year',order_purchase_timestamp)
		order by purchase_year
	)
select 
	purchase_year, 
	round(avg(count_customer),2) as average_monthly_active_user
from cust_count_each_month
group by purchase_year
order by purchase_year 
	),
new_cust_year as(
with first_purchase as(
		select
			cd.customer_unique_id,
			min(od.order_purchase_timestamp) as firsttime_purchase
		from orders_dataset as od
		join customers_dataset as cd
		on cd.customer_id = od.customer_id
		group by cd.customer_unique_id
	)
select
	date_part('year',firsttime_purchase) as purchase_year,
	count(customer_unique_id) as new_customer
from first_purchase
group by purchase_year
order by purchase_year
	),
repeat_cust as(
	with repeat_customer_per_year as(
		select
			date_part('year', od.order_purchase_timestamp) as purchase_year,
			cd.customer_unique_id,
			count(cd.customer_unique_id) as purchase_frequency
		from orders_dataset od
		join customers_dataset cd 
			on cd.customer_id = od.customer_id
		group by purchase_year,cd.customer_unique_id
		having count(date_part('year', od.order_purchase_timestamp)) > 1
	)
select
	purchase_year,
	count(purchase_frequency) as total_repeating_customer
from repeat_customer_per_year
group by purchase_year
order by purchase_year
	),
avg_order_cust as(
with avg_order_per_year as(
		select
			date_part('year', od.order_purchase_timestamp) as purchase_year,
			cd.customer_unique_id,
			count(cd.customer_unique_id) as purchase_frequency
		from orders_dataset od
		join customers_dataset cd 
			on cd.customer_id = od.customer_id
		group by purchase_year,cd.customer_unique_id
	)
select
	purchase_year,
	round(avg(purchase_frequency),2) as avg_order
from avg_order_per_year
group by purchase_year
order by purchase_year
	)
select
	mau.purchase_year,
	mau.average_monthly_active_user,
	new.new_customer,
	repeat.total_repeating_customer,
	avrg.avg_order
from avg_mau as mau
join new_cust_year as new on mau.purchase_year = new.purchase_year
join repeat_cust as repeat on mau.purchase_year = repeat.purchase_year
join avg_order_cust as avrg on mau.purchase_year = avrg.purchase_year
	
	
	