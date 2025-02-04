with house_addmatch as (

    select 
    distinct
    am.ADDRESSID as RM_ADDRESSID,
    ADDRESS_1,
    ADDRESS_2,
    FULL_POSTCODE,
    am.UPRN AS RM_UPRN,
    am.LOCAL_AUTHORITY_CODE,
    GOV_REGION_CODE,
    FLOOR_AREA,
    BEDROOM,
    PROPERTY_TYPE_1,
    PROPERTY_TYPE_2,
    COMBINED_PROPERTY_TYPE,
    epc.UPRN as EPC_UPRN,
    UPRN_SOURCE,
    TOTAL_FLOOR_AREA, 
    ADDRESS, 
    ADDRESS1, 
    ADDRESS2, 
    ADDRESS3, 
    POSTCODE, 
    BUILDING_REFERENCE_NUMBER, -- EPC UID
    epc.ADDRESSID AS EPC_ADDRESSID,
    epc.FLOOR_LEVEL,
    epc.FLAT_TOP_STOREY,
    epc.FLAT_STOREY_COUNT,
    epc.PROPERTY_TYPE

     from ANALYTICS_DEV.dbt_melissa_rm_epc.address_match am
    inner join ANALYTICS_DEV.dbt_melissa_rm_epc.stg_epc_certs epc on am.EPC_ADDRESSID = epc.ADDRESSID
    and am.FULL_POSTCODE = epc.POSTCODE
    where MATCH_EPC = 'YES'
    and COMBINED_PROPERTY_TYPE not in ('HOUSE / FLAT SHARE','FLAT / APARTMENT')

),

house_uprnmatch as (

    select 
    distinct
    --count(LISTING_ID) as TOTAL_LISTINGS,
    am.ADDRESSID as RM_ADDRESSID,
    ADDRESS_1,
    ADDRESS_2,
    FULL_POSTCODE,
    am.UPRN AS RM_UPRN, -- NULL
    am.LOCAL_AUTHORITY_CODE,
    GOV_REGION_CODE,
    FLOOR_AREA,
    BEDROOM,
  --  am.FLOOR_LEVEL as RM_FLOOR_LEVEL,
    PROPERTY_TYPE_1,
    PROPERTY_TYPE_2,
    COMBINED_PROPERTY_TYPE,
    epc.UPRN as EPC_UPRN,
    UPRN_SOURCE,
    TOTAL_FLOOR_AREA, 
    ADDRESS, 
    ADDRESS1, 
    ADDRESS2, 
    ADDRESS3, 
    POSTCODE, 
    BUILDING_REFERENCE_NUMBER, -- EPC UID
    epc.ADDRESSID AS EPC_ADDRESSID,
    -- REMOVE_FROM_RM_MATCH,
    epc.FLOOR_LEVEL,
    epc.FLAT_TOP_STOREY,
    epc.FLAT_STOREY_COUNT,
    epc.PROPERTY_TYPE

    

    from ANALYTICS_DEV.dbt_melissa_rm_epc.uprn_match am
    inner join ANALYTICS_DEV.dbt_melissa_rm_epc.latest_epc_urn epc on am.EPC_UPRN = epc.UPRN

    where MATCH_EPC = 'YES'
    and COMBINED_PROPERTY_TYPE not in ('HOUSE / FLAT SHARE','FLAT / APARTMENT')
  -- AND RM_UPRN = 100030719363

),

final as (

select * from house_uprnmatch

union all

select * from house_addmatch

)

select distinct * from final


/*
--THIS IS USED FOR A TEST
select RM_UPRN,COUNT(BUILDING_REFERENCE_NUMBER)
from house_uprnmatch
WHERE RM_UPRN IS NOT NULL
GROUP BY 1
HAVING COUNT(BUILDING_REFERENCE_NUMBER) >1
*/