{{
  config({    
    "materialized": "table",
    "alias": "demo_br"
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

)

SELECT *

FROM order_customer_details
