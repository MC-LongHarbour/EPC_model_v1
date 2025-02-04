
with rm_latest as (

    select * from {{ ref('latest_rm_urn') }} 
    where UPRN IS NOT NULL
),

epc_uprn as (

    select * from {{ ref('dim_uprn') }}
    where datasource = 'EPC'
)


SELECT rm_latest.*,
CASE WHEN epc_uprn.UPRN is null then 'NO' ELSE 'YES' end as MATCH_EPC,
epc_uprn.UPRN AS EPC_UPRN,
epc_uprn.ADDRESSID AS EPC_ADDRESSID


FROM rm_latest
LEFT JOIN epc_uprn
ON rm_latest.UPRN = epc_uprn.UPRN

WHERE MATCH_EPC = 'NO'

