WITH bobw_helloworld_hw_orders AS (

  {#Retrieves data from the 'BOBW.HELLOWORLD' source table 'HW_ORDERS'.#}
  SELECT * 
  
  FROM {{ source('BOBW.HELLOWORLD', 'HW_ORDERS') }}

),

snowflake_sample_data_tpch_sf10_customer AS (

  {#Retrieves data from the 'SNOWFLAKE_SAMPLE_DATA.TPCH_SF10' source table 'CUSTOMER'.#}
  SELECT * 
  
  FROM {{ source('SNOWFLAKE_SAMPLE_DATA.TPCH_SF10', 'CUSTOMER') }}

),

join_orders_customers AS (

  {#Combines 'bobw_helloworld_hw_orders' with 'snowflake_sample_data_tpch_sf10_customer' based on customer ID.#}
  SELECT 
    bobw_helloworld_hw_orders.ORDER_ID,
    bobw_helloworld_hw_orders.CUSTOMER_ID,
    bobw_helloworld_hw_orders.ORDER_STATUS,
    bobw_helloworld_hw_orders.ORDER_CATEGORY,
    bobw_helloworld_hw_orders.ORDER_DATE,
    bobw_helloworld_hw_orders.AMOUNT,
    snowflake_sample_data_tpch_sf10_customer.C_NAME,
    snowflake_sample_data_tpch_sf10_customer.C_ADDRESS,
    snowflake_sample_data_tpch_sf10_customer.C_PHONE,
    snowflake_sample_data_tpch_sf10_customer.C_ACCTBAL,
    snowflake_sample_data_tpch_sf10_customer.C_MKTSEGMENT,
    snowflake_sample_data_tpch_sf10_customer.C_COMMENT
  
  FROM bobw_helloworld_hw_orders
  INNER JOIN snowflake_sample_data_tpch_sf10_customer
     ON bobw_helloworld_hw_orders.CUSTOMER_ID = snowflake_sample_data_tpch_sf10_customer.C_CUSTKEY

),

join_orders_customers_1 AS (

  {#Selects customer name and amount from 'join_orders_customers'.#}
  SELECT 
    C_NAME,
    AMOUNT
  
  FROM join_orders_customers

),

sales_by_customer AS (

  {#Calculates total sales per customer from 'join_orders_customers_1'.#}
  SELECT 
    C_NAME,
    SUM(AMOUNT) AS TOTAL_SALES
  
  FROM join_orders_customers_1
  
  GROUP BY C_NAME

),

order_by_total_sales_desc AS (

  {#Sorts 'sales_by_customer' by total sales in descending order.#}
  SELECT * 
  
  FROM sales_by_customer
  
  ORDER BY TOTAL_SALES DESC

),

fetch_next_15_rows AS (

  {#Retrieves the next 15 rows from 'order_by_total_sales_desc'.#}
  SELECT * 
  
  FROM order_by_total_sales_desc
  
  FETCH NEXT 15 ROWS ONLY

)

SELECT *

FROM fetch_next_15_rows
