
with rm_latest as (

    select rm.*,
    multi.uprn AS multi_uprn
    from {{ ref('latest_rm_urn') }} rm
    left join {{ ref('dim_uprn') }} multi on rm.uprn = multi.uprn
    where rm.UPRN IS NOT NULL
    and multi.datasource = 'RIGHTMOVE'
   
),

epc_uprn as (

    select * from {{ ref('dim_uprn') }}
    where datasource = 'EPC'
    and multi_uprn is not null  -- we do not use UPRN to match addresses with multiple URNs as they are flats and could fall into House report
)


SELECT rm_latest.*,
CASE WHEN epc_uprn.UPRN is null then 'NO' ELSE 'YES' end as MATCH_EPC,
epc_uprn.UPRN AS EPC_UPRN,
epc_uprn.ADDRESSID AS EPC_ADDRESSID


FROM rm_latest
LEFT JOIN epc_uprn
ON rm_latest.UPRN = epc_uprn.UPRN

--WHERE MATCH_EPC = 'YES'

