-- WE DO NOT INCLUDE LISTING / BUILDING REF AS THIS WILL CREATE DUPLICATE ADDRESS'

with epc as (

    select distinct
    uprn,
    addressid,
    ADDRESS,
    'EPC' AS datasource,
    POSTCODE
    from {{ ref('stg_epc_certs') }} 
    where ADDRESSID IS NOT NULL

),

rightmove as (

 select distinct
    uprn,
    addressid,
    concat(ADDRESS_1,',',ADDRESS_2) as ADDRESS,
    'RIGHTMOVE' AS datasource,
    FULL_POSTCODE AS POSTCODE
    from {{ ref('stg_rightmove') }}
    WHERE ADDRESSID IS NOT NULL

),

final as (

    select * from epc
    union all
    select * from rightmove
)

select * from final
where addressid is not null