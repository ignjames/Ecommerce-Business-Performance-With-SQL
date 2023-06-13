select a2.order_status, a2.order_purchase_timestamp, a1.price, a1.freight_value, a1.product_id
into temp table revenue_table
from order_items_dataset as a1
join orders_dataset as a2
on a1.order_id = a2.order_id
;

select
	(b1.price + b1.freight_value) as revenue,
	b1.order_status,
	b2.product_category_name,
	b1.order_purchase_timestamp,
	b1.product_id
into temp table product_table
from revenue_table as b1
inner join product_dataset as b2
on b1.product_id = b2.product_id
;

-- revenue per year
create temp table revenue_peryear_table
as select
	date_part('year', order_purchase_timestamp) as year,
	sum(price + freight_value)as revenue
from
		(select
			order_purchase_timestamp,
			order_status,
			price,
		 	freight_value
		from revenue_table
		group by order_purchase_timestamp, order_status, price, freight_value
		having order_status not in ('canceled','unavailable') 
		) as tes
group by year
order by year
;

--canceled order per year
create temp table canceled_order_peryear_table
as select
	date_part('year',order_purchase_timestamp) as year,
	count(order_status) as total_canceled_order_peryear
from revenue_table
group by year, order_status
having order_status = 'canceled'
order by year
;

--highest selling category and revenye
create temp table highest_selling_category_peryear
as select
	year,
	category as highest_selling_category,
	total as category_revenue
from(
select
		date_part('year',order_purchase_timestamp) as year,
		product_category_name as category,
		sum(revenue) as total,
		rank() over(partition by date_part('year',order_purchase_timestamp) order by sum(revenue) desc) as pos
	from product_table
	group by date_part('year',order_purchase_timestamp), category,order_status
	having order_status not in ('canceled','unavailable')
	order by year
) as tes
group by year, category, total, pos
having pos < 2
order by year
;

--most cancelled category
create temp table most_cancelled_category_peryear_table
as select
	year,
	category as most_cancelled_category,
	freq
from
(select
	date_part('year',order_purchase_timestamp) as year,
	product_category_name as category,
	order_status,
	count(product_id) as freq,
	rank() over(partition by date_part('year',order_purchase_timestamp) order by count(product_id) desc) as rnk
from product_table
where order_status = 'canceled'
group by year, category, order_status
 ) as tes
group by year, category, freq, rnk
having rnk<2
order by year
;


--summary table
select
	r.year,
	r.revenue,
	h.highest_selling_category,
	h.category_revenue,
	c.total_canceled_order_peryear,
	m.most_cancelled_category
from
	revenue_peryear_table as r
join canceled_order_peryear_table as c on r.year = c.year
join highest_selling_category_peryear as h on r.year = h.year
join most_cancelled_category_peryear_table as m on r.year = m.year