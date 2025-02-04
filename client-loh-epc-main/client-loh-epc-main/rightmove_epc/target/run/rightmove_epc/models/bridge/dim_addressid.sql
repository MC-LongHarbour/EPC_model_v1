
  create or replace   view ANALYTICS_DEV.dbt_melissa_rm_epc.dim_addressid
  
   as (
    -- WE DO NOT INCLUDE LISTING / BUILDING REF AS THIS WILL CREATE DUPLICATE ADDRESS'

with epc as (

    select distinct
    uprn,
    addressid,
    ADDRESS,
    'EPC' AS datasource,
    POSTCODE
    from ANALYTICS_DEV.dbt_melissa_rm_epc.stg_epc_certs 
    where ADDRESSID IS NOT NULL

),

rightmove as (

 select distinct
    uprn,
    addressid,
    concat(ADDRESS_1,',',ADDRESS_2) as ADDRESS,
    'RIGHTMOVE' AS datasource,
    FULL_POSTCODE AS POSTCODE
    from ANALYTICS_DEV.dbt_melissa_rm_epc.stg_rightmove
    WHERE ADDRESSID IS NOT NULL

),

final as (

    select * from epc
    union all
    select * from rightmove
)

select * from final
where addressid is not null
  );

