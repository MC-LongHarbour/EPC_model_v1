
with rm as (

    select * from {{ ref('stg_rightmove') }}
    where UPRN IS NULL

),



epc_address as (

    select * from {{ ref('dim_addressid') }}
    where datasource = 'EPC'
    
)


SELECT rm.*,
CASE WHEN epc_address.ADDRESSID is null then 'NO' ELSE 'YES' end as MATCH_EPC,
epc_address.ADDRESSID AS EPC_ADDRESSID,
epc_address.UPRN AS EPC_UPRN


FROM rm
LEFT JOIN epc_address
ON rm.addressid = epc_address.addressid
and rm.FULL_POSTCODE = epc_address.POSTCODE
