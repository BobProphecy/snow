{{
  config({    
    "materialized": "table"
  })
}}

WITH bobw_helloworld_hw_customers AS (

  SELECT * 
  
  FROM {{ source('BOBW.HELLOWORLD', 'HW_CUSTOMERS') }}

),

bobw_helloworld_hw_orders AS (

  SELECT * 
  
  FROM {{ source('BOBW.HELLOWORLD', 'HW_ORDERS') }}

),

order_customer_details AS (

  SELECT 
    bobw_helloworld_hw_orders.ORDER_ID,
    bobw_helloworld_hw_orders.CUSTOMER_ID,
    bobw_helloworld_hw_orders.ORDER_STATUS,
    bobw_helloworld_hw_orders.ORDER_CATEGORY,
    bobw_helloworld_hw_orders.ORDER_DATE,
    bobw_helloworld_hw_orders.AMOUNT,
    bobw_helloworld_hw_customers.FIRST_NAME,
    bobw_helloworld_hw_customers.LAST_NAME,
    bobw_helloworld_hw_customers.PHONE,
    bobw_helloworld_hw_customers.EMAIL,
    bobw_helloworld_hw_customers.COUNTRY_CODE,
    bobw_helloworld_hw_customers.ACCOUNT_OPEN_DATE,
    bobw_helloworld_hw_customers.ACCOUNT_FLAGS
  
  FROM bobw_helloworld_hw_orders
  INNER JOIN bobw_helloworld_hw_customers
     ON bobw_helloworld_hw_orders.CUSTOMER_ID = bobw_helloworld_hw_customers.CUSTOMER_ID

),

order_customer_info AS (

  {#Compiles customer order information, including full names and order amounts.#}
  SELECT 
    CUSTOMER_ID AS CUSTOMER_ID,
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS full_name,
    ORDER_ID AS ORDER_ID,
    AMOUNT AS AMOUNT
  
  FROM order_customer_details

),

customer_order_summary AS (

  SELECT 
    FULL_NAME,
    SUM(AMOUNT) AS SUM_AMOUNT,
    COUNT(ORDER_ID) AS ORDER_COUNT
  
  FROM order_customer_info
  
  GROUP BY FULL_NAME

),

total_sales_summary AS (

  SELECT 
    FULL_NAME,
    ROUND(SUM_AMOUNT, 2) AS TOTAL_SALES,
    ORDER_COUNT
  
  FROM customer_order_summary

),

total_sales_desc AS (

  SELECT * 
  
  FROM total_sales_summary
  
  ORDER BY TOTAL_SALES DESC

),

limited_rows AS (

  SELECT * 
  
  FROM total_sales_desc
  
  FETCH NEXT 25 ROWS ONLY

)

SELECT *

FROM limited_rows
