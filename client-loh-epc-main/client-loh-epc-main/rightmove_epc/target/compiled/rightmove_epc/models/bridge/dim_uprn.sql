-- WE DO NOT INCLUDE LISTING / BUILDING REF AS THIS WILL CREATE DUPLICATE UPRNS


with epc as (

   select distinct
    epc.uprn,
    epc.addressid,
    epc.ADDRESS,
    'EPC' AS datasource,
    epc.POSTCODE,
    case when multi.uprn is null then NULL else 1 end as MULTI_UPRN

    from ANALYTICS_DEV.dbt_melissa_rm_epc.stg_epc_certs epc
    left join ANALYTICS_DEV.dbt_melissa_rm_epc.epc_flats_count multi on epc.uprn = multi.uprn

    where epc.REMOVE_FROM_RM_MATCH = 0
    AND epc.UPRN IS NOT NULL
    
),

rightmove as (

 select distinct
    rm.uprn,
    rm.addressid,
    concat(rm.ADDRESS_1,',',rm.ADDRESS_2) as ADDRESS,
    'RIGHTMOVE' AS datasource,
    rm.FULL_POSTCODE AS POSTCODE,
    multi.LISTING_COUNT AS MULTI_UPRN

    from ANALYTICS_DEV.dbt_melissa_rm_epc.stg_rightmove rm
    left join ANALYTICS_DEV.dbt_melissa_rm_epc.false_listings_count multi on rm.uprn = multi.uprn
    WHERE rm.UPRN IS NOT NULL


),

final as (

    select * from epc
    union all
    select * from rightmove
)

select distinct * from final