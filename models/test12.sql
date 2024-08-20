WITH bobw_helloworld_hw_customers AS (

  SELECT * 
  
  FROM {{ source('BOBW.HELLOWORLD', 'HW_CUSTOMERS') }}

),

bobw_helloworld_hw_orders AS (

  SELECT * 
  
  FROM {{ source('BOBW.HELLOWORLD', 'HW_ORDERS') }}

),

sales_by_customer AS (

  {#Calculates total sales and order count for each customer, sorted by total sales in descending order. Returns the top 25 customers.#}
  SELECT 
    CONCAT(c.FIRST_NAME, ' ', c.LAST_NAME) AS FULL_NAME,
    COUNT(o.ORDER_ID) AS ORDER_COUNT,
    ROUND(SUM(o.AMOUNT), 2) AS TOTAL_SALES
  
  FROM bobw_helloworld_hw_customers AS c
  JOIN bobw_helloworld_hw_orders AS o
     ON c.CUSTOMER_ID = o.CUSTOMER_ID
  
  GROUP BY FULL_NAME
  
  ORDER BY TOTAL_SALES DESC
  
  LIMIT 25

)

SELECT *

FROM sales_by_customer
