{{
  config({    
    "materialized": "table"
  })
}}

WITH imported_customer_data AS (

  {#Imports customer data from the HelloWorld source for further analysis.#}
  SELECT * 
  
  FROM {{ source('BOBW.HELLOWORLD', 'HW_CUSTOMERS') }}

),

imported_order_data AS (

  {#Imports order data from the HelloWorld source for further analysis.#}
  SELECT * 
  
  FROM {{ source('BOBW.HELLOWORLD', 'HW_ORDERS') }}

),

detailed_order_customer_info AS (

  {#Compiles detailed order and customer information for better service and follow-up.#}
  SELECT 
    HW_ORDERS.CUSTOMER_ID AS CUSTOMER_ID,
    HW_CUSTOMERS.FIRST_NAME AS FIRST_NAME,
    HW_CUSTOMERS.LAST_NAME AS LAST_NAME,
    HW_ORDERS.ORDER_ID AS ORDER_ID,
    HW_ORDERS.AMOUNT AS AMOUNT,
    HW_CUSTOMERS.PHONE AS PHONE,
    HW_CUSTOMERS.EMAIL AS EMAIL,
    HW_CUSTOMERS.COUNTRY_CODE AS COUNTRY_CODE,
    HW_CUSTOMERS.ACCOUNT_OPEN_DATE AS ACCOUNT_OPEN_DATE,
    HW_CUSTOMERS.ACCOUNT_FLAGS AS ACCOUNT_FLAGS,
    HW_ORDERS.ORDER_STATUS AS ORDER_STATUS,
    HW_ORDERS.ORDER_DATE AS ORDER_DATE,
    HW_ORDERS.ORDER_CATEGORY AS ORDER_CATEGORY
  
  FROM imported_order_data AS HW_ORDERS
  INNER JOIN imported_customer_data AS HW_CUSTOMERS
     ON HW_ORDERS.CUSTOMER_ID = HW_CUSTOMERS.CUSTOMER_ID

),

consolidated_customer_orders AS (

  {#Streamlines customer order data by consolidating names and relevant order details.#}
  SELECT 
    CUSTOMER_ID AS CUSTOMER_ID,
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME,
    ORDER_ID AS ORDER_ID,
    AMOUNT AS AMOUNT
  
  FROM detailed_order_customer_info AS by_CUSTOMER_ID

),

sales_summary_by_customer AS (

  {#Summarizes sales data by customer, detailing order count and total sales.#}
  SELECT 
    any_value(CUSTOMER_ID) AS CUSTOMER_ID,
    any_value(FULL_NAME) AS FULL_NAME,
    COUNT(ORDER_ID) AS order_count,
    SUM(AMOUNT) AS total_sales
  
  FROM consolidated_customer_orders AS clean_up
  
  GROUP BY 
    CUSTOMER_ID, FULL_NAME

),

top_performing_products AS (

  {#Ranks sales data to highlight top-performing products or services.#}
  SELECT * 
  
  FROM sales_summary_by_customer AS Aggregate_sales
  
  ORDER BY TOTAL_SALES DESC

),

top_10_sales_orders AS (

  {#Identifies the top 10 sales orders for focused analysis.#}
  SELECT * 
  
  FROM top_performing_products AS in0
  
  LIMIT 150

)

SELECT *

FROM top_10_sales_orders
