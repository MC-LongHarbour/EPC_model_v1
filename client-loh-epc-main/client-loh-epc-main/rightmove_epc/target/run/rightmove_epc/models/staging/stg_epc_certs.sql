
  create or replace   view ANALYTICS_DEV.dbt_melissa_rm_epc.stg_epc_certs
  
   as (
    WITH epc_certs as (
    
    select 
    UPRN,
    LODGEMENT_DATE,
    UPRN_SOURCE,
    TOTAL_FLOOR_AREA, 
    ADDRESS, 
    ADDRESS1, 
    ADDRESS2, 
    ADDRESS3, 
    POSTCODE, 
   -- COUNTY,
    LOCAL_AUTHORITY as LOCAL_AUTHORITY_CODE,
    BUILDING_REFERENCE_NUMBER, -- EPC UID
    UPPER(CASE WHEN (UPPER(ADDRESS1) LIKE 'FLAT%' OR UPPER(ADDRESS1) LIKE 'UNIT%') or UPPER(ADDRESS1) LIKE 'ROOM%' 
    THEN TRIM(REPLACE(REPLACE(CONCAT(ADDRESS),','),' '))
    ELSE trim(replace(replace(ADDRESS1,' '),',')) END) AS ADDRESSID,
    CASE WHEN UPRN is null and addressid is null THEN 1 else 0 end as REMOVE_FROM_RM_MATCH,
    FLOOR_LEVEL,
    FLAT_TOP_STOREY,
    FLAT_STOREY_COUNT,
    PROPERTY_TYPE
 from  RAW.EPC_TEST_DATA.EPC_CERTIFICATES 

)

SELECT * FROM epc_certs
where REMOVE_FROM_RM_MATCH = 0
  );

