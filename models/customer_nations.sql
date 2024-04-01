

WITH nations AS (

  SELECT * 
  
  FROM {{ ref('nations')}}

),

CUSTOMER AS (

  SELECT * 
  
  FROM {{ source('SNOWFLAKE_SAMPLE_DATA.TPCH_SF10', 'CUSTOMER') }}

),

nations_CUSTOMER AS (

  SELECT * 
  
  FROM nations
  INNER JOIN CUSTOMER
     ON nations.n_nationkey = CUSTOMER.C_NATIONKEY

),

Aggregate_1 AS (

  SELECT 
    any_value(N_NATIONKEY) AS nation_key,
    any_value(N_NAME) AS nation_name,
    COUNT(DISTINCT C_CUSTKEY) AS count_customer
  
  FROM nations_CUSTOMER
  
  GROUP BY N_NATIONKEY

),

OrderBy_1 AS (

  SELECT * 
  
  FROM Aggregate_1 AS in0
  
  ORDER BY COUNT_CUSTOMER DESC

)

SELECT *

FROM OrderBy_1
