with total_epc as (

    select 
    'EPC' as SOURCE,
    count(*) as total_records,
    count(BUILDING_REFERENCE_NUMBER) as total_uid,
    count(UPRN) as total_uprn,
    count(distinct UPRN) as unique_uprn,
    count(addressid) as total_addressid,
    count(distinct addressid) as unique_addressid,
    count(distinct UPRN) + count(distinct addressid) unique_address_uprn


    
    from ANALYTICS_DEV.dbt_melissa_rm_epc.stg_epc_certs
),

total_rm as (
    
    select 
    'RIGHTMOVE' as SOURCE,
    count(*) as total_records,
    count(LISTING_ID) as total_uid,
    count(UPRN) as total_uprn,
    count(distinct UPRN) as unique_uprn,
    count(addressid) as total_addressid,
    count(distinct addressid) as unique_addressid,
    count(distinct UPRN) + count(distinct addressid) unique_address_uprn


    
    from ANALYTICS_DEV.dbt_melissa_rm_epc.stg_rightmove

)

select * from total_epc
union all
select * from total_rm