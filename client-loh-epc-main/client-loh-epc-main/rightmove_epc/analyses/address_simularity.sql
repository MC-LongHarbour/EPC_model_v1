
with rm as (

    select * from {{ ref('stg_rightmove') }}
    where UPRN IS NULL
),

epc_address as (

    select * from {{ ref('dim_addressid') }}
    where datasource = 'EPC'
)


SELECT rm.*,epc_address.addressid as EPC_ADDRESSID
FROM rm
JOIN epc_address
ON JAROWINKLER_SIMILARITY(rm.addressid, epc_address.addressid) = 1

LIMIT 2
