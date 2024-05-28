WITH stooges AS (

  SELECT * 
  
  FROM {{ ref('stooges')}}

)

SELECT *

FROM stooges
