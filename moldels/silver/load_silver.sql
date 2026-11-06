/*
==========================================================================
 script: cleaning silver tables
==========================================================================
script puropse:
Leveraging dbt on top of Snowflake, the Silver transformation pipeline ingests 
raw source data from the Bronze layer, executing necessary cleansing, parsing,
and business logic transformations
==========================================================================
*/


select *
from {{source("globalflow_raw","stg_customers")}}
==========================================================================
select *
from {{source("globalflow_raw","stg_delivery")}}
==========================================================================
select *
from {{source("globalflow_raw","stg_inventory")}}
==========================================================================
with order_items_table as(
select *
from {{source("globalflow_raw","stg_order_items")}})
, missing_table as (
select
*,
{{clean_null('discount', '0')}} as discount1
from order_items_table)

select
order_id,
order_item_id,
product_id,
quantity,
unit_price,
amount,
discount1
from missing_table
==========================================================================
select *
from {{source("globalflow_raw","stg_orders")}}
==========================================================================
with product_table as(
select *
from {{source("globalflow_raw","stg_products")}})
, missing_value as (
select
*,
row_number() over (partition by product_id order by created_at) as rn,
coalesce(brand, 'NA') as brand1,
coalesce(subcategory, 'uncategorized') as SUBCATEGORY1,
coalesce(weight_kg, 50.26) as weight_kg1
from product_table)

select
product_id,
p_name,
brand1,
category,
SUBCATEGORY1,
created_at,
is_active,
rec_level,
selling_price,
unit_cost,
weight_kg1,
rn
from missing_value
==========================================================================

with purchase_order_table as (
select *
from {{source("globalflow_raw",'stg_purchase_orders')}})
, missing_table as (
select
*,
{{clean_null('received_quantity', '0')}} as received_quantity1
from purchase_order_table)

select
PURCHASE_ORDER_ID,
PURCHASE_STATUS,
ORDER_DATE,
ORDERED_QUANTITY,
PROMISED_DATE,
RECEIVED_DATE,
RECEIVED_QUANTITY1,
SUPPLIER_ID,
UNIT_COST,
WAREHOUSE_ID,
PRODUCT_ID
from missing_table
==========================================================================
with return_table as(
select *
from {{source("globalflow_raw","stg_returns")}})
, missing_table as (
select
*,
{{clean_null('refund_amount', '0')}} as refund_amount1
from return_table)

select
RETURN_ID,
ORDER_ITEM_ID,
REFUND_AMOUNT1,
RETURN_DATE,
RETURN_QUANTITY,
RETURN_REASON,
RETURN_STATUS
from missing_table
==========================================================================
select *
from {{source("globalflow_raw","stg_shipments")}}
==========================================================================
with supplier_performance_table as (
select *
from {{source("globalflow_raw","stg_suppliers_performance")}})
, missing_table as (
select
*,
{{coalesce_columns(['delivery_score', 'overall_score', 'quality_score'], '0')}} 
from supplier_performance_table)

select
SUPPLIER_PERFORMANCE_ID,
SUPPLIER_ID,
RECEIVED_QUANTITY,
 column_3 as QUALITY_SCORE1,
PURCHASE_ORDER_ID,
PROMISED_DATE,
 column_2 as OVERALL_SCORE1,
ORDERED_QUANTITY,
EVALUATION_DATE,
 column_2 as DELIVERY_SCORE1,
DEFECTIVE_QUANTITY,
ACTUAL_DATE
from missing_table
==========================================================================
with supplier_table as(
select *
from {{source("globalflow_raw","stg_suppliers")}})
, missing_table as (
select
*,
{{clean_null('payment_terms', "'Not Specified'")}} as payment_term,
{{clean_null('supplier_rating', '2.79')}} as supplier_rating1
from supplier_table)

select
SUPPLIER_ID,
SUPPLIER_NAME,
COUNTRY,
CITY,
SUPPLIER_TYPE,
CREATED_AT,
LEAD_TIME_DAYS,
STATUS,
PAYMENT_TERM,
SUPPLIER_RATING1
from missing_table
==========================================================================
select *
from {{source("globalflow_raw","stg_transportation")}}
==========================================================================
select *
from {{source("globalflow_raw","stg_warehouse")}}


