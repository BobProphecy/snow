{{
  config({    
    "materialized": "table",
    "alias": "demo_br"
  })
}}

WITH SalesModel AS (

  WITH HW_ORDERS AS (
  
    SELECT * 
    
    FROM {{ source('BOBW.HELLOWORLD', 'HW_ORDERS') }}
  
  ),
  
  HW_CUSTOMERS AS (
  
    SELECT * 
    
    FROM {{ source('BOBW.HELLOWORLD', 'HW_CUSTOMERS') }}
  
  ),
  
  customer_order_details AS (
  
    {#Compiles detailed customer information alongside their order history for better customer insights.#}
    SELECT 
      in1.CUSTOMER_ID AS CUSTOMER_ID,
      in1.FIRST_NAME AS FIRST_NAME,
      in1.LAST_NAME AS LAST_NAME,
      in1.PHONE AS PHONE,
      in1.EMAIL AS EMAIL,
      in1.COUNTRY_CODE AS COUNTRY_CODE,
      in1.ACCOUNT_OPEN_DATE AS ACCOUNT_OPEN_DATE,
      in1.ACCOUNT_FLAGS AS ACCOUNT_FLAGS,
      in0.ORDER_ID AS ORDER_ID,
      in0.AMOUNT AS AMOUNT,
      in0.ORDER_STATUS AS ORDER_STATUS,
      in0.ORDER_CATEGORY AS ORDER_CATEGORY,
      in0.ORDER_DATE AS ORDER_DATE
    
    FROM HW_ORDERS AS in0
    INNER JOIN HW_CUSTOMERS AS in1
       ON in0.CUSTOMER_ID = in1.CUSTOMER_ID
  
  )
  
  SELECT * 
  
  FROM customer_order_details

),

sales_customer_details AS (

  {#Compiles customer sales data, including full names and company domains from email addresses.#}
  SELECT 
    CUSTOMER_ID AS CUSTOMER_ID,
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS full_name,
    ORDER_ID AS ORDER_ID,
    AMOUNT AS AMOUNT,
    SPLIT(EMAIL, '@')[1] AS company_name
  
  FROM SalesModel

),

sales_summary_by_customer AS (

  SELECT 
    FULL_NAME,
    COMPANY_NAME,
    SUM(AMOUNT) AS SUM_AMOUNT,
    COUNT(ORDER_ID) AS ORDER_COUNT
  
  FROM sales_customer_details
  
  GROUP BY 
    FULL_NAME, COMPANY_NAME

),

total_sales_summary AS (

  SELECT 
    FULL_NAME,
    COMPANY_NAME,
    ROUND(SUM_AMOUNT, 2) AS TOTAL_SALES,
    ORDER_COUNT
  
  FROM sales_summary_by_customer

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
