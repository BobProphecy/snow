WITH DEDUP_TEST AS (

  SELECT * 
  
  FROM {{ source('BOBW.DEMO_OUTPUT', 'DEDUP_TEST') }}

),

dbt_deduplicate AS (

  {{ dbt_utils.deduplicate(relation = 'DEDUP_TEST', partition_by = 'USER_ID', order_by = 'DATE DESC') }}

),

deduplicated_events AS (

  {#Creates a deduplicated list of events with corresponding user IDs, event types, versions, and dates.#}
  SELECT 
    USER_ID,
    EVENT,
    VERSION,
    DATE AS version_date
  
  FROM dbt_deduplicate AS deduplicated_dedup_test

),

add_dbt_fx AS (

  {#Adds a new column 'version_doy' to the deduplicated events table, representing the day of the year for the 'VERSION_DATE'.#}
  SELECT 
    USER_ID AS USER_ID,
    EVENT AS EVENT,
    VERSION AS VERSION,
    VERSION_DATE AS VERSION_DATE,
    {{ dbt_date.day_of_year('VERSION_DATE') }} AS version_doy
  
  FROM deduplicated_events

)

SELECT *

FROM add_dbt_fx
