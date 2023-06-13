
-- Count payment type
select
	payment_type,
	count(order_id) as count
from order_payments_dataset
group by payment_type
order by count desc
;

select 
	o1.order_id,
	o1.payment_type,
	o1.payment_value,
	o2.order_purchase_timestamp
into temp table order_payments_join
from order_payments_dataset as o1
inner join orders_dataset as o2
on o1.order_id = o2.order_id
;

-- Count each payment type per year
select payment_type,
	count(case when date_part('year',order_purchase_timestamp) = '2016' then order_id end) as year_2016,
	count(case when date_part('year',order_purchase_timestamp) = '2017' then order_id end) as year_2017,
	count(case when date_part('year',order_purchase_timestamp) = '2018' then order_id end) as year_2018
from order_payments_join
where payment_type != 'not_defined'
group by payment_type
;

