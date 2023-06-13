copy customers_dataset(customer_id,"customer_unique_id","customer_zip_code_prefix","customer_city","customer_state")
from 'C:\Users\Asus\Documents\Rakamin\JGP\WEEK 1\Dataset\customers_dataset.csv'
delimiter ','
CSV HEADER;

copy geolocation_dataset(geolocation_zip_code_prefix,"geolocation_lat","geolocation_lng","geolocation_city","geolocation_state")
from 'C:\Users\Asus\Documents\Rakamin\JGP\WEEK 1\Dataset\geolocation_dataset.csv'
delimiter ','
CSV HEADER;

copy order_items_dataset(order_id,"order_item_id","product_id","seller_id","shipping_limit_date","price","freight_value")
from 'C:\Users\Asus\Documents\Rakamin\JGP\WEEK 1\Dataset\order_items_dataset.csv'
delimiter ','
CSV HEADER;

copy order_payments_dataset(order_id,"payment_sequential","payment_type","payment_installments","payment_value")
from 'C:\Users\Asus\Documents\Rakamin\JGP\WEEK 1\Dataset\order_payments_dataset.csv'
delimiter ','
CSV HEADER;

copy order_reviews_dataset(review_id,"order_id","review_score","review_comment_title","review_comment_message","review_creation_date","review_answer_timestamp")
from 'C:\Users\Asus\Documents\Rakamin\JGP\WEEK 1\Dataset\order_reviews_dataset.csv'
delimiter ','
CSV HEADER;

copy orders_dataset(order_id,"customer_id","order_status","order_purchase_timestamp","order_approved_at","order_delivered_carrier_date","order_delivered_customer_date","order_estimated_delivery_date")
from 'C:\Users\Asus\Documents\Rakamin\JGP\WEEK 1\Dataset\orders_dataset.csv'
delimiter ','
CSV HEADER;

copy product_dataset(index_num,product_id,product_category_name,product_name_lenght,product_description_lenght,product_photos_qty,product_weight_g,product_length_cm,product_height_cm,product_width_cm)
from 'C:\Users\Asus\Documents\Rakamin\JGP\WEEK 1\Dataset\product_dataset.csv'
delimiter ','
CSV HEADER;

copy seller_dataset(seller_id,"seller_zip_code_prefix","seller_city","seller_state")
from 'C:\Users\Asus\Documents\Rakamin\JGP\WEEK 1\Dataset\sellers_dataset.csv'
delimiter ','
CSV HEADER;