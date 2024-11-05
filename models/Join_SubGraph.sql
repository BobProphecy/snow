{{
  config({    
    "alias": "customer_order_view"
  })
}}

WITH Subgraph_1 AS (

  WITH HW_ORDERS AS (
  
    SELECT * 
    
    FROM {{ source('BOBW.HELLOWORLD', 'HW_ORDERS') }}
  
  ),
  
  HW_CUSTOMERS AS (
  
    SELECT * 
    
    FROM {{ source('BOBW.HELLOWORLD', 'HW_CUSTOMERS') }}
  
  ),
  
  customer_order_details AS (
  
    {#Compiles comprehensive customer and order information for detailed analysis.#}
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
      in0.ORDER_STATUS AS ORDER_STATUS,
      in0.ORDER_CATEGORY AS ORDER_CATEGORY,
      in0.ORDER_DATE AS ORDER_DATE,
      in0.AMOUNT AS SALES_AMOUNT
    
    FROM HW_ORDERS AS in0
    INNER JOIN HW_CUSTOMERS AS in1
       ON in0.CUSTOMER_ID = in1.CUSTOMER_ID
  
  )
  
  SELECT * 
  
  FROM customer_order_details

)

SELECT *

FROM Subgraph_1
