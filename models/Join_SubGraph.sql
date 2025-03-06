{{
  config({    
    "alias": "customer_order_view"
  })
}}

WITH test_csv AS (

  SELECT * 
  
  FROM {{ ref('test_csv')}}

)

SELECT *

FROM test_csv
