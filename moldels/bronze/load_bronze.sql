/*
==========================================================================
load bronze layer source = 'bronze'
==========================================================================
*/

copy into bronze_products
from @globalflow_json_stage/products.json
file_format = (format_name = json_format)



  copy into bronze_customers
 from @globalflow_json_stage/customers.json
 file_format= (format_name = json_format)


copy into bronze_delivery
from @globalflow_json_stage/delivery.json
file_format = (format_name = json_format)



copy into bronze_order_items
from @globalflow_json_stage/order_items.json
file_format = (format_name = json_format)



copy into bronze_orders
from @globalflow_json_stage/orders.json
file_format= (format_name = json_format)



copy into bronze_shipments
from @globalflow_json_stage/shipments.json
file_format = (format_name = json_format)



copy into bronze_purchase_orders
from @globalflow_json_stage/purchase_orders.json
file_format = (format_name = json_format)



copy into bronze_suppliers
from @globalflow_json_stage/suppliers.json
file_format = (format_name = json_format)



copy into bronze_suppliers_performance
from @globalflow_json_stage/suppliers_performance.json
file_format = (format_name = json_format)



copy into bronze_transportation
from @globalflow_json_stage/transportation.json
file_format = (format_name = json_format)



copy into bronze_warehouse
from @globalflow_json_stage/warehouses.json
file_format = (format_name = json_format)



copy into bronze_inventory
from @globalflow_json_stage/inventory.json.gz
FILE_FORMAT = (TYPE = 'JSON')
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE




copy into bronze_returns
from @globalflow_json_stage/returns.json
file_format = (format_name = json_format)




