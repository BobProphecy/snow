{{
  config({    
    "materialized": "table"
  })
}}

WITH nations AS (

  SELECT * 
  
  FROM {{ ref('nations')}}

),

CUSTOMER AS (

  SELECT * 
  
  FROM {{ source('SNOWFLAKE_SAMPLE_DATA.TPCH_SF10', 'CUSTOMER') }}

),

CUSTOMER_nations AS (

  SELECT * 
  
  FROM nations
  INNER JOIN CUSTOMER
     ON CUSTOMER.C_NATIONKEY = nations.n_nationkey

),

customer_nations_group_by_nation AS (

  SELECT 
    any_value(N_NAME) AS N_NAME,
    any_value(C_NAME) AS C_NAME,
    COUNT(C_CUSTKEY) AS C_CUSTKEY
  
  FROM CUSTOMER_nations
  
  GROUP BY N_NATIONKEY

)

SELECT *

FROM customer_nations_group_by_nation
