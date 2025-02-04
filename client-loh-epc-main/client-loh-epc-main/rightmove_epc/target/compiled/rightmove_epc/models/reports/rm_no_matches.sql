with addr as (

    select distinct
   -- LISTING_ID,
    ADDRESSID, 
    ADDRESS_1,
    ADDRESS_2,
    FULL_POSTCODE, --- DOESNT LOOK CORRECT
    UPRN,
    LOCAL_AUTHORITY_CODE,
    LOCAL_AUTHORITY,
    GOV_REGION_CODE,
    FLOOR_AREA,
    FLOOR_LEVEL,
    EPC_UPRN,
    EPC_ADDRESSID
    
    from ANALYTICS_DEV.dbt_melissa_rm_epc.address_match
    where MATCH_EPC = 'NO' 
),

uprn as (

    select distinct
    
  --  LISTING_ID,
    ADDRESSID, 
    ADDRESS_1,
    ADDRESS_2,
    FULL_POSTCODE, --- DOESNT LOOK CORRECT
    UPRN,
    LOCAL_AUTHORITY_CODE,
    LOCAL_AUTHORITY,
    GOV_REGION_CODE,
    FLOOR_AREA,
    FLOOR_LEVEL,
    EPC_UPRN::VARCHAR AS EPC_UPRN,
    EPC_ADDRESSID
    
     from ANALYTICS_DEV.dbt_melissa_rm_epc.uprn_match
    where MATCH_EPC = 'NO'
),

uprn_address as (

        select 
    distinct
  --  LISTING_ID,
    ADDRESSID, 
    ADDRESS_1,
    ADDRESS_2,
    FULL_POSTCODE, --- DOESNT LOOK CORRECT
    UPRN,
    LOCAL_AUTHORITY_CODE,
    LOCAL_AUTHORITY,
    GOV_REGION_CODE,
    FLOOR_AREA,
    FLOOR_LEVEL,
    EPC_UPRN::VARCHAR AS EPC_UPRN,
    EPC_ADDRESSID
    
     from ANALYTICS_DEV.dbt_melissa_rm_epc.uprn_address_match
    where MATCH_EPC = 'NO'
),

final as (

select 'NO ADDRESS MATCH' AS MATCH_RESULT, * from addr
union all
select 'NO UPRN MATCH' AS MATCH_RESULT, * from uprn
union select 'NO ADDRESS OR UPRN MATCH' AS MATCH_RESULT, * from uprn_address

)

select distinct * from final