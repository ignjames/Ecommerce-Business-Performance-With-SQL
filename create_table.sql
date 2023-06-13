create table if not exists customers_dataset(
	customer_id varchar,
	"customer_unique_id" varchar,
	"customer_zip_code_prefix" varchar,
	"customer_city" varchar,
	"customer_state" varchar
)
;
create table if not exists geolocation_dataset(
	geolocation_zip_code_prefix varchar,
	"geolocation_lat" varchar,
	"geolocation_lng" varchar,
	"geolocation_city" varchar,
	"geolocation_state" varchar
)
;
create table if not exists order_items_dataset(
	order_id varchar,
	"order_item_id" int,
	"product_id" varchar,
	"seller_id" varchar,
	"shipping_limit_date" timestamp,
	"price" double precision,
	"freight_value" double precision
)
;
create table if not exists order_payments_dataset(
	order_id varchar,
	"payment_sequential" int,
	"payment_type varchar,
	"payment_installments" int,
	"payment_value" double precision
)
;
create table if not exists order_reviews_dataset (
	review_id varchar, 
	"order_id" varchar,
	"review_score" int,
	"review_comment_title" varchar,
	"review_comment_message" varchar,
	"review_creation_date" timestamp,
	"review_answer_timestamp" timestamp
)
;
create table if not exists orders_dataset (
	order_id varchar,
	"customer_id" varchar,
	"order_status" varchar,
	"order_purchase_timestamp" timestamp,
	"order_approved_at" timestamp,
	"order_delivered_carrier_date" timestamp,
	"order_delivered_customer_date" timestamp,
	"order_estimated_delivery_date" timestamp
)
;
create table if not exists product_dataset (
	index_num int,
	product_id varchar,
	product_category_name varchar, 
	product_name_lenght double precision,
	product_description_lenght double precision,
	product_photos_qty double precision,
	product_weight_g double precision,
	product_length_cm double precision,
	product_height_cm double precision,
	product_width_cm double precision
)
;
create table if not exists seller_dataset (
	seller_id varchar,
	"seller_zip_code_prefix" varchar,
	"seller_city" varchar,
	"seller_state" varchar
)